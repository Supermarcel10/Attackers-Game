class Projectile {
  float x, y, w, h;
  float speed, rotation, maxSpeed, minSpeed;
  boolean firing;

  Projectile() {
    x = 100;
    y = -100;
    w = 20;
    h = 10;

    speed = 0;
    rotation = 0;
    maxSpeed = 15;
    minSpeed = 5;
    firing = false;
  }
  
  
  void setStartLocation(float startX, float startY, float startRotation) {
    if (!firing) {
      x = startX;
      y = startY;
      rotation = startRotation;
      firing = true;
      speed = 25;
    }
  }
  
  
  void update() {
    if (firing == true) {
      if (speed < maxSpeed) {
        speed += 2;
      }
      if (speed > minSpeed) {
        speed -= 0.3;
      }
      //speed = maxSpeed;
      x += cos(rotation) * speed;
      y += sin(rotation) * speed;

      // Check for moving out of bounds
      if (x > width || x < 0 || y > height || y < 0) {
        reset();
        return;
      }
      
      // Check if shot an enemy
      //try {
      for (int i = 0; i < GH.numOfEnemies; i++) {
        if (GH.rectangleIntersect(proj, enemy[i])) {
          enemy[i].die();
        }
      }
    }
  }
  
  
  void reset() {
    speed = 0;
    firing = false;
    x = -100;
    y = -100;
  }
  
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(0, 255, 0);
    rect(-w/2, -h/2, w, h);
    popMatrix();
  }
}
