PImage bg;
Board p1Board, p2Board;
Scoreboard mainScoreboard;
MissileManager missileManager;

String gamePhase = "placement";
int currentPlayer = 1;
int placingShipIndex = 0;
Ship draggingShip = null;

Ship[] p1Ships, p2Ships;
int[] shipLengths = {5, 4, 3, 3, 2};
String[] shipNames = {"Carrier(5)", "Battleship(4)", "Cruiser(3)", "Submarine(3)", "Destroyer(2)"};

void setup() {
  size(800, 800);
  noStroke();
  // bg = loadImage("Final CS background.png");
p1Board = new Board(82, 82);
p2Board = new Board(82, 82);
  mainScoreboard = new Scoreboard(10);
  missileManager = new MissileManager();
 
  p1Ships = createFleet();
  p2Ships = createFleet();
}

Ship[] createFleet() {
  Ship[] fleet = new Ship[shipLengths.length];
  for (int i = 0; i < shipLengths.length; i++) {
    fleet[i] = new Ship(i, 0, shipLengths[i]);
  }
  return fleet;
}

void draw() {
  background(30, 60, 90);

  if (gamePhase.equals("placement")) {
    drawPlacementPhase();
  } else if (gamePhase.equals("switchScreen")) {
    drawSwitchScreen();
  } else if (gamePhase.equals("play")) {
    drawPlayPhase();
  } else if (gamePhase.equals("gameOver")) {
    drawGameOver();
  }
}

void drawPlacementPhase() {
  Ship[] fleet = (currentPlayer == 1) ? p1Ships : p2Ships;

  fill(255);
  textSize(22);
  textAlign(CENTER);
  text("Player " + currentPlayer + " — Place Your Ships", width / 2, 40);
  textSize(14);
  text("Drag ship onto grid   |   R to rotate   |   ENTER when done", width / 2, 62);

  p1Board.boardTiles();
  p1Board.yScaleBoardTiles();

  for (int i = 0; i < placingShipIndex; i++) {
    fleet[i].draw();
  }

  if (draggingShip != null) {
    int tx = screenToTile(mouseX - 82);
    int ty = screenToTile(mouseY - 82);
    draggingShip.x = tx;
    draggingShip.y = ty;
    boolean valid = draggingShip.inBounds() && !overlapsFleet(draggingShip, fleet, placingShipIndex);
    draggingShip.drawPreview(valid);
  } else if (placingShipIndex < fleet.length) {
    fleet[placingShipIndex].drawPreview(true);
  }

  drawShipSidebar(fleet);

  if (placingShipIndex >= fleet.length) {
    fill(24, 212, 12);
    textSize(18);
    textAlign(CENTER);
    text("All ships placed! Press ENTER to lock in.", width / 2, height - 30);
  }
  textAlign(LEFT);
}

void drawShipSidebar(Ship[] fleet) {
  fill(255, 255, 255, 40);
  rect(10, 80, 65, 660, 8);
  fill(255);
  textSize(11);
  textAlign(CENTER);
  text("SHIPS", 42, 100);
  for (int i = 0; i < fleet.length; i++) {
    float y = 115 + i * 115;
    if (i < placingShipIndex) fill(24, 212, 12, 180);
    else if (i == placingShipIndex) fill(255, 220, 50);
    else fill(255, 255, 255, 80);
    rect(15, y, 55, 20, 4);
    fill(30);
    textSize(9);
    text(shipNames[i], 42, y + 14);
  }
  textAlign(LEFT);
}

void drawSwitchScreen() {
  fill(10, 20, 40);
  rect(0, 0, width, height);
  fill(255);
  textSize(32);
  textAlign(CENTER);
  text("PASS THE SCREEN", width / 2, height / 2 - 60);
  textSize(20);
  text("Player " + currentPlayer + "'s Turn", width / 2, height / 2);
  fill(200);
  textSize(15);
  text("Press ENTER when ready", width / 2, height / 2 + 50);
  textAlign(LEFT);
}

void drawPlayPhase() {
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("Player " + currentPlayer + " — Fire!", width / 2, 40);
  textSize(13);
  text("Click the grid to fire a missile", width / 2, 60);
  textAlign(LEFT);

  p1Board.boardTiles();
  p1Board.yScaleBoardTiles();

  Ship[] enemyFleet = (currentPlayer == 1) ? p2Ships : p1Ships;
  for (Ship s : enemyFleet) {
    if (s.sunk) s.draw();
  }

  missileManager.drawShots(currentPlayer);
  mainScoreboard.draw();
}

