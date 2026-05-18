public class Board {

  public Board() {
  }
  void boardTiles() {
    fill(24, 212, 12);
    for (int i = 0; i < 11; i++) {
      rect(82 + (i*64.5), 80, 5, 653);
    }
  }
  
  
  
  
  void yScaleBoardTiles() {
    fill(24, 212, 12);
    for (int i = 0; i < 11; i++) {
      rect(82, 82 + (i*64.5), 730, 5);
    }
 }
  
  
}
