public class Board {

  public Board() {
  }
  void boardTiles() {
    fill(24, 212, 12);
    for (int i = 0; i < 8; i++) {
      rect(0 + (i*100), 0, 15, 800);
    }
  }
  
  
  
  
  void yScaleBoardTiles() {
    fill(24, 212, 12);
    for (int i = 0; i < 8; i++) {
      rect(0, 0 + (i*100), 800, 15);
    }
  }
}
