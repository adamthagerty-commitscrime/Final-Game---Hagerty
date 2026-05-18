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

  boolean checkWin() {
    return player1Score >= scoreToWin || player2Score >= scoreToWin;
  }

  int getWinner() {
    if (player1Score >= scoreToWin) return 1;
    if (player2Score >= scoreToWin) return 2;
    return 0; 
  }

  void draw() {
    fill(255);
    textSize(20);
    text("P1: " + player1Score, 20, 30);
    text("P2: " + player2Score, 450, 30);
  }
} 
