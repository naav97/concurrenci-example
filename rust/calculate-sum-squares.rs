use std::thread;

struct ThreadValues {
    start: usize,
    end: usize,
    result: usize,
}

fn sum_of_squares(num: usize) -> usize {
    let mut re = 0;
    for i in 0..=num {
        re += i * i;
    }
    return re;
}

impl ThreadValues {
    fn new(p_start: usize, p_end: usize) -> Self {
        Self {
            start: p_start,
            end: p_end,
            result: 0,
        }
    }
    fn run(&mut self) {
        for i in self.start..=self.end {
            self.result += sum_of_squares(i);
        }
        println!("Sum of squares from {} to {} id {}!", self.start, self.end, self.result);
    }
    fn get_result(&self) -> usize {
        self.result
    }
}

fn main() {
    let ranges: [[usize; 2]; 5] = [
        [100, 200],
        [201, 300],
        [301, 400],
        [401, 500],
        [501, 600],
    ];
    let mut handles = vec![];
    for i in 0..5 {
        let t = thread::spawn(move || {
            let mut thread = ThreadValues::new(ranges[i][0], ranges[i][1]);
            thread.run();
            thread
        });
        handles.push(t);
    }
    let mut threads: Vec<ThreadValues> = Vec::new();
    for h in handles {
        let tr = h.join().unwrap();
        threads.push(tr);
    }
    let mut total: usize = 0;
    for tv in threads {
        total = total + tv.get_result();
    }
    println!("Total Sum is: {}", total);
}
