const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = std.http.Server.init(allocator, .{
        .reuse_address = true,
    });

    const port = std.os.getenv("PORT") orelse "8080";
    const parsed_port = try std.fmt.parseInt(u16, port, 10);


    try server.listen(.{
        .address = try std.net.Address.parseIp("0.0.0.0", port),
    });

    std.debug.print("Server running on port {d}\n", .{port});

    while (true) {
        var res = try server.accept(.{});
        defer res.deinit();

        try res.respond(
            "Hello from Zig Online 🚀",
            .{ .status = .ok },
        );
    }
}
