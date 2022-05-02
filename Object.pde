//----------------//
//  Object Class  //
//----------------//

class Object {

  //-// Class Variables //-//

  int x;     // the x location of an object
  int y;     // the y location of an object
  int type;  // value that stores object type

  boolean campfire;  // if true then campfire object type
  boolean stick;     // if true then stick object type
  boolean log;       // if true then log object type
  boolean fire;      // if true then fire object type

  int campfireSize;  // the size of a campfire
  int stickHeight;   // the height of a stick
  int stickWidth;    // the width of a stick
  int logSizeHeight; // the height of a log
  int logSizeWidth;  // the width of a log

  boolean isGathered; // if true then object has been picked up
  boolean logMoved;   // if true then object has been moved to the side

  boolean touchingCampfire;  // if true then player touching campfire type
  boolean touchingStick;     // if true then player touching stick type
  boolean touchingLog;       // if true then player touching log type

  //-------------------//
  //Object Hitbox
  int oT;
  int oB;
  int oL;
  int oR;
  //-------------------//


  //---// Constructor //---//

  Object(int tempX, int tempY, int tempType) {
    x = tempX;
    y = tempY;
    type = tempType;

    //-// Initialize vars (there are many) //-//

    isGathered = false;
    logMoved = false;

    objectVar = int(random(1, 100));

    touchingCampfire = false;
    touchingStick = false;
    touchingLog = false;

    campfireSize = 150;
    stickHeight = 75;
    stickWidth = 20;
    logSizeHeight = 300;
    logSizeWidth = 100;
  }

  //-// Functions //-//

  void checkType() {    //Determines the type of object via given object number

    if (type == 0) {
      campfire = true;
    }
    if (type == 1) {
      stick = true;
    }
    if (type == 2) {
      log = true;
    }
    if (type == 3) {
      fire = true;
    }
  }

  //---//

  void campfire(int x, int  y) {  //Campfire Object Perams
    int size = campfireSize;
    tint(255, 255);
    campfireBaseStill.resize(150, 150);
    image(campfireBaseStill, x, y);
  }

  void stick(int x, int  y) {     //Stick Object Perams
    int sizeY = stickHeight;
    int sizeX = stickWidth;
    tint(255.255);
    if (objectVar < 45) {
      image(stickBasic1, x, y);
    }
    if (objectVar >= 45 && objectVar < 90) {
      image(stickBasic2, x, y);
    }
    if (objectVar >= 90 && objectVar <= 100) {
      image(stickBasic3, x, y);
    }
  }

  void log(int x, int  y) {       //Log Object Perams
    int sizeY = logSizeHeight;
    int sizeX = logSizeWidth;
    if (rightVar == true) {
      image(logVar1R, x-25, y-25);
    }
    if (leftVar == true) {
      image(logVar1L, x-logSizeWidth+75, y-25);
    }
  }

  void fire(int x, int  y) {  //fire Object Perams
    tint(255, fireLevel);
    fireIdleAnimation.isAnimating = true;
    fireIdleAnimation.display(x, y);
  }

  //---//

  void chosenObject() {       //Determines the hitboxes for given objects
    if (campfire == true) {
      campfire(x, y);
      oT = y;
      oB = y+campfireSize;
      oL = x;
      oR = x+campfireSize;
    }
    if (stick == true) {
      stick(x, y);
      oT = y;
      oB = y+stickHeight;
      oL = x;
      oR = x+stickWidth;
    }
    if (log == true) {
      log(x, y);
      oT = y;
      oB = y+logSizeHeight;
      oL = x;
      oR = x+logSizeWidth;
    }
    if (fire == true) {
      fire(x, y);
    }
  }

  //---//

  void campfireInteractions() {
    if (touchingCampfire == true && p1.totalSticks > 0) {
      println("Stick added to fire");
      fireLeft += 30;
      p1.totalSticks -= 1;
    }
  }

  //---//

