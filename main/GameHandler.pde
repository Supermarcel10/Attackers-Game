final class GameHandler {
  final static float CHANCEOFCOIN = 8, CHANCEOFPOWERUP = 4, PERKSTAYTIME = 30;
  int numOfEnemies = 0, enemiesRemaining = 0, nextEnemy = 0, startTimeEnemy, gold = 0;
  float coinX = -50, coinY = -50, powerUpX = -50, powerUpY = -50, coinStartTime = 0, powerUpStartTime = 0;

  Coin coin = new Coin();
  PowerUp pwUp = new PowerUp();


  final void calculateEnemies(int wave) {
    //if (wave == 0) {
    //  numOfEnemies = 0;
    //  nextEnemy = 0;
    //  enemiesRemaining = 0;
    //}
    
    String type = "";

    // Calculate the number of enemies in this wave.
    numOfEnemies = round(wave * (1.4 * wave) + 12);
    if (enemiesRemaining == 0) {
      enemiesRemaining = numOfEnemies;
      nextEnemy = numOfEnemies;
    }
    
    // Create a new array of enemies.
    enemy = new Enemy[numOfEnemies];
    for (int i = 0; i < numOfEnemies; i++) {
      if (round(random(0, 4)) <= 1) type = "basic"; else type = "heavy";
      enemy[i] = new Enemy(ceil(wave / 4) + 1, type);
    }
    
    startTimeEnemy = millis();
  }
  
  
  boolean spawnCoin(float pX, float pY) {
    if (coinX == -50 && coinY == -50) {
      if (frameCount % round(frameRate) == 0 && random(0, 100) < CHANCEOFCOIN) {
        coinX = random(width * 0.05, width - (width * 0.05));
        coinY = random(height * 0.1, height - (height * 0.1));
      }
    }
    coin.spawn(coinX, coinY);
    //coinStartTime = millis();
    
    return pickupCoin(pX, pY, true);
  }
  
  
  boolean pickupCoin(float pX, float pY, boolean pick) {
    if (dist(pX, pY, coinX, coinY) < 40) {
      coinX = -50;
      coinY = -50;
      if (pick) return true;
    }
    return false;
  }
  
  
  boolean spawnPowerUp(float pX, float pY) {
    if (powerUpX == -50 && powerUpY == -50) {
      if (frameCount % round(frameRate) == 0 && random(0, 100) < CHANCEOFPOWERUP) {
        powerUpX = random(width * 0.05, width - (width * 0.05));
        powerUpY = random(height * 0.1, height - (height * 0.1));
      }
    }
    pwUp.spawn(powerUpX, powerUpY);
    //powerUpStartTime = millis();
    
    return pickupPowerUp(pX, pY);
  }
  
  
  boolean pickupPowerUp(float pX, float pY) {
    if (dist(pX, pY, powerUpX, powerUpY) < 40) {
      powerUpX = -50;
      powerUpY = -50;
      return true;
    }
    return false;
  }
  
  
  boolean rectangleIntersect(Player r1, Enemy r2) {
    // What is the distance apart on x-axis
    float distanceX = (r1.x) - (r2.x);
    // What is the distance apart on y-axis
    float distanceY = (r1.y) - (r2.y);
  
  
    // What is the combined half-widths
    float combinedHalfX = (r1.SIZE + r2.SIZE) >> 1;
    // What is the combined half-heights
    float combinedHalfY = (r1.SIZE + r2.SIZE) >> 1;
  
    // Check for intersection on x-axis
    if (abs(distanceX) < combinedHalfX) {
      // Check for intersection on y-axis
      if (abs(distanceY) < combinedHalfY) {
        // Determine if they are intersecting
        return true;
      }
    }
    return false;
  }

boolean rectangleIntersect(Projectile r1, Enemy r2) {
  // What is the distance apart on x-axis
  float distanceX = (r1.x) - (r2.x);
  // What is the distance apart on y-axis
  float distanceY = (r1.y) - (r2.y);


  // What is the combined half-widths
  float combinedHalfX = (r1.x + r2.x) / 2;
  // What is the combined half-heights
  float combinedHalfY = (r1.y + r2.y) / 2;

  // Check for intersection on x-axis
  if (abs(distanceX) < combinedHalfX) {
    // Check for intersection on y-axis
    if (abs(distanceY) < combinedHalfY) {
      // Check if they are intersecting
      return true;
    }
  }
  return false;
}
  
  void spawnEnemy() {
    if (enemiesRemaining < 0) enemiesRemaining = 0;
    if (enemiesRemaining == 0 || bar.wave == 0) return;
    
    for (int i = 0; i < enemiesRemaining; i++) {
      //println(millis());

      //println((((startTimeEnemy + (bar.waveTime * 1000)) / numOfEnemies) * i) < millis());
      //println(ceil(millis() / ((startTimeEnemy + (bar.waveTime * 1000)) / numOfEnemies)));
      nextEnemy = ceil(millis() / ((startTimeEnemy + (bar.waveTime * 1000)) / numOfEnemies));
      //if ((((startTimeEnemy + (bar.waveTime * 1000)) / numOfEnemies) * i) < millis()) {
      try {
        if (enemy[nextEnemy].x == -1000) { 
          enemy[nextEnemy].spawn();
        }
      } catch (ArrayIndexOutOfBoundsException e) {};
      //}
    }
  }
}
