const std = @import("std");

const ThreadValues = struct {
    start: usize,
    end: usize,
    result: usize,
};

fn sum_of_squares(num: usize) usize {
    var re: usize = 0;
    var i: usize = 0;
    while (i <= num) : (i = i + 1) {
        re = re + (i * i);
    }
    return re;
}

fn run(tv: *ThreadValues) void {
    var i: usize = tv.start;
    while (i <= tv.end) : (i = i + 1) {
        tv.result = tv.result + sum_of_squares(i);
    }
    std.debug.print("Sum of squares from {any} to {any} is {any}!\n", .{ tv.start, tv.end, tv.result });
}

pub fn main() !void {
    const ranges = [5][2]usize{
        [_]usize{ 100, 200 },
        [_]usize{ 201, 300 },
        [_]usize{ 301, 400 },
        [_]usize{ 401, 500 },
        [_]usize{ 501, 600 },
    };
    var threads: [5]std.Thread = undefined;
    var thread_values: [5]ThreadValues = undefined;
    var i: usize = 0;
    while (i < 5) : (i = i + 1) {
        thread_values[i] = ThreadValues{
            .start = ranges[i][0],
            .end = ranges[i][1],
            .result = 0,
        };
        threads[i] = try std.Thread.spawn(.{}, run, .{&thread_values[i]});
    }
    i = 0;
    while (i < 5) : (i = i + 1) {
        threads[i].join();
    }
    var total: usize = 0;
    i = 0;
    while (i < 5) : (i = i + 1) {
        total = total + thread_values[i].result;
    }
    std.debug.print("Total Sum is: {any}\n", .{total});
}
