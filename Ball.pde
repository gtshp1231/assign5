class Ball{

  float x;
  float y;
  float xSpeed;
  float ySpeed;
  float size;
  int life;
  boolean start = false;
  
  boolean isHit(
        float circleX,
        float circleY,
        float radius,
        float rectangleX, // center X
        float rectangleY, // center Y
        float rectangleWidth,
        float rectangleHeight)
  {
      float circleDistanceX = abs(circleX - rectangleX);
      float circleDistanceY = abs(circleY - rectangleY);
   
      if (circleDistanceX > (rectangleWidth/2 + radius)) { return false; }
      if (circleDistanceY > (rectangleHeight/2 + radius)) { return false; }
   
      if (circleDistanceX <= (rectangleWidth/2)) { return true; }
      if (circleDistanceY <= (rectangleHeight/2)) { return true; }
   
      float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
                           pow(circleDistanceY - rectangleHeight/2, 2);
   
      return (cornerDistance_sq <= pow(radius,2));
  }
  
  
  void move(){
    if (start == true){
      x+=xSpeed;
      y+=ySpeed;
      if (x<0+size/2 || x>width-size/2){
        xSpeed *= -1;
      }
      if (y<0+size/2
      || isHit(x, y, size/2, bar.x, bar.y, bar.len, 5)){
        ySpeed *= -1;
      }
    }else{
      x = mouseX;
    }
  }
  void display(){
    fill(255);
    noStroke();
    ellipse(x,y,size,size);
  }
  

  
  Ball(int posX, int posY, int l){
    this.x = posX;
    this.y = posY;
    xSpeed = random(-3,3);
    ySpeed = -3;
    size = 10;
  }

}
