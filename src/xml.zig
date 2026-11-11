//! Minimal XML DOM parser, just enough for the Khronos registry files
//! (vk.xml / video.xml): elements, attributes, text, comments, the
//! `<?xml ?>` declaration and the five predefined entities plus numeric
//! character references. Everything is allocated in a caller-provided arena.
const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Attribute = struct {
    name: []const u8,
    value: []const u8,
};

pub const Node = union(enum) {
    element: *Element,
    text: []const u8,
};

pub const Element = struct {
    tag: []const u8,
    attributes: []const Attribute = &.{},
    children: []const Node = &.{},

    pub fn attr(self: *const Element, name: []const u8) ?[]const u8 {
        for (self.attributes) |a| {
            if (std.mem.eql(u8, a.name, name)) return a.value;
        }
        return null;
    }

    /// First direct child element with the given tag.
    pub fn child(self: *const Element, tag: []const u8) ?*Element {
        for (self.children) |c| switch (c) {
            .element => |e| if (std.mem.eql(u8, e.tag, tag)) return e,
            .text => {},
        };
        return null;
    }

    /// Concatenated text of the first child element with `tag`.
    pub fn childText(self: *const Element, tag: []const u8) ?[]const u8 {
        const c = self.child(tag) orelse return null;
        return c.firstText();
    }

    /// The first text node directly inside this element.
    pub fn firstText(self: *const Element) ?[]const u8 {
        for (self.children) |c| switch (c) {
            .text => |t| return t,
            .element => {},
        };
        return null;
    }

    pub fn elements(self: *const Element, tag: ?[]const u8) ElementIterator {
        return .{ .nodes = self.children, .tag = tag };
    }
};

pub const ElementIterator = struct {
    nodes: []const Node,
    tag: ?[]const u8,
    index: usize = 0,

    pub fn next(it: *ElementIterator) ?*Element {
        while (it.index < it.nodes.len) {
            const n = it.nodes[it.index];
            it.index += 1;
            switch (n) {
                .element => |e| {
                    if (it.tag) |t| {
                        if (!std.mem.eql(u8, e.tag, t)) continue;
                    }
                    return e;
                },
                .text => {},
            }
        }
        return null;
    }
};

pub const ParseError = error{ InvalidXml, OutOfMemory };

/// Parses `source` and returns the root element. All memory is owned by `arena`.
pub fn parse(arena: Allocator, source: []const u8) ParseError!*Element {
    var p: Parser = .{ .arena = arena, .src = source };
    p.skipProlog();
    const root = try p.parseElement();
    return root;
}

const Parser = struct {
    arena: Allocator,
    src: []const u8,
    pos: usize = 0,

    fn peek(p: *Parser) ?u8 {
        return if (p.pos < p.src.len) p.src[p.pos] else null;
    }

    fn startsWith(p: *Parser, s: []const u8) bool {
        return std.mem.startsWith(u8, p.src[p.pos..], s);
    }

    fn skipWhitespace(p: *Parser) void {
        while (p.peek()) |c| : (p.pos += 1) {
            if (!std.ascii.isWhitespace(c)) break;
        }
    }

    fn skipPast(p: *Parser, terminator: []const u8) ParseError!void {
        const idx = std.mem.indexOfPos(u8, p.src, p.pos, terminator) orelse return error.InvalidXml;
        p.pos = idx + terminator.len;
    }

    /// Skips `<?xml ... ?>`, comments and whitespace before the root element.
    fn skipProlog(p: *Parser) void {
        while (true) {
            p.skipWhitespace();
            if (p.startsWith("<?")) {
                p.skipPast("?>") catch return;
            } else if (p.startsWith("<!--")) {
                p.skipPast("-->") catch return;
            } else if (p.startsWith("<!")) {
                p.skipPast(">") catch return;
            } else return;
        }
    }

    fn parseName(p: *Parser) ParseError![]const u8 {
        const start = p.pos;
        while (p.peek()) |c| : (p.pos += 1) {
            if (std.ascii.isWhitespace(c) or c == '=' or c == '>' or c == '/') break;
        }
        if (p.pos == start) return error.InvalidXml;
        return p.src[start..p.pos];
    }

    fn parseElement(p: *Parser) ParseError!*Element {
        if (p.peek() != '<') return error.InvalidXml;
        p.pos += 1;
        const el = try p.arena.create(Element);
        el.* = .{ .tag = try p.parseName() };

        var attrs: std.ArrayList(Attribute) = .empty;
        while (true) {
            p.skipWhitespace();
            const c = p.peek() orelse return error.InvalidXml;
            if (c == '/') {
                // Self-closing tag.
                if (!p.startsWith("/>")) return error.InvalidXml;
                p.pos += 2;
                el.attributes = try attrs.toOwnedSlice(p.arena);
                return el;
            }
            if (c == '>') {
                p.pos += 1;
                break;
            }
            const name = try p.parseName();
            p.skipWhitespace();
            if (p.peek() != '=') return error.InvalidXml;
            p.pos += 1;
            p.skipWhitespace();
            const quote = p.peek() orelse return error.InvalidXml;
            if (quote != '"' and quote != '\'') return error.InvalidXml;
            p.pos += 1;
            const end = std.mem.indexOfScalarPos(u8, p.src, p.pos, quote) orelse return error.InvalidXml;
            const raw = p.src[p.pos..end];
            p.pos = end + 1;
            try attrs.append(p.arena, .{ .name = name, .value = try decodeEntities(p.arena, raw) });
        }
        el.attributes = try attrs.toOwnedSlice(p.arena);

        var children: std.ArrayList(Node) = .empty;
        while (true) {
            if (p.pos >= p.src.len) return error.InvalidXml;
            if (p.startsWith("</")) {
                p.pos += 2;
                const close = try p.parseName();
                if (!std.mem.eql(u8, close, el.tag)) return error.InvalidXml;
                p.skipWhitespace();
                if (p.peek() != '>') return error.InvalidXml;
                p.pos += 1;
                break;
            } else if (p.startsWith("<!--")) {
                try p.skipPast("-->");
            } else if (p.startsWith("<![CDATA[")) {
                const start = p.pos + "<![CDATA[".len;
                const end = std.mem.indexOfPos(u8, p.src, start, "]]>") orelse return error.InvalidXml;
                try children.append(p.arena, .{ .text = p.src[start..end] });
                p.pos = end + 3;
            } else if (p.startsWith("<?")) {
                try p.skipPast("?>");
            } else if (p.peek() == '<') {
                try children.append(p.arena, .{ .element = try p.parseElement() });
            } else {
                const start = p.pos;
                const end = std.mem.indexOfScalarPos(u8, p.src, p.pos, '<') orelse return error.InvalidXml;
                p.pos = end;
                try children.append(p.arena, .{ .text = try decodeEntities(p.arena, p.src[start..end]) });
            }
        }
        el.children = try children.toOwnedSlice(p.arena);
        return el;
    }
};