void drawGameOver() {
  fill(10, 20, 40);
  rect(0, 0, width, height);
  int winner = mainScoreboard.getWinner();
  fill(255, 220, 50);
  textSize(48);
  textAlign(CENTER);
  text("Player " + winner + " Wins!", width / 2, height / 2 - 40);
  fill(255);
  textSize(18);
  text("P1: " + mainScoreboard.player1Score + "   P2: " + mainScoreboard.player2Score, width / 2, height / 2 + 20);
  fill(200);
  textSize(14);
  text("Press R to restart", width / 2, height / 2 + 70);
  textAlign(LEFT);
}

void mousePressed() {
  if (gamePhase.equals("placement")) {
    Ship[] fleet = (currentPlayer == 1) ? p1Ships : p2Ships;
    if (placingShipIndex < fleet.length) {
      draggingShip = fleet[placingShipIndex];
    }
  } else if (gamePhase.equals("play")) {
    int tx = screenToTile(mouseX - 82);
    int ty = screenToTile(mouseY - 82);
    if (tx >= 0 && tx < 10 && ty >= 0 && ty < 10) {
      if (!missileManager.alreadyShot(currentPlayer, tx, ty)) {
        Ship[] enemyFleet = (currentPlayer == 1) ? p2Ships : p1Ships;
        boolean hit = false;
        for (Ship s : enemyFleet) {
          if (s.checkHit(tx, ty)) { hit = true; break; }
        }
        missileManager.recordShot(currentPlayer, tx, ty, hit);
        if (hit) mainScoreboard.addPoint(currentPlayer);
        else mainScoreboard.removePoint(currentPlayer);

        if (mainScoreboard.checkWin()) {
          gamePhase = "gameOver";
        } else {
          currentPlayer = (currentPlayer == 1) ? 2 : 1;
          gamePhase = "switchScreen";
        }
      }
    }
  }
}

void mouseReleased() {
  if (gamePhase.equals("placement") && draggingShip != null) {
    Ship[] fleet = (currentPlayer == 1) ? p1Ships : p2Ships;
    int tx = screenToTile(mouseX - 82);
    int ty = screenToTile(mouseY - 82);
    draggingShip.x = tx;
    draggingShip.y = ty;
    if (draggingShip.inBounds() && !overlapsFleet(draggingShip, fleet, placingShipIndex)) {
      placingShipIndex++;
    } else {
      draggingShip.x = placingShipIndex;
      draggingShip.y = 0;
    }
    draggingShip = null;
  }
}

void keyPressed() {
  if (gamePhase.equals("placement")) {
    Ship[] fleet = (currentPlayer == 1) ? p1Ships : p2Ships;
    if (key == 'r' || key == 'R') {
      if (placingShipIndex < fleet.length) fleet[placingShipIndex].rotate();
    }
    if (keyCode == ENTER || keyCode == RETURN) {
      if (placingShipIndex >= fleet.length) {
        if (currentPlayer == 1) {
          currentPlayer = 2;
          placingShipIndex = 0;
          gamePhase = "switchScreen";
        } else {
          currentPlayer = 1;
          gamePhase = "switchScreen";
        }
      }
    }
  } else if (gamePhase.equals("switchScreen")) {
    if (keyCode == ENTER || keyCode == RETURN) {
      if (currentPlayer == 2 && placingShipIndex < p2Ships.length) {
        gamePhase = "placement";
      } else {
        gamePhase = "play";
      }
    }
  } else if (gamePhase.equals("gameOver")) {
    if (key == 'r' || key == 'R') restartGame();
  }
}

void restartGame() {
  mainScoreboard = new Scoreboard(10);
  missileManager = new MissileManager();
  p1Ships = createFleet();
  p2Ships = createFleet();
  currentPlayer = 1;
  placingShipIndex = 0;
  draggingShip = null;
  gamePhase = "placement";
}

int screenToTile(float px) {
  return (int)(px / 64.5);
}

boolean overlapsFleet(Ship s, Ship[] fleet, int upTo) {
  for (int i = 0; i < upTo; i++) {
    for (int tx = s.x; tx < (s.horizontal ? s.x + s.length : s.x + 1); tx++) {
      for (int ty = s.y; ty < (s.horizontal ? s.y + 1 : s.y + s.length); ty++) {
        if (fleet[i].overlaps(tx, ty)) return true;
      }
    }
  }
  return false;
}
