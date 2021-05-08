#![feature(test)]
#![allow(soft_unstable)]
#![allow(warnings)]
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn fibonacci(n: u64) -> u64 {
    match n {
        0 => 1,
        1 => 1,
        n => fibonacci(n-1) + fibonacci(n-2),
    }
}

fn criterion_benchmark(c: &mut Criterion) {
    c.bench_function("fib 20", |b| b.iter(|| fibonacci(black_box(20))));
}

criterion_group!(fib, criterion_benchmark);

use std::time::{Duration, Instant};
const iterations : i64 = 1_000_000_000;
#[inline(never)]
fn null_call(i:i64) -> i64 {
    i
}
#[inline(never)]
fn shift_call(i:i64) -> i64 {
    i<<13>>16
}
#[inline(never)]
fn shift2_call(i:i64) -> i64 {
    i<<13>>16<<3
}
#[inline(never)]
fn mask_call(i:i64) -> i64 {
    i&0xfffffffffff8_i64
}
#[inline(never)]
fn mask2_call(i:i64) -> i64 {
    (i<<13>>13)&0xfffffffffff8_i64
}
pub fn timing_null(c: &mut Criterion) {
    c.bench_function("null", |b| b.iter(||  null_call(iterations)));
}
pub fn timing_shift(c: &mut Criterion) {
    c.bench_function("shift", |b| b.iter(||  shift_call(iterations)));
}
pub fn timing_shift2(c: &mut Criterion) {
    c.bench_function("shift2", |b| b.iter(||  shift2_call(iterations)));
}
pub fn timing_mask(c: &mut Criterion) {
    c.bench_function("mask2", |b| b.iter(||  mask_call(iterations)));
}
pub fn timing_mask2(c: &mut Criterion) {
    c.bench_function("mask2", |b| b.iter(||  mask2_call(iterations)));
}
criterion_group!(extract,timing_null,timing_shift,timing_shift2,timing_mask,timing_mask2);

/*
 * once_cell               time:   [569.59 ps 580.20 ps 595.87 ps]
 * static_init             time:   [2.5625 ns 2.5805 ns 2.6013 ns]
 * lazy_static             time:   [785.32 ps 807.08 ps 837.60 ps]
 * lazy_init               time:   [2.9278 ns 2.9578 ns 2.9887 ns]
 */
extern crate once_cell;
static v_once_cell: once_cell::sync::Lazy<bool> = once_cell::sync::Lazy::new(|| {
    true
});

#[inline(never)]
fn access_once_cell() -> bool {
    *v_once_cell
}
fn bench_once_cell(c: &mut Criterion) {
    c.bench_function("once_cell", |b| b.iter(|| access_once_cell()));
}


extern crate lazy_init;
extern crate static_init;
#[static_init::dynamic]
static v_static_init: bool = true;

#[inline(never)]
fn access_static_init() -> bool {
    *v_static_init
}
fn bench_static_init(c: &mut Criterion) {
    c.bench_function("static_init", |b| b.iter(|| access_static_init()));
}


#[static_init::dynamic]
static v_lazy_init: lazy_init::Lazy<bool> = lazy_init::Lazy::default();

#[inline(never)]
fn access_lazy_init() -> bool {
    *v_lazy_init.get().unwrap()
}
fn bench_lazy_init(c: &mut Criterion) {
    *v_lazy_init.get_or_create(|| true);
    c.bench_function("lazy_init", |b| b.iter(|| access_lazy_init()));
}


#[macro_use]
extern crate lazy_static;
lazy_static!{
    static ref v_lazy_static: bool = true;
}
#[inline(never)]
fn access_lazy_static() -> bool {
    *v_lazy_static
}
fn bench_lazy_static(c: &mut Criterion) {
    c.bench_function("lazy_static", |b| b.iter(|| access_lazy_static()));
}

criterion_group!(accesses, bench_once_cell,bench_static_init,bench_lazy_static,bench_lazy_init);
criterion_main!(/*benches,accesses,*/extract);

