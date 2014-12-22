class Brick {

  int size = 30;
  int bX;
  int bY;
  boolean die = false; 
  boolean red = false;
  boolean blue = false;
  boolean yellow = false;   // bonus: the yellow brick can slow down the ball
  boolean green = false;    // bonus: the green brick can speed up the ball

  Brick(int x, int y) {
    bX = x;
    bY = y;
  }

  void display() {
    rectMode(CENTER);
    fill(240, 240, 240);
    if (red == true){
      fill(255, 98, 103);
    }
    if (blue == true){
      fill(100, 98, 255);
    }
    if (yellow == true){
      fill(248, 255, 59);
    }
    if (green == true){
      fill(105, 240, 17);
    }
    rect(bX, bY, size, size);
  }

  
}
