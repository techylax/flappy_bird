import processing.sound.*;
Bird bird;
Obstacle[] obstacles = new Obstacle[2];
Score score;
PImage backgroundImage;
boolean gameStarted = false;
int START_STATE =0;
int PLAY_STATE = 1;
int GAMEOVER_STATE =2;
int INSTRUCTION_STATE = 3;
int state;

void setup() {
  state = START_STATE;
  size(1024, 512);
  bird = new Bird(width/2, 0);
  obstacles[0] = new Obstacle(width, random(100, height-100));
  obstacles[1] = new Obstacle(width*1.5+25, random(100, height-100));
  score = new Score();
  backgroundImage = loadImage("background.jpg");
}

void draw() {
  background(backgroundImage);

  if (state == START_STATE) {
    drawStartScreen();
  } else if (state== GAMEOVER_STATE) {
    drawGameOver();
  } else if (state == PLAY_STATE) {
    bird.draw();
    for (Obstacle o : obstacles) { 
      o.draw();
    }
    score.draw();
    detectCollision();
  }
}

void mousePressed() {
  action();
}

void keyPressed() {

  if (state==GAMEOVER_STATE && key == 'R' || key == 'r' )
  { 
    setup();
  }

  if (state==START_STATE && key == 'S' || key == 's') 
    {
      state = PLAY_STATE;
    }
  


  if (state == PLAY_STATE) {
    action();
  }
}
void action() {
  if (state==GAMEOVER_STATE) {
    bird.reset();
    for (Obstacle o : obstacles) { 
      o.reset();
    }
    score.reset();
  } else if (!gameStarted) {
    gameStarted = true;
  } else if (state==PLAY_STATE) {
    bird.jump();
  }
}

void drawGameOver() {
  rectMode(CENTER);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(200);
  text("Game over!", 
    width/2, height/2, 
    width, 100);
  text("Press R to restart.", width/2, height/2+30, 
    width, 90);
}

void drawStartScreen() {
  rectMode(CENTER);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(200);
  text("Press S to start", 
    width/2, height/2, 
    width, 100);
}


void detectCollision() {
  if (bird.y > height || bird.y < 0) {
    state = GAMEOVER_STATE;
  }

  for (Obstacle obstacle : obstacles) {
    if (bird.x - bird.size/2.0 > obstacle.topX + obstacle.w) {
      score.increase();
    }

    if (obstacle.topX + obstacle.w < 0) {
      obstacle.reposition();
      score.allowScoreIncrease();
    }

    if (obstacle.detectCollision(bird)) {
      state= GAMEOVER_STATE;
    }
  }
}
