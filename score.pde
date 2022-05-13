class Score {
  private int score = 0;
  private boolean scoreIncreased = false;

  void increase() {
    if (!scoreIncreased) {
      score += 1;
      scoreIncreased = true;
    }
  }

  void reset() {
    score = 0;
    scoreIncreased = false;
  }

  void allowScoreIncrease() {
    scoreIncreased = false;
  }

  void draw() {
    pushStyle();

    rectMode(CORNER);
    textAlign(LEFT);
    fill(255);
    textSize(25);
    text("Score: " + score, 10, 10, width, 40);

    popStyle();
  }
}
