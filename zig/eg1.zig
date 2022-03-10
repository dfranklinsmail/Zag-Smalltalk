const expect = @import("std").testing.expect;
const assert = @import("std").debug.assert;
const stdout = @import("std").io.getStdOut().writer();
const Symbol = struct {
    usingnamespace @import("symbol.zig");
    const add = @This().symbol_of(42,0);
    const add_ = @This().symbol_of(43,1);
};
const O = @import("object.zig");
const Nil = O.Nil;
const Object = O.Object;
const Dispatch = @import("dispatch.zig");
const returnE = Dispatch.returnE;
const Thread = @import("thread.zig");
const NEGATIVE_INF = @as(u64,0xfff0000000000000);

test "printing objects" {
    const from = Object.from;
    try stdout.print("-inf, 0x{x} {}\n", .{NEGATIVE_INF,@bitCast(f64,NEGATIVE_INF)});
    const x = O.Header{ .numSlots = 17, .format = 10, .hash=0x123, .classIndex = 35 };
    try stdout.print("ptr, {} {}\n", .{from(&x),from(&x).fullHash()});
//    try stdout.print("ptr deref, {}\n", .{from(&x).as_pointer().*});
    try stdout.print("yourself, {} {}\n", .{Symbol.yourself,Symbol.yourself.fullHash()});
    try stdout.print("add, {} {}\n", .{Symbol.add,Symbol.add.fullHash()});
    try stdout.print("add_, {} {}\n", .{Symbol.add_,Symbol.add_.fullHash()});
    try stdout.print("3.14, {} {}\n", .{@bitCast(f64,from(3.14)),from(3.14).fullHash()});
    try stdout.print("1.0, {} {}\n", .{@bitCast(f64,from(1.0)),from(1.0).fullHash()});
    try stdout.print("2.0, {} {}\n", .{@bitCast(f64,from(2.0)),from(2.0).fullHash()});
    try stdout.print("42, {} {}\n", .{from(42),from(42).fullHash()});
    try stdout.print("-17, {} {}\n", .{from(-17),from(-17).fullHash()});
    try stdout.print("false, {} {}\n", .{from(false),from(false).fullHash()});
    try stdout.print("true, {} {}\n", .{from(true),from(true).fullHash()});
    try stdout.print("Nil, {} {}\n", .{Nil,Nil.fullHash()});
}

fn test1(stack : [*]Object, heap : [*]Object) returnE {
    assert(@ptrToInt(stack)>@ptrToInt(heap));
    return .Normal;
}

//test "run test1" {
//    var thread = Thread.Thread.init();
//    try expect(test1(thread.stack,thread.heap)==.Normal);
//}

test "hashes" {
    const from = Object.from;
    const bigPrime : u64 = 16777213;//4294967291;
    const mod : u64 = 128;
    try stdout.print("42 {}\n",.{@bitCast(u64,from(42))%bigPrime%mod});
    try stdout.print("-17 {}\n",.{@bitCast(u64,from(-17))%bigPrime%mod});
    try stdout.print("3.14 {}\n",.{@bitCast(u64,from(3.14))%bigPrime%mod});
    try stdout.print("1.0 {}\n",.{@bitCast(u64,from(1.0))%bigPrime%mod});
    try stdout.print("2.0 {}\n",.{@bitCast(u64,from(2.0))%bigPrime%mod});
    try stdout.print("true {}\n",.{@bitCast(u64,from(true))%bigPrime%mod});
    try stdout.print("false {}\n",.{@bitCast(u64,from(false))%bigPrime%mod});
    try stdout.print("nil {}\n",.{@bitCast(u64,Nil)%bigPrime%mod});
    try expect(@bitCast(u64,Nil)%bigPrime%mod != @bitCast(u64,from(false))%bigPrime%mod);
}