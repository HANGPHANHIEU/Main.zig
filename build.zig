const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable(.{
        .name = "tiktok-api",
        .root_source_file = .{ .path = "main.zig" },
        .target = target,
        .optimize = mode,
    });

    exe.linkLibC = true;
    exe.linkSystemLibrary("c");

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
