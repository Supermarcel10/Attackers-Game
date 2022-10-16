class Enemy {
  final int SIZE = 50;
  
  float x, y;
  float speedX, speedY;
  int health;
  String type;

  Enemy(int h, String t) {
    x = -1000;
    y = -1000;

    speedX = 0;
    speedY = 0;
    
    type = t;
    if (type == "basic") {
      health = h;
    } else if (type == "heavy") {
      health = round(h * random(1f, 2f));
    }
  }
  
  
  void die() {
    x = -1000;
    y = -1000;
    GH.enemiesRemaining--;
  }
  
  
  void spawn() {
    boolean dir = random(100) < 50, sideTop = random(100) < 50;
    
    if (sideTop && dir) {
      // TOP
      x = random(0, width);
      y = -20;
    } else if (sideTop && !dir) {
      // BOT
      x = random(0, width);
      y = height + 20;
    } else if (!sideTop && dir) {
      // LEFT
      x = -20;
      y = random(0, height);
    } else if (!sideTop && !dir) {
      // RIGHT
      x = width + 20;
      y = random(0, height);
    }
  }
  
  
  void update(float sx, float sy) {
    // Chase player only if nearby
    if (dist(x, y, sx, sy) < 2000) {
      if (abs(x - sx) < abs(y - sy)) {
        // Bigger gap on y axis
        if (y < sy) {
          // Enemy is above player
          speedX = 0;
          speedY = 2;
        } else {
          // Enemy is below player
          speedX = 0;
          speedY = -2;
        }
      } else {
        // Bigger gap on x axis
        if (x < sx) {
          // Enemy is left of player
          speedX = 2;
          speedY = 0;
        } else {
          // Enemy is right of player
          speedX = -2;
          speedY = 0;
        }
      }
    } else {
      // Not chasing the player
      speedX = 0;
      speedY = 0;
    }
    x+=speedX;
    y+=speedY;
  }
  
  
  void display() {
    //if (x == -1000 || y == -1000) spawn();
    
    pushMatrix();
    fill(#FF9D9D);
    square(x, y, SIZE);
    popMatrix();
  }
}
