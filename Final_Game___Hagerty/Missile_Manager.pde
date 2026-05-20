public class MissileManager {
  ArrayList<int[]> p1Shots;
  ArrayList<int[]> p2Shots;

  public MissileManager() {
    p1Shots = new ArrayList<int[]>();
    p2Shots = new ArrayList<int[]>();
  }

  void recordShot(int player, int tx, int ty, boolean hit) {
    int[] shot = {tx, ty, hit ? 1 : 0};
    if (player == 1) p1Shots.add(shot);
    else p2Shots.add(shot);
  }

  boolean alreadyShot(int player, int tx, int ty) {
    ArrayList<int[]> shots = (player == 1) ? p1Shots : p2Shots;
    for (int[] s : shots) {
      if (s[0] == tx && s[1] == ty) return true;
    }
    return false;
  }

  void drawShots(int player) {
    ArrayList<int[]> shots = (player == 1) ? p1Shots : p2Shots;
    for (int[] s : shots) {
      float px = s[0] * 64.5 + 82 + 32;
      float py = s[1] * 64.5 + 82 + 32;
      boolean hit = s[2] == 1;
      if (hit) {
        fill(220, 50, 30); ellipse(px, py, 40, 40);
        fill(255, 180, 0); ellipse(px, py, 20, 20);
      } else {
        fill(200, 220, 255, 200); ellipse(px, py, 30, 30);
        fill(255, 255, 255, 120); ellipse(px, py, 14, 14);
      }
    }
  }

  void reset() {
    p1Shots.clear();
    p2Shots.clear();
  }
}
