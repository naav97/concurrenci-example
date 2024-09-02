package main

import (
  "fmt"
  "sync"
)

type ThreadValues struct {
  start int
  end int
  result int64
}

func sum_of_squares(num int) int64 {
  var re int64
  for i := 0; i <= num; i++ {
    re += int64(i * i)
  }
  return re
}

func (tv *ThreadValues) run(wg *sync.WaitGroup) {
  defer wg.Done()
  for i := tv.start; i <= tv.end; i++ {
    tv.result += sum_of_squares(i)
  }
  fmt.Printf("Sum of squares from %d to %d is %d!\n", tv.start, tv.end, tv.result)
}

func (tv *ThreadValues) get_result() int64 {
  return tv.result
}

func main() {
  ranges := [][]int{
    {100, 200},
    {201, 300},
    {301, 400},
    {401, 500},
    {501, 600},
  }

  var threads []*ThreadValues
  var wg sync.WaitGroup

  for _, r := range ranges {
    thread := &ThreadValues{start: r[0], end: r[1], result: 0}
    threads = append(threads, thread)
    wg.Add(1)
    go thread.run(&wg)
  }

  wg.Wait()

  var total int64
  for _, tv := range threads {
    total += tv.get_result()
  }
  fmt.Printf("Total Sum is: %d\n", total)
}
