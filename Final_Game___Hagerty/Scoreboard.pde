public class Scoreboard {
  int player1Score;
  int player2Score;
  int scoreToWin;

  public Scoreboard(int scoreToWin) {
    this.player1Score = 0;
    this.player2Score = 0;
    this.scoreToWin = scoreToWin;
  }

  void addPoint(int player) {
    if (player == 1) player1Score++;
    else if (player == 2) player2Score++;
  }

  void removePoint(int player) {
    if (player == 1 && player1Score > 0) player1Score--;
    else if (player == 2 && player2Score > 0) player2Score--;
  }

  boolean checkWin() {
    return player1Score >= scoreToWin || player2Score >= scoreToWin;
  }

  int getWinner() {
    if (player1Score >= scoreToWin) return 1;
    if (player2Score >= scoreToWin) return 2;
    return 0;
  }

  void draw() {
    fill(0, 0, 0, 120);
    rect(0, height - 55, width, 55);
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text("P1: " + player1Score, 30, height - 22);
    textAlign(RIGHT);
    text("P2: " + player2Score, width - 30, height - 22);
    textAlign(CENTER);
    fill(200);
    textSize(13);
    text("First to " + scoreToWin + "  |  Hit +1  Miss -1", width / 2, height - 22);
    textAlign(LEFT);
  }
}
