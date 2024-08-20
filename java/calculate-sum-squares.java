class Sumthread extends Thread {
  private int start;
  private int end;
  private long result;

  public Sumthread(int pStart, int pEnd) {
    this.start = pStart;
    this.end = pEnd;
    this.result = 0;
  }

  private long sumOfSquare(int num) {
    long re = 0;
    for(int i = 1; i <= num; i++) {
      re += i*i;
    }
    return re;
  }

  public void run() {
    for(int i = this.start; i <= this.end; i++) {
      this.result += this.sumOfSquare(i);
    }
    System.out.println("Sum of squares from " + this.start + " to " + this.end + " is " + this.result + "!");
  }

  public long getResult() {
    return this.result;
  }
}

class Main {
  public static void main(String[] args) {
    int[][] ranges = {
      {100, 200},
      {201, 300},
      {301, 400},
      {401, 500},
      {501, 600},
    };
    Sumthread[] threads = new Sumthread[5];
    for(int i = 0; i < 5; i++) {
      threads[i] = new Sumthread(ranges[i][0], ranges[i][1]);
      threads[i].start();
    }
    for(int i = 0; i < 5; i++) {
      try {
        threads[i].join();
      }
      catch(InterruptedException e) {
        System.out.println(e);
      }
    }
    long total = 0;
    for(int i = 0; i < 5; i++) {
      total += threads[i].getResult();
    }
    System.out.println("Total Sum is: " + total);
  }
}
