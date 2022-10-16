static final int DIAM = 48, SPD = 4, FPS = 60, DEBUGSIZE = 24, VER = 1, BUILD = 0;
static final color BG = 0350;

Progress bar = new Progress();
GameHandler GH = new GameHandler();
Enemy enemy[] = new Enemy[0];
Projectile proj = new Projectile();

Player p;
//TODO: FIX COLLISION
//TODO: ADD RESTARTING
//TODO: ADD POWERUPS
//TODO: ADD SHOP
//TODO: MAKE PERKS AND COINS DISSAPEAR AFTER TIME
//TODO: ADD MORE PLAYERS
//TODO: ADD SOUND

void setup() {
  // Main setup
  size(1920, 1080, JAVA2D);
  frameRate(FPS);
  ellipseMode(CENTER);
  
  pushMatrix();
  fill(Player.COL);
  stroke(Player.OUTLINE);
  strokeWeight(Player.BOLD);
 
  p = new Player(width >> 1, height >> 1, DIAM, SPD);
  popMatrix();
}


void draw() {
  background(#FDFFC9);
  
  // Debugging text
  pushMatrix();
  textSize(DEBUGSIZE);
  noStroke();
  fill(0);
  textAlign(LEFT);
  translate(5, 10);
  text("FPS " + round(frameRate), 0, DEBUGSIZE);
  text("Wave " + bar.wave, 0, DEBUGSIZE * 2);
  text("Time " + bar.waveTime, 0, DEBUGSIZE * 3);
  text("Enemies " + GH.enemiesRemaining + "/" + GH.numOfEnemies, 0, DEBUGSIZE * 4);
  text("Gold " + GH.gold, 0, DEBUGSIZE * 5);
  popMatrix();
  
  pushMatrix();
  textSize(DEBUGSIZE >> 1);
  noStroke();
  fill(255, 0, 0);
  textAlign(RIGHT);
  text("BUILD: " + VER + "." + BUILD, width - 5, height - (DEBUGSIZE >> 2));
  popMatrix();
  
  
  // Draw and animate progress bar
  bar.display(GH.enemiesRemaining);
  
  // If game not paused and started
  if (bar.wave != 0 || !bar.isPaused) {
    // Spawn and pick up coins
    if (GH.spawnCoin(p.x, p.y)) {
      GH.gold++;
    }
    
    // Spawn and pick up power ups
    if (GH.spawnPowerUp(p.x, p.y)) {
      println("Power Up is not yet developed!\nGiving one free gold.");
      GH.gold++;
    }
  }
  
  // Draw and animate enemies
  if (enemy.length > 0 ) {
    try {
      for (int i = 0; i < enemy.length; i++) {
        enemy[i].update(p.x, p.y);
        enemy[i].display();
        
        // Determine if player has shot down an enemy
        //if (GH.rectangleIntersect(proj, enemy[i])) {
        //  print("KO");
        //  enemy[i].die();
        //}
        
        // Determine if the player has touched an enemy
        if (GH.rectangleIntersect(p, enemy[i])) {
          for (int j = 0; j < enemy.length; j++) {
            enemy[j].die();
            p.die();
            p.isDead = true;
            bar.isPaused = true;
            noLoop();
          }
        }
      }
    } catch (NullPointerException e) {};
    
    // Spawn enemy if possible
    GH.spawnEnemy();
  }
  
  // Draw and animate player
  p.move();
  p.display();
}


void keyPressed() {
  p.setMove(keyCode, true);
  
  // Cheat codes
  if (key == 'l') {
    bar.nextWave();
  }
  if (key == 'k') {
    try {
      enemy[round(random(0, GH.nextEnemy - 1))].die();
    } catch (ArrayIndexOutOfBoundsException e) {};
  }
}


void keyReleased() {
  p.setMove(keyCode, false);
}
