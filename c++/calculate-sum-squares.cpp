#include <iostream>
#include <pthread.h>
using namespace std;

typedef struct {
  int start;
  int end;
  long result;
} ThreadValues ;

long sumOfSquares(int num) {
  long re = 0;
  for (int i = 0; i <= num; i++) {
    re += i * i;
  }
  return re;
}

void* run(void* arg) {
  ThreadValues* tv = (ThreadValues*)arg;
  for (int i = tv->start; i <= tv->end; i++) {
    tv->result += sumOfSquares(i);
  }
  cout << "Sum of squares from " << tv->start << " to " << tv->end << "is" << tv->result << endl;
  return NULL;
}

int main() {
  int ranges[5][2] = {
    {100, 200},
    {201, 300},
    {301, 400},
    {401, 500},
    {501, 600},
  };
  pthread_t threads[5];
  ThreadValues thread_values[5];
  for (int i = 0; i < 5; i++) {
    thread_values[i].start = ranges[i][0];
    thread_values[i].end = ranges[i][1];
    thread_values[i].result = 0;
    pthread_create(&threads[i], NULL, run, &thread_values[i]);
  }
  for (int i = 0; i < 5; i++) {
    pthread_join(threads[i], NULL);
  }
  long total = 0;
  for (int i = 0; i < 5; i++) {
    total += thread_values[i].result;
  }
  cout << "Total Sum is: " << total << endl;
}