  void logInteractions() {   //Actions that can be performed when touching a log
    //println(p1.isAbleToMoveRight);

    if (p1.isAbleToMoveRight == false && shiftPressed == true
      && spacePressed == false && p1.isTouchingLog == true) {
      endTime = millis();

      textSize(50);
      text("Hello Log!", int(p1.x)-75*3/2, int(p1.y)-200);

      if (helloLog.isPlaying() == false && canSpeak == true) {
        helloLog.play();
        canSpeak = false;
      }

      if (millis() - startTime >= logMoveDelay) {
        //println("moved");
        finishedTalking = true;
        logMoved = true;
        logMove.play();
        canSpeakResponse = true;
        startTime = millis();
      }
    } else if (p1.isAbleToMoveLeft == false && shiftPressed == true
      && spacePressed == false && p1.isTouchingLog == true) {
      endTime = millis();

      textSize(50);
      text("Hello Log!", int(p1.x)-75*3/2, int(p1.y)-200);

      if (helloLog.isPlaying() == false && canSpeak == true) {
        helloLog.play();
        canSpeak = false;
      }

      if (millis() - startTime >= logMoveDelay) {
        //println("moved");
        finishedTalking = true;
        logMoved = true;
        logMove.play();
        canSpeakResponse = true;
        startTime = millis();
      }
    } else if (p1.isAbleToMoveRight == false && spacePressed == true
      && shiftPressed == false && p1.isTouchingLog == true) {
      endTime = millis();
      //println("preparing jump");
      if (millis() - startTime >= logScaleDelay) {
        println("scaled");
        scaleSound.play();
        playerVanishAnimationR.index = 0;
        completedVanish = false;
        playerIdleAnimationR.index = 16;
        justFlourished = true;
        p1.x += 150;
        startTime = millis();
      }
    } else if (p1.isAbleToMoveLeft == false && spacePressed == true
      && shiftPressed == false && p1.isTouchingLog == true) {
      endTime = millis();
      //println("preparing jump");
      if (millis() - startTime >= logScaleDelay) {
        //println("scaled");
        scaleSound.play();
        playerVanishAnimationL.index = 0;
        completedVanish = false;
        playerIdleAnimationL.index = 16;
        justFlourished = true;
        p1.x -= 150;
        startTime = millis();
      }
    }
  }

  //---//

  void hitboxDetection() {       //Determines if player is in object hitbox
    //p1.isAbleToMoveUp = true;
    //p1.isAbleToMoveDown = true;
    //p1.isAbleToMoveLeft = true;
    //p1.isAbleToMoveRight = true;

    if (p1.pT < oB) {
      //println("1");
      if (p1.pB > oT) {
        //println("2");
        if (p1.pL < oR) {
          //println("3");
          if (p1.pR > oL) {
            //println("4");

            //---// If Touching Object Type //---//

            if (campfire == true) {
              touchingCampfire = true;
              p1.isTouchingCampfire = true;
              //println("camp " + touchingCampfire);
            }

            if (stick == true) {
              if (p1.totalSticks <= 4) {
                isGathered = true;
              }
              if (p1.totalSticks > 4) {
                println("Can not carry any more sticks!");
              }
              touchingStick = true;
              p1.isTouchingStick = true;
            }

            if (log == true) {
              touchingLog = true;
              p1.isTouchingLog = true;
              //println("log " + touchingLog);
            }

            //-----------------------------------//

            if (p1.pT < oT && p1.pB < oB) {
              //println("no down");
              p1.isAbleToMoveDown = false;
            } else if (p1.pB > oB && p1.pT > oT) {
              //println("no up");
              p1.isAbleToMoveUp = false;
            }
            if (p1.pR < oR && p1.pL < oL) {
              //println("no right");
              p1.isAbleToMoveRight = false;
            } else if (p1.pL > oL && p1.pR > oR) {
              //println("no left");
              p1.isAbleToMoveLeft = false;
            }
          }
        }
      }
    } else {
      touchingCampfire = false;
      touchingStick = false;
      touchingLog = false;

      p1.isTouchingCampfire = false;
      p1.isTouchingStick = false;
      p1.isTouchingLog = false;
    }
  }

  //---//

  void render() {
    checkType();
    chosenObject();
    hitboxDetection();
    logInteractions();
    campfireInteractions();
  }
}
