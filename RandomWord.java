import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdRandom;

public class RandomWord {
    public static void main(String[] args) {
        String champion = "";
        int i = 0;
        while (!StdIn.isEmpty()) {
            i += 1;
            String tmp = StdIn.readString();
            if (StdRandom.bernoulli(1.0 / i)) {
                champion = tmp;
            }
        }
        StdOut.println(champion);
    }
}
