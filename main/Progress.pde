final class Progress {
  static final float STARTINGWAVETIME = 30, COOLDOWNTIME = 7.5, TIMEBETWEENWAVE = 2.5;
  
  boolean isCooldown = false, isAfterWave = false, isPaused = false;
  int wave = 0, waveTime = 0, timeStarted = 0, enemiesRemaining = 0;
  
  void display(int en) {
    enemiesRemaining = en;
    checkWaveFinished();
    
    if (isPaused) {
      fill(150, 0, 0);
      noStroke();
      rect(0, 0, width, 10);
      return;
    }
    
    if (isCooldown) {
      fill(30, 130, 30);
      noStroke();
      rect(0, 0, map(timeElapsed(), 0, COOLDOWNTIME, width, 0), 10);
    } else if (isAfterWave) {
      fill(255, 175, 54);
      noStroke();
      rect(0, 0, map(timeElapsed(), 0, TIMEBETWEENWAVE, width, 0), 10);
    } else {
      fill(150, 0, 0);
      noStroke();
      if (waveTime != 0) {
        rect(0, 0, map(timeElapsed(), 0, waveTime, 0, width), 10);
      }
    }
  }
  
  
  void checkWaveFinished() {
    if (timeElapsed() >= waveTime && wave != 0) {
      isAfterWave = true;
      timeStarted = frameCount;
    } else if (isCooldown && timeElapsed() >= COOLDOWNTIME) {
      isCooldown = false;
      isAfterWave = false;
      nextWave();
    } else if (!isCooldown && isAfterWave && timeElapsed() >= TIMEBETWEENWAVE) {
      isAfterWave = false;
      nextWave();
    }
  }
  
  
  float timeElapsed() {
    return (millis() - timeStarted) / 1000f;
  }
  
  
  void nextWave() {
    if (enemiesRemaining != 0) return;
    
    if (wave != 0) {
      cooldownPeriod();
    }
    
    //if (enemiesRemaining == 0) {
    //  isPaused = true;
    //  return;
    //}//else if (wave == 0) {
    //  GH.calculateEnemies(wave);
    //  isPaused = false;
    //  return;
    //}
    isCooldown = false;
    isAfterWave = false;
    isPaused = false;
    
    wave++;
    GH.calculateEnemies(wave);
    waveTime = 20 + (wave * 5);
    timeStarted = millis();
  }
  
  
  void cooldownPeriod() {
    if (wave < 10 && wave % 3 == 0) {
      isCooldown = true;
    } else if (wave < 25 && wave % 6 == 0) {
      isCooldown = true;
    } else if (wave % 11 == 0) {
      isCooldown = true;
    }
  }
}
