use std::io;

fn f(a: i32, b: i32) -> i32 {
    a + b
}

fn main() {
    let x = 3;
    f(1, 2);
    f(1, "abc");
}