fn decodeEntities(arena: Allocator, raw: []const u8) ParseError![]const u8 {
    if (std.mem.indexOfScalar(u8, raw, '&') == null) return raw;
    var out: std.ArrayList(u8) = .empty;
    var i: usize = 0;
    while (i < raw.len) {
        if (raw[i] != '&') {
            try out.append(arena, raw[i]);
            i += 1;
            continue;
        }
        const semi = std.mem.indexOfScalarPos(u8, raw, i, ';') orelse return error.InvalidXml;
        const ent = raw[i + 1 .. semi];
        i = semi + 1;
        if (std.mem.eql(u8, ent, "lt")) {
            try out.append(arena, '<');
        } else if (std.mem.eql(u8, ent, "gt")) {
            try out.append(arena, '>');
        } else if (std.mem.eql(u8, ent, "amp")) {
            try out.append(arena, '&');
        } else if (std.mem.eql(u8, ent, "quot")) {
            try out.append(arena, '"');
        } else if (std.mem.eql(u8, ent, "apos")) {
            try out.append(arena, '\'');
        } else if (ent.len > 1 and ent[0] == '#') {
            const cp = if (ent[1] == 'x')
                std.fmt.parseInt(u21, ent[2..], 16) catch return error.InvalidXml
            else
                std.fmt.parseInt(u21, ent[1..], 10) catch return error.InvalidXml;
            var buf: [4]u8 = undefined;
            const n = std.unicode.utf8Encode(cp, &buf) catch return error.InvalidXml;
            try out.appendSlice(arena, buf[0..n]);
        } else return error.InvalidXml;
    }
    return out.items;
}

test "parse elements, attributes, text, entities, comments" {
    var arena_state: std.heap.ArenaAllocator = .init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    const root = try parse(arena,
        \\<?xml version="1.0" encoding="UTF-8"?>
        \\<!-- leading comment -->
        \\<registry>
        \\  <type category="struct" name="VkFoo">
        \\    <member optional="true">const <type>void</type>* <name>pNext</name></member>
        \\    <!-- inner comment -->
        \\    <member><type>uint32_t</type> <name>x</name>:24</member>
        \\  </type>
        \\  <enum value="&quot;VK_KHR_surface&quot;" name="N"/>
        \\</registry>
    );
    try std.testing.expectEqualStrings("registry", root.tag);
    const ty = root.child("type").?;
    try std.testing.expectEqualStrings("VkFoo", ty.attr("name").?);
    var it = ty.elements("member");
    const m0 = it.next().?;
    try std.testing.expectEqualStrings("true", m0.attr("optional").?);
    try std.testing.expectEqualStrings("pNext", m0.childText("name").?);
    const m1 = it.next().?;
    try std.testing.expectEqualStrings("uint32_t", m1.childText("type").?);
    try std.testing.expect(it.next() == null);
    try std.testing.expectEqualStrings("\"VK_KHR_surface\"", root.child("enum").?.attr("value").?);
}
