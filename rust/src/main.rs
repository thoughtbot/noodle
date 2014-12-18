extern crate noodle;

use std::io;

#[cfg(not(test))]
fn main() {
    let input = io::stdin().read_to_string().ok().expect("Failed to read history");
    let history = noodle::analyze_history(input.as_slice());

    for command in history.iter() {
        println!("{}: {} times", command.name, command.count);
    }
}
