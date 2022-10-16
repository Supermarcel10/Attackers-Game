final class Player {
  static final color COL = #008000, OUTLINE = 0;
  static final float BOLD = 2.0;
  final int SIZE;
 
  private boolean isLeft, isRight, isUp, isDown, isShooting, isDead;
  int x, y, nextShot = 0;
  float rotMod = 1;
  final int v;
  
  Player(int xx, int yy, int d, int vv) {
    x = xx;
    y = yy;
    SIZE = d;
    v = vv;
  }
 
  void display() {
    if (isDead) {
      fill(255, 0, 0, 120);
      rect(0, 0, width, height);
      fill(255, 255, 255);
      textAlign(CENTER, CENTER);
      textSize(128);
      text("GAME OVER", width / 2, height / 2);
      return;
    }
    
    // Animate projectiles
    if (isShooting) {
      changeRot();
      proj.setStartLocation(x, y, PI * rotMod);
    }
    
    proj.update();
    proj.display();
    
    // Display the player
    pushMatrix();
    fill(#62FF8D);
    stroke(8);
    ellipse(x, y, SIZE, SIZE);
    popMatrix();
  }
  
  
  void move() {
    x = constrain(x + v * (int(isRight) - int(isLeft)), SIZE >> 1, width  - (SIZE >> 1));
    y = constrain(y + v * (int(isDown) - int(isUp)),   SIZE >> 1, height - (SIZE >> 1));
  }
  
  
  void changeRot() {
    if (isLeft && isUp) rotMod = 1.25;
    else if (isUp && isRight) rotMod = 1.75;
    else if (isRight && isDown) rotMod = 2.25;
    else if (isDown && isLeft) rotMod = 2.75;
    else if (isLeft) rotMod = 1;
    else if (isUp) rotMod = 1.5;
    else if (isRight) rotMod = 2;
    else if (isDown) rotMod = 2.5;
  }
  
  
  void die() {
    x = -2000;
    y = -2000;
  }
  

  boolean setMove(int k, boolean b) {
  switch (k) {
    case 'W':
      isUp = b;
      changeRot();
      return isUp;
    case 'S':
       isDown = b;
       changeRot();
       return isDown;
    case 'A':
       isLeft = b;
       changeRot();
       return isLeft;
    case 'D':
      isRight = b;
      changeRot();
      return isRight;
    case ' ':
      return isShooting = b;
    default:
      return b;
    }
  }
}
