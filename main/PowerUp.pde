final class PowerUp {
  void spawn(float x, float y) {
    pushMatrix();
    noStroke();
    fill(#62CCFF, 80);
    circle(x, y, 60);
    popMatrix();
  }
}
