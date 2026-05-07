Board mainBoard;
Scoreboard mainScoreboard;
void setup() {
  size (800,800);
  mainBoard = new Board();
  noStroke();
}

void draw (){
  background(100);

  mainBoard.boardTiles();
  mainBoard.yScaleBoardTiles();
  fill(250);
  rect(400,0,15,800); //midline
 
}
