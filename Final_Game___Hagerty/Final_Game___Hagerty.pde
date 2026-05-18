PImage bg;
Board mainBoard;
Scoreboard mainScoreboard;
void setup() {
  size (800,800);
  mainBoard = new Board();
  noStroke();
    bg = loadImage("Final CS background.png");


}

void draw (){
  image(bg, 0, 0, width, height);
  //background(100);

  mainBoard.boardTiles();
  mainBoard.yScaleBoardTiles();
  fill(24, 212, 12);
  //rect(400,0,5,800); //midline
 
 

 
}
