Ball ball;
Bar bar;
Brick[] bList;

//Game Status
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;
int status;             
int life;
int brickNum;
int brickDeadCount;
int [] selectRed = new int[4];
int [] selectBlue = new int[4];
int ran_r;     // ran_r to ran_g are variables which select functional bricks.
int ran_b;
int ran_y;     // bonus: the yellow brick can slow down the ball
int ran_g;     // bonus: the green brick can speed up the ball

void setup() {

  status = GAME_START;

  bList = new Brick[50];

  size(640, 480);
  background(0, 0, 0);
  rectMode(CENTER);

  bar = new Bar(80);
  ball = new Ball(mouseX, height-20, 3);
  
  reset();
}

void draw() {
  background(50, 50, 50);
  noStroke();

  switch(status) {

  case GAME_START:
    printText("Press ENTER to Start", height/2, 20);
    break;

  case GAME_PLAYING:
    background(50, 50, 50);

    drawLife();
    ball.display();
    ball.move();
    bar.display();
    bar.move();
    drawBrick();
    checkBrickDead();
    checkWinLose();
    if (ball.y - 90 >= height){
      ball.y = height - 20;
      life--;
      ball.start = false;
    }
    

    break;

  case GAME_WIN:
    printText("WINNER", height/2, 40);
    break;

  case GAME_LOSE:
    printText("You are dead!!", height/2, 40);
    break;
  }
}

void selectBrick(){
  for (int i=0; i<3; i++){
    ran_r = int(random(brickNum));
    ran_b = int(random(brickNum));
    selectRed[i] = ran_r;
    selectBlue[i] = ran_b;    
    if (ran_r == ran_b){
      i--;
    }
  }
  ran_y = int(random(brickNum));
  ran_g = int(random(brickNum));
}

/*---------Make Brick Function-------------*/
void brickMaker(int num, int numInRow) {
  for (int i=0; i < num; ++i){
    int row = int(i / numInRow);
    int col = int(i % numInRow);
    int x = 144 + (38*col);
    int y = 50 + (38*row);
    bList[i]= new Brick(x, y);
    for (int j=0; j<3; j++){
      if (i == selectRed[j]){
        bList[i].red = true;
      }
      if (i == selectBlue[j]){
        bList[i].blue = true;
      }
    }
      if (i == ran_y){
        bList[i].yellow = true;
      }
      if (i == ran_g){
        bList[i].green = true;
      }
  }
}

void drawLife() {
  fill(230, 74, 96);
  textSize(23);
  text("LIFE:", 36, 455);
  for (int i=0; i<life; i++){
    int x = i * 25;
    ellipse(78+x, 459, 15, 15);
  }
}


void drawBrick() {
  for (int i=0; i<bList.length; i++) {
    Brick brick = bList[i];
    if (brick!=null && !brick.die) { 
      brick.display(); 
    }
  }
}


void checkBrickDead() {
  for (int i=0; i<bList.length; i++) {
    Brick brick = bList[i];
      if (brick != null 
      /*------------Hit detect-------------*/ 
      && ball.y > bList[i].bY - bList[i].size/2
      && ball.y < bList[i].bY + bList[i].size/2
      && ((ball.x + ball.size/2 >= bList[i].bX - bList[i].size/2
      && ball.x + ball.size/2 <= bList[i].bX)
      || (ball.x - ball.size/2 <= bList[i].bX + bList[i].size/2
      && ball.x - ball.size/2 >= bList[i].bX))
       ) {
        removeBrick(bList[i]);
        brickDeadCount++;
        ball.xSpeed *= -1;
        for (int j=0; j<3; j++){
          if (i == selectRed[j]){
            bar.len -= 10;
          }
          if (i == selectBlue[j]){
            bar.len += 10;
          }
        }
        if (i == ran_y){
          ball.ySpeed /= 2;  // to make the ball 2x slow
        }
        if (i == ran_g){
          ball.ySpeed *= 2;  // to make the ball 2x fast
        }
      }
    
     if (brick != null 
      /*------------Hit detect-------------*/ 
      && ball.x > bList[i].bX - bList[i].size/2
      && ball.x < bList[i].bX + bList[i].size/2
      && ((ball.y + ball.size/2 >= bList[i].bY - bList[i].size/2
      && ball.y + ball.size/2 <= bList[i].bY)
      || (ball.y - ball.size/2 <= bList[i].bY + bList[i].size/2
      && ball.y - ball.size/2 >= bList[i].bY))
       ) {
        removeBrick(bList[i]);
        brickDeadCount++;
        ball.ySpeed *= -1;
        for (int j=0; j<3; j++){
          if (i == selectRed[j]){
            bar.len -= 10;
          }
          if (i == selectBlue[j]){
            bar.len += 10;
          }
        }
        if (i == ran_y){
          ball.ySpeed /= 2;
        }
        if (i == ran_g){
          ball.ySpeed *= 2;
        }
      }
   }
}

void checkWinLose() {
      if (brickDeadCount >= brickNum) {
        status = GAME_WIN;
      }
      if (life <= 0) {
        status = GAME_LOSE;   
  }
}

void printText(String title, int y, int size){
  fill(95, 194, 226);
  textAlign(CENTER, CENTER);
  textSize(size);
  text(title, width/2, y);
}



void removeBrick(Brick obj) {
  obj.die = true;
  obj.bX = 1000;
  obj.bY = 1000;
}

/*---------Reset Game-------------*/
void reset() {
  for (int i=0; i<bList.length-1; i++) {
    bList[i] = null;
  }

  life = 3;
  brickDeadCount = 0;
  brickNum = 50;
  ball.start = false;
  ball.y = height - 20;

  selectBrick();
  brickMaker(brickNum, 10);

}

void statusCtrl() {
  if (key == ENTER) {
    switch(status) {

    case GAME_START:
      status = GAME_PLAYING;
      break;
    case GAME_WIN:
      status = GAME_PLAYING;
      reset();
      break;
    case GAME_LOSE:
      status = GAME_PLAYING;
      reset();
      break;
    }
  }
}

void keyPressed() {
  statusCtrl();
}

void mousePressed(){
  ball.start = true;
}
