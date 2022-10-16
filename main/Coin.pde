final class Coin {
  void spawn(float x, float y) {
    pushMatrix();
    noStroke();
    fill(#F2CB5D);
    circle(x, y, 30);
    fill(#F5D06A);
    circle(x, y, 25);
    popMatrix();
  }
}
