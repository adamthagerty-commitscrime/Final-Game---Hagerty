public class Ship {
  int x, y;         
  int length;       
  boolean horizontal; 
  int hits;        
  boolean sunk;

  public Ship(int x, int y, int length) {
    this.x = x;
    this.y = y;
    this.length = length;
    this.horizontal = true;
    this.hits = 0;
    this.sunk = false;
  }

  void draw() {
    fill(150, 75, 0);
    if (horizontal) {
      rect(x * 100 + 15, y * 100 + 5, (length * 100) - 15, 85);
    } else {
      rect(x * 100 + 15, y * 100 + 5, 85, (length * 100) - 15);
    }
  }

  void rotate() {
    horizontal = !horizontal;
  }

  void move(int newX, int newY) {
    x = newX;
    y = newY;
  }

  boolean checkHit(int tileX, int tileY) {
    if (horizontal) {
      if (tileY == y && tileX >= x && tileX < x + length) {
        hits++;
        if (hits >= length) sunk = true;
        return true;
      }
    } else {
      if (tileX == x && tileY >= y && tileY < y + length) {
        hits++;
        if (hits >= length) sunk = true;
        return true;
      }
    }
    return false;
  }
}
