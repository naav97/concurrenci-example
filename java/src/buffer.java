import java.util.ArrayList;

public class buffer {

  private ArrayList<int[]> space;
  private int num_mess;

  public buffer(int size, int max_mess_size) {
    this.num_mess = 0;
    this.space = new ArrayList<int[]>();
  }
}
