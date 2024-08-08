import java.util.ArrayList;

public class buffer {

  private ArrayList<int[]> in;
  private ArrayList<Integer> out;
  private int num_in;
  private int num_out;

  public buffer() {
    this.num_in = 0;
    this.num_out = 0;
    this.in = new ArrayList<int[]>();
    this.out = new ArrayList<Integer>();
  }

  public void addIn(int[] mess) {
    synchronized(this) {
      this.in.add(mess);
      this.num_in++;
      notifyAll();
    }
  }

  public void addOut(int mess) {
    synchronized(this) {
      this.out.add(mess);
      this.num_out++;
      notifyAll();
    }
  }
}
