public class Board {
  float x, y;
  
  public Board(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void boardTiles() {
    fill(126, 176, 154);
    for (int i = 0; i < 11; i++) {
      rect(x + (i * 64.5), y - 2, 5, 653);
    }
  }

  void yScaleBoardTiles() {
    fill(126, 176, 154);
    for (int i = 0; i < 11; i++) {
      rect(x, y + (i * 64.5), 650, 5);
    }
  }
}
