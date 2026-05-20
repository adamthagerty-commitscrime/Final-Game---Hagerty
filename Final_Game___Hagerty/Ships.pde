public class Ship {
  int x, y;
  int length;
  boolean horizontal;
  int hits;
  boolean sunk;
  boolean[] hitLocation;

  public Ship(int x, int y, int length) {
    this.x = x;
    this.y = y;
    this.length = length;
    this.horizontal = true;
    this.hits = 0;
    this.sunk = false;
    this.hitLocation = new boolean[length];
  }

  void draw() {
    noStroke();
    for (int i = 0; i < length; i++) {
      fill(hitLocation[i] ? color(220, 30, 30) : color(150, 75, 0));
      if (horizontal) rect(x * 64.5 + 82 + (i * 64.5), y * 64.5 + 82, 62, 62, 4);
      else            rect(x * 64.5 + 82, y * 64.5 + 82 + (i * 64.5), 62, 62, 4);
    }
    if (sunk) {
      stroke(0); strokeWeight(3);
      if (horizontal) {
        float sx = x * 64.5 + 82, sy = y * 64.5 + 82;
        line(sx, sy, sx + length * 64.5, sy + 64.5);
        line(sx + length * 64.5, sy, sx, sy + 64.5);
      } else {
        float sx = x * 64.5 + 82, sy = y * 64.5 + 82;
        line(sx, sy, sx + 64.5, sy + length * 64.5);
        line(sx + 64.5, sy, sx, sy + length * 64.5);
      }
      noStroke();
    }
  }

  void drawPreview(boolean valid) {
    noStroke();
    fill(valid ? color(24, 212, 12, 160) : color(220, 30, 30, 160));
    for (int i = 0; i < length; i++) {
      if (horizontal) rect(x * 64.5 + 82 + (i * 64.5), y * 64.5 + 82, 62, 62, 4);
      else            rect(x * 64.5 + 82, y * 64.5 + 82 + (i * 64.5), 62, 62, 4);
    }
  }

  void rotate() { horizontal = !horizontal; }

  void move(int newX, int newY) { x = newX; y = newY; }

  boolean checkHit(int tileX, int tileY) {
    if (horizontal) {
      if (tileY == y && tileX >= x && tileX < x + length) {
        int seg = tileX - x;
        if (!hitLocation[seg]) { hitLocation[seg] = true; hits++; if (hits >= length) sunk = true; }
        return true;
      }
    } else {
      if (tileX == x && tileY >= y && tileY < y + length) {
        int seg = tileY - y;
        if (!hitLocation[seg]) { hitLocation[seg] = true; hits++; if (hits >= length) sunk = true; }
        return true;
      }
    }
    return false;
  }

  boolean overlaps(int tileX, int tileY) {
    if (horizontal) return tileY == y && tileX >= x && tileX < x + length;
    else            return tileX == x && tileY >= y && tileY < y + length;
  }

  boolean inBounds() {
    if (horizontal) return x >= 0 && x + length <= 10 && y >= 0 && y < 10;
    else            return y >= 0 && y + length <= 10 && x >= 0 && x < 10;
  }
}
