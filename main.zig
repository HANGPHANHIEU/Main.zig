const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello, World!\n");
}

const port = std.os.getenv("PORT") orelse "8080";
const parsed_port = try std.fmt.parseInt(u16, port, 10);
