//----------------//
//  Player Class  //
//----------------//

class Player {

  //-// Class Variables //-//

  float x;  // x pos
  float y;  // y pos
  float size;  // size
  float speed;  // speed

  int totalSticks;  // total number of sticks on player

  boolean isMovingUp;
  boolean isMovingDown;
  boolean isMovingLeft;
  boolean isMovingRight;

  boolean isAbleToMoveUp;
  boolean isAbleToMoveDown;
  boolean isAbleToMoveLeft;
  boolean isAbleToMoveRight;

  boolean isTouchingCampfire;
  boolean isTouchingStick;
  boolean isTouchingLog;

  //-------------------//
  //Player Hitbox
  int pT = int(y);
  int pB = int(y+size);
  int pL = int(x);
  int pR = int(x+size);
  //-------------------//


  //---// Constructor //---//

  Player() {
    size = 50;
    x = width/2-size/2;
    y = height/2-size/2+200;
    speed = 10;
    isMovingUp = false;
    isMovingDown = false;
    isMovingLeft = false;
    isMovingRight = false;
    isAbleToMoveUp = true;
    isAbleToMoveDown = true;
    isAbleToMoveLeft = true;
    isAbleToMoveRight = true;
    totalSticks = 0;

    isTouchingCampfire = false;
    isTouchingStick = false;
    isTouchingLog = false;
  }

  //-// Functions //-//

  void render() {
    updateHitbox();
    //fill(color(0, 100, 200));
    //rect(x, y, size, size, size/2-size/4);

    tint(255, fireLevel);

    textSize(25);
    text("Sticks: " + totalSticks + "/5", 50, 75);
    textSize(25);
    text("Score: " + playerScore + "s Wandered", 50, 45);

    playerIdleAnimationR.isAnimating = true;
    playerIdleAnimationL.isAnimating = true;

    if (spacePressed == false && p1.isAbleToMoveLeft == true
      || spacePressed == true && p1.isAbleToMoveLeft == true
      || spacePressed == false && p1.isAbleToMoveLeft == false
      || spacePressed == true && p1.isTouchingLog == false
      ) {
      if (shiftPressed == false && p1.isAbleToMoveLeft == true
        || shiftPressed == true && p1.isAbleToMoveLeft == true
        || shiftPressed == false && p1.isAbleToMoveLeft == false
        || shiftPressed == true && p1.isTouchingLog == false) {
        if (lookingLeft == true) {
          playerIdleAnimationL.display(int(x)-75*3/2, int(y)-200);
        }
      }
    }
    if (spacePressed == false && p1.isAbleToMoveRight == true
      || spacePressed == true && p1.isAbleToMoveRight == true
      || spacePressed == false && p1.isAbleToMoveRight == false
      || spacePressed == true && p1.isTouchingLog == false
      ) {
      if (shiftPressed == false && p1.isAbleToMoveRight == true
        || shiftPressed == true && p1.isAbleToMoveRight == true
        || shiftPressed == false && p1.isAbleToMoveRight == false
        || shiftPressed == true && p1.isTouchingLog == false) {
        if (lookingRight == true) {
          playerIdleAnimationR.display(int(x)-75*3/2, int(y)-200);
        }
      }
    }


    if (shiftPressed == true && spacePressed == false) {
      if (finishedTalking == false && p1.isAbleToMoveRight == false && p1.isTouchingLog == true) {
        //println("procd");
        playerTalkingIdleAnimationR.isAnimating = true;
        playerTalkingIdleAnimationR.display(int(x)-75*3/2, int(y)-200);
      }
      if (finishedTalking == true && lookingRight == true) {

        textSize(50);
        text("Thank you!", int(x)-75*3/2, int(y)-200);

        if (thankYou.isPlaying() == false && canSpeakResponse == true) {
          thankYou.play();
          canSpeakResponse = false;
        }

        playerTalkingIdleAnimationR.isAnimating = false;
        playerTalkingIdleAnimationR.index = 0;
      }
      if (finishedTalking == false && p1.isAbleToMoveLeft == false && p1.isTouchingLog == true) {
        //println("procd");
        playerTalkingIdleAnimationL.isAnimating = true;
        playerTalkingIdleAnimationL.display(int(x)-75*3/2, int(y)-200);
      }
      if (finishedTalking == true && lookingLeft == true) {

        textSize(50);
        text("Thank you!", int(x)-75*3/2, int(y)-200);

        if (thankYou.isPlaying() == false && canSpeakResponse == true) {
          thankYou.play();
          canSpeakResponse = false;
        }

        playerTalkingIdleAnimationL.isAnimating = false;
        playerTalkingIdleAnimationL.index = 0;
      }
    }

    //println(completedVanish);

    if (spacePressed == true && shiftPressed == false) {
      if (completedVanish == false && p1.isAbleToMoveRight == false && p1.isTouchingLog == true) {
        //println("procd");
        playerVanishAnimationR.isAnimating = true;
        playerVanishAnimationR.display(int(x)-75*3/2, int(y)-200);
        if (playerVanishAnimationR.index >= playerVanishImagesR.length-1) {
          playerVanishAnimationR.isAnimating = false;
          completedVanish = true;
        }
      }
      if (completedVanish == false && p1.isAbleToMoveLeft == false && p1.isTouchingLog == true) {
        //println("procd");
        playerVanishAnimationL.isAnimating = true;
        playerVanishAnimationL.display(int(x)-75*3/2, int(y)-200);
        if (playerVanishAnimationL.index >= playerVanishImagesL.length-1) {
          playerVanishAnimationL.isAnimating = false;
          completedVanish = true;
        }
      }
    }
  }

  void updateHitbox() {

    pT = int(y);
    pB = int(y+size);
    pL = int(x);
    pR = int(x+size);
  }

  void moveRight() {
    if (isMovingRight == true && isAbleToMoveRight == true && spacePressed == false
      && shiftPressed == false && fireLit == true) {
      x = x + speed;
    }
  }

  void moveLeft() {
    if (isMovingLeft == true && isAbleToMoveLeft == true && spacePressed == false
      && shiftPressed == false && fireLit == true) {
      x = x - speed;
    }
  }

  void moveUp() {
    if (isMovingUp == true && isAbleToMoveUp == true && spacePressed == false
      && shiftPressed == false && fireLit == true) {
      y = y - speed;
    }
  }

  void moveDown() {
    if (isMovingDown == true && isAbleToMoveDown == true && spacePressed == false
      && shiftPressed == false && fireLit == true) {
      y = y + speed;
    }
  }
}
