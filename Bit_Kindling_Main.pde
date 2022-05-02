//===========================================================//
// ██╗░░██╗██╗███╗░░██╗██████╗░██╗░░░░░██╗███╗░░██╗░██████╗░ //
// ██║░██╔╝██║████╗░██║██╔══██╗██║░░░░░██║████╗░██║██╔════╝░ //
// █████═╝░██║██╔██╗██║██║░░██║██║░░░░░██║██╔██╗██║██║░░██╗░ //
// ██╔═██╗░██║██║╚████║██║░░██║██║░░░░░██║██║╚████║██║░░╚██╗ //
// ██║░╚██╗██║██║░╚███║██████╔╝███████╗██║██║░╚███║╚██████╔╝ //
// ╚═╝░░╚═╝╚═╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░ //
//===========================================================//

//=// Created by: Sullivan Dawson //=//



//=--=// Table of Contents //=--=//
// 1: Global Variables & Notes   //
// 2: Setup Function             //
// 3: Draw Function              //
// 4: Extra Functions            //
//=-----------------------------=//

//-// Controls So Far //-//
/*
 START = Light The Fire
 JoyU = UP
 JoyL = Left
 JoyD = Down
 JoyR = Right
 B = Move Object
 A = Scale Object
 */
//------------------------//


//-// Included Libraries //-//
import processing.sound.*;  //
import processing.io.*;     //
//--------------------------//


//\\===####==================####===//\\
//\\===/██\ Global Varaibles /██\===//\\
//\\===####==================####===//\\

Player p1;
ArrayList<Cell> cellListR;
ArrayList<Cell> cellListL;
Cell currentCellR;
Cell currentCellL;
int cellNum;
int backVar;
int objectVar;

long playerScore;
Button beginBut;
color butColor;

boolean spacePressed = false;
boolean shiftPressed = false;

boolean rightVar = false;
boolean leftVar = false;

boolean lookingLeft = false;
boolean lookingRight = false;

boolean completedVanish = false;
boolean justFlourished = false;
boolean finishedTalking = false;
boolean canSpeak = true;
boolean canSpeakResponse = false;

boolean fireLit = false;
int fireLeft;
int fireLevel;

int cellStatesVal = 0;
int gameStatesVal = 0;
Cell homeCell;
Cell firstRightCell;
Cell firstLeftCell;

SoundFile scarletNormal;
SoundFile scarletDistorted;
SoundFile scaleSound;
SoundFile ghostSpeak;
SoundFile helloLog;
SoundFile thankYou;
SoundFile campfireSound;
SoundFile forestSounds;
SoundFile windTrees;
SoundFile logMove;

PImage wildBackground1;
PImage wildBackground2;
PImage wildBackground3;
PImage wildBackground4;
PImage wildBackground5;
PImage wildFloor;

PImage backgroundHomeStill;
PImage homeFloorStill;

PImage transitionImage;
PImage endingScreen;

PImage logVar1R;
PImage logVar1L;
PImage stickBasic1;
PImage stickBasic2;
PImage stickBasic3;
PImage campfireBaseStill;
PImage fireStill;

PImage mainMenuBackground;
PImage kindlingTitle;

Animation fireIdleAnimation; //Fire Idle Animation
PImage[] fireIdleImages = new PImage[34];

Animation playerIdleAnimationL; //Player Idle Animation Facing Left
PImage[] playerIdleImagesL = new PImage[42];

Animation playerIdleAnimationR; //Player Idle Animation Facing Right
PImage[] playerIdleImagesR = new PImage[42];

Animation playerVanishAnimationR; //Player Vanish Facing Right
PImage[] playerVanishImagesR = new PImage[19];

Animation playerVanishAnimationL; //Player Vanish Facing Left
PImage[] playerVanishImagesL = new PImage[19];

Animation playerTalkingIdleAnimationR; //Player Talking Idle Facing Right
PImage[] playerTalkingIdleImagesR = new PImage[7];

Animation playerTalkingIdleAnimationL; //Player Talking Idle Facing Left
PImage[] playerTalkingIdleImagesL = new PImage[7];

//---// Timer Variables //---//
long startTime;
long endTime;
long logScaleDelay;
long logMoveDelay;
//-----------------------------//

//---// Fire Timer Variables //---//
long startTimeFire;
long endTimeFire;
long fireTimeDelay;
//-----------------------------//

//==//==========================================================//==//
int[] buttonPins = {2, 3, 4, 17, 27, 22, 5, 6, 13, 14, 15, 12}; //==//
int[] buttonStates = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};      //==//
int numButtons = 12;                                            //==//
//==//==========================================================//==//

//\\===####=======####===//\\
//\\===/██\ Setup /██\===//\\
//\\===####=======####===//\\

void setup() {
  size(640, 480);
  p1 = new Player();

  cellNum = 0;
  backVar = 0;
  objectVar = 0;
  butColor = color(255, 255, 255, 0);

  beginBut = new Button(float(width/2-50), float(height-100), float(125), float(50), butColor);

  firstRightCell = new Cell(2);
  firstRightCell.checkType();
  firstRightCell.generateCell();

  //-// Right Cell List Stuff //-//
  cellListR = new ArrayList<Cell>();
  cellListR.add(firstRightCell);
  currentCellR = cellListR.get(cellNum);

  firstLeftCell = new Cell(3);
  firstLeftCell.checkType();
  firstLeftCell.generateCell();

  //-// Left Cell List Stuff //-//
  cellListL = new ArrayList<Cell>();
  cellListL.add(firstLeftCell);
  currentCellL = cellListL.get(cellNum);

  homeCell = new Cell(0);
  homeCell.checkType();
  homeCell.generateCell();

  //-// Initialize Images & Animations //-//
  wildBackground1 = loadImage("Background Forest Wild-1.png");
  wildBackground2 = loadImage("Background Forest Wild-2.png");
  wildBackground3 = loadImage("Background Forest Wild-3.png");
  wildBackground4 = loadImage("Background Forest Wild-4.png");
  wildBackground5 = loadImage("Background Forest Wild-5.png");
  wildFloor = loadImage("WilderFloor.png");

  backgroundHomeStill = loadImage("BackgroundHomeStill.png");
  homeFloorStill = loadImage("homeFloorStill.png");

  transitionImage = loadImage("TransitionImageTrees.png");
  endingScreen = loadImage("endingScreen.png");

  mainMenuBackground = loadImage("MainMenuBackground.png");
  kindlingTitle = loadImage("kindlingTitle.png");

  logVar1R = loadImage("LogVar1R.png");
  logVar1L = loadImage("LogVar1L.png");
  stickBasic1 = loadImage("StickBasic1.png");
  stickBasic2 = loadImage("StickBasic2.png");
  stickBasic3 = loadImage("StickBasic3.png");
  campfireBaseStill = loadImage("campfireBaseStill.png");
  fireStill = loadImage("fireStill.png");

  //-//

  // Fire Idle Animation
  for (int i=0; i < fireIdleImages.length; i++) {
    fireIdleImages[i] = loadImage("fire_" + i + ".png");
  }
  fireIdleAnimation = new Animation(fireIdleImages, 0.5, 1);

  // Player Idle Animation L
  for (int i=0; i < playerIdleImagesL.length; i++) {
    playerIdleImagesL[i] = loadImage("playerL_" + i + ".png");
  }
  playerIdleAnimationL = new Animation(playerIdleImagesL, 0.5, 3);

  // Player Idle Animation R
  for (int i=0; i < playerIdleImagesR.length; i++) {
    playerIdleImagesR[i] = loadImage("playerR_" + i + ".png");
  }
  playerIdleAnimationR = new Animation(playerIdleImagesR, 0.5, 3);

  // Player Vanish Animation R
  for (int i=0; i < playerVanishImagesR.length; i++) {
    playerVanishImagesR[i] = loadImage("playerVanishR_" + i + ".png");
  }
  playerVanishAnimationR = new Animation(playerVanishImagesR, 0.15, 3);

  // Player Vanish Animation L
  for (int i=0; i < playerVanishImagesL.length; i++) {
    playerVanishImagesL[i] = loadImage("playerVanishL_" + i + ".png");
  }
  playerVanishAnimationL = new Animation(playerVanishImagesL, 0.15, 3);

  // Player Talking Idle Animation R
  for (int i=0; i < playerTalkingIdleImagesR.length; i++) {
    playerTalkingIdleImagesR[i] = loadImage("playerTalkingIdleR_" + i + ".png");
  }
  playerTalkingIdleAnimationR = new Animation(playerTalkingIdleImagesR, 0.15, 3);

  // Player Talking Idle Animation L
  for (int i=0; i < playerTalkingIdleImagesL.length; i++) {
    playerTalkingIdleImagesL[i] = loadImage("playerTalkingIdleL_" + i + ".png");
  }
  playerTalkingIdleAnimationL = new Animation(playerTalkingIdleImagesL, 0.15, 3);


  //-//

  //-// Initialize Music & Sounds //-//
  scarletNormal = new SoundFile(this, "scarletForestShortNormal.wav");
  scarletNormal.amp(0.3);
  scarletDistorted = new SoundFile(this, "scarletForestShortDistorted.wav");
  scarletDistorted.amp(0.8);
  scaleSound = new SoundFile(this, "scaleSound.wav");
  scaleSound.amp(0.15);
  ghostSpeak = new SoundFile(this, "ghostspeak.wav");
  ghostSpeak.amp(0.25);
  helloLog = new SoundFile(this, "helloLog2.wav");
  thankYou = new SoundFile(this, "thankYou.wav");
  campfireSound = new SoundFile(this, "campfireSound.wav");
  campfireSound.amp(0.05);
  forestSounds = new SoundFile(this, "forestSounds.wav");
  windTrees = new SoundFile(this, "windTrees.wav");
  logMove = new SoundFile(this, "logMove.wav");

  logScaleDelay = 2000;
  logMoveDelay = 7000;
  fireTimeDelay = 1000;

  fireLeft = 500;
  fireLevel = 0;

  playerScore = 0;

  //============//==//
  initButtons();//==//
  //============//==//
}

//\\===####======####===//\\
//\\===/██\ Draw /██\===//\\
//\\===####======####===//\\

void draw() {

  checkJoy();
  gameStates();
}

//\\===####===========####===//\\
//\\===/██\ Functions /██\===//\\
//\\===####===========####===//\\

//----------------//-----------------//---//
//----------------// GameStates Func //---//
//----------------//-----------------//---//

void gameStates() {

  switch (gameStatesVal) {

    //--------//---------------//
  case 0:     //   Main Menu   //
    //--------//---------------//

    image(mainMenuBackground, 0, 0, 640, 480);
    textSize(180);
    fill(#1b3a4b);
    text("Kindling", 5, 400);
    beginBut.render();
    textSize(50);
    fill(#355769);
    text("begin", width/2-50, height-50);
    textSize(25);
    fill(#2e5366);
    text("JOY to move", 25, height-50);
    textSize(25);
    fill(#2e5366);
    text("START to light campfire", 25, height-25);
    textSize(25);
    fill(#2e5366);
    text("Hold 'A' to scale logs", 25, height-75);
    textSize(25);
    fill(#2e5366);
    text("Hold 'B' to move logs", 25, height-100);

    if (forestSounds.isPlaying() == false) {
      forestSounds.play();
    }
    if (windTrees.isPlaying() == false) {
      windTrees.play();
    }

    if (beginBut.isPressed() == true) {
      gameStatesVal += 1;
    }

    if (buttonStates[4] == 1) {
      gameStatesVal += 1;
    }


    break;

    //--------//---------------//
  case 1:     //   Game Main   //
    //--------//---------------//

    fireTick();
    changeStates();
    cellStates();
    transitionEase();

    break;

    //--------//-------------------//
  case 2:     //   Ending Screen   //
    //--------//-------------------//

    tint(255, 255);
    image(endingScreen, 0, 0);

    if (scarletDistorted.isPlaying() == false) {
      scarletDistorted.jump(10);
    }

    scarletNormal.amp(0.05);
    campfireSound.amp(0.005);

    textSize(25);
    fill(#2e5366);
    text("Time Wandered: " + playerScore + "s", 25, height-75);

    textSize(10);
    fill(#2e5366);
    text("As the light of the fire ceases to exist, so too does its tethered spirit.", 25, height-50);
    textSize(10);
    fill(#2e5366);
    text("The deep forest doomed to lie dormant until the next spark brings the spirit back to life...", 25, height-25);

    if (buttonStates[4] == 1) {
      gameStatesVal += 1;
    }

    break;
  }
}


//----------------//-----------------//---//  This function is a finite state machine that involves the cell displayed
//----------------// CellStates Func //---//  during the main gameplay loop. This allows for more complicated location
//----------------//-----------------//---//  to be maintained while changing cell lists, such as the left and right.

void cellStates() {

  switch (cellStatesVal) {

    //--------//---------------//
  case 0:     //   Home Cell   //
    //--------//---------------//

    campfireSound.amp(0.05);

    if (fireLit == true) {
      if (campfireSound.isPlaying() == false) {
        campfireSound.play();
      }
      if (scarletNormal.isPlaying() == false) {
        scarletNormal.jump(9.5);
      }
    }
    if (forestSounds.isPlaying() == false) {
      forestSounds.play();
    }
    if (windTrees.isPlaying() == false) {
      windTrees.play();
    }

    homeCell.render();
    playerRendMove();

    //-// Lighting //-//
    fill(255, 255, 255, fireLevel/4);
    noStroke();
    circle(width/2, height/2, 900);

    fill(255, 255, 255, fireLevel/6);
    noStroke();
    circle(width/2, height/2, 1500);

    break;

    //--------//-----------------------//
  case 1:     //   Right Exploration   //
    //--------//-----------------------//

    campfireSound.amp(0.005);


    if (scarletNormal.isPlaying() == false) {
      scarletNormal.play();
    }
    if (forestSounds.isPlaying() == false) {
      forestSounds.play();
    }
    if (windTrees.isPlaying() == false) {
      windTrees.play();
    }

    rightVar = true;
    leftVar = false;

    changeCellR();
    currentCellR.render();
    playerRendMove();

    break;

    //--------//----------------------//
  case 2:     //   Left Exploration   //
    //--------//----------------------//

    campfireSound.amp(0.005);


    if (scarletNormal.isPlaying() == false) {
      scarletNormal.play();
    }
    if (forestSounds.isPlaying() == false) {
      forestSounds.play();
    }
    if (windTrees.isPlaying() == false) {
      windTrees.play();
    }

    leftVar = true;
    rightVar = false;

    changeCellL();
    currentCellL.render();
    playerRendMove();

    break;
  }
}


//----------------//-------------------//---//  This function checks certain criteria and, if said
//----------------// ChangeStates Func //---//  criteria is met, then it changes the state values of
//----------------//-------------------//---//  any finite state machine.
void changeStates() {

  //-// If currently in Home Cell
  if (cellStatesVal == 0) {                    //Checks to see current cellState
    if (p1.x+p1.size/2 > width) {               //Checks to see if player is past right border
      cellStatesVal = 1;                      //Changes current cellState to the desired cellState
      p1.x = p1.size;                         //Ensures player doesn't cause next cell to load (places player)
    }
    if (p1.x+p1.size/2 < 0) {                  //Checks to see if player is past left border
      cellStatesVal = 2;                      //Changes current cellState to the desired cellState
      p1.x = width - p1.size;                 //Ensures player doesn't cause next cell to load (places player)
    }
  }

  //-// If currently in Right Exploration
  if (cellStatesVal == 1) {                    //Checks to see current cellState
    if (cellNum == 0 && p1.x+p1.size/2 < 0) {   //Checks to see if both the current cell is the first and left border
      cellStatesVal = 0;                      //Changes current cellState to the desired cellState
      p1.x = width - p1.size;                 //Places player on correct side of Home Cell
    }
  }

  //-// If currently in Left Exploration
  if (cellStatesVal == 2) {                    //Checks to see current cellState
    if (cellNum==0 && p1.x+p1.size/2 > width) { //Checks to see if both the current cell is the first and right border
      cellStatesVal = 0;                      //Changes current cellState to the desired cellState
      p1.x = p1.size;                         //Places player on correct side of Home Cell
    }
  }
}

//----------------//--------------------//---//
//----------------// GenerateCellL Func //---//
//----------------//--------------------//---//
void generateCellL() {
  Cell generatedCell;
  generatedCell = new Cell(1);
  generatedCell.checkType();
  generatedCell.generateCell();
  cellListL.add(generatedCell);
}

//----------------//--------------------//---//
//----------------// GenerateCellR Func //---//
//----------------//--------------------//---//
void generateCellR() {
  Cell generatedCell;
  generatedCell = new Cell(1);
  generatedCell.checkType();
  generatedCell.generateCell();
  cellListR.add(generatedCell);
}

//----------------//------------------//---//  This function is what allows the changing of scene
//----------------// ChangeCellR Func //---//  and either creates new or selects cells from an adaptive
//----------------//------------------//---//  list. VERY VERY IMPORTANT (only for right path however)
void changeCellR() {
  if (p1.x+p1.size/2 > width) {                 //Checks to see if past right border
    println("transition");
    cellNum += 1;                             //Increases cell holding variable
    if (cellNum >= cellListR.size()) {         //Checks to see if the next cell hasn't been rendered yet
      println("above max");
      generateCellR();
      currentCellR = cellListR.get(cellNum);
      p1.x = p1.size;                         //Player location after render
    } else {                                    //If upcoming cell has already been rendered before
      println("beneath max");
      currentCellR = cellListR.get(cellNum);   //Display that already rendered cell
      p1.x = p1.size;                         //Player location after render
    }
  }
  if (p1.x+p1.size/2 < 0) {                     //Checks to see if past left border
    println("backtrack");
    cellNum -= 1;                             //Decreases cell holding variable
    currentCellR = cellListR.get(cellNum);     //Updates Current Cell
    p1.x = width - p1.size;                   //Player location after render
  }
}

//----------------//------------------//---//  This function is what allows the changing of scene
//----------------// ChangeCellL Func //---//  and either creates new or selects cells from an adaptive
//----------------//------------------//---//  list. VERY VERY IMPORTANT (only for left path however)
void changeCellL() {
  if (p1.x+p1.size/2 < 0) {                     //Checks to see if past left border
    println("transition");
    cellNum += 1;                             //Increases cell holding variable
    if (cellNum >= cellListL.size()) {         //Checks to see if the next cell hasn't been rendered yet
      println("above max");
      generateCellL();                        //Renders new cell
      currentCellL = cellListL.get(cellNum);   //Updates Current Cell
      p1.x = width - p1.size;                 //Player location after render
    } else {                                    //If upcoming cell has already been rendered before
      println("beneath max");
      currentCellL = cellListL.get(cellNum);   //Display that already rendered cell
      p1.x = width - p1.size;                 //Player location after render
    }
  }
  if (p1.x+p1.size/2 > width) {                 //Checks to see if past right border
    println("backtrack");
    cellNum -= 1;                             //Decreases cell holding variable
    currentCellL = cellListL.get(cellNum);     //Updates Current Cell
    p1.x = p1.size;                           //Player location after render
  }
}

//----------------//----------------------//---//  This function holds all player movement and render related functions
//----------------// Player RendMove Func //---//  as to be more easily called upon in finite states or whatever may
//----------------//----------------------//---//  need to access them.
void playerRendMove() {
  p1.moveDown();
  p1.moveUp();
  p1.moveRight();
  p1.moveLeft();
  p1.render();
}

//----------------//-----------------//---//
//----------------// Transition Ease //---//
//----------------//-----------------//---//
void transitionEase() {
  if (p1.x + p1.size*2 >= width) {
    int distanceROut = int(map(p1.x, width-p1.size*3, width, 0, 255));
    tint(255, distanceROut);
    image(transitionImage, 0, 0);
  }
  if (p1.x <= p1.size*3) {
    int distanceROut = int(map(p1.x, 0, p1.size*4, 255, 0));
    tint(255, distanceROut);
    image(transitionImage, 0, 0);
  }
}

//----------------//---------------//---//
//----------------// FireTick Func //---//
//----------------//---------------//---//

void fireTick() {
  if (fireLit == true) {
    endTimeFire = millis();
    if (millis() - startTimeFire >= fireTimeDelay) {
      //println("Fire Decreased");
      fireLeft -= 1;
      println(fireLeft);
      playerScore += 1;
      fireLevel = int(map(fireLeft, 0, 600, 0, 255));
      startTimeFire = millis();
    }
    if (fireLeft <= 0) {
      gameStatesVal += 1;
    }
  }
}

//----------------//------------------------//---//
//----------------// Key Pressed & Released //---//
//----------------//------------------------//---//
void keyPressed() {
  if (buttonStates[7] == 1) {
    p1.isMovingDown = true;
  }
  if (buttonStates[6] == 1) {
    p1.isMovingUp = true;
  }
  if (buttonStates[11] == 1) {
    p1.isMovingRight = true;
    lookingRight = true;
    lookingLeft = false;
  }
  if (buttonStates[8] == 1) {
    p1.isMovingLeft = true;
    lookingLeft = true;
    lookingRight = false;
  }
  if (buttonStates[0] == 1 && shiftPressed == false) {
    if (spacePressed == false) {
      playerVanishAnimationR.index = 0;
      playerVanishAnimationL.index = 0;
      startTime = millis();
    }
    spacePressed = true;
  }
  if (buttonStates[4] == 1) {
    if (fireLit == false) {
      startTimeFire = millis();
    }
    fireLit = true;
  }

  if (buttonStates[1] == 1 && spacePressed == false) {
    if (shiftPressed == false) {
      finishedTalking = false;
      startTime = millis();
    }
    shiftPressed = true;
  }
}

void keyReleased() {
  if (buttonStates[7] == 1) {
    p1.isMovingDown = false;
  }
  if (buttonStates[6] == 1) {
    p1.isMovingUp = false;
  }
  if (buttonStates[11] == 1) {
    p1.isMovingRight = false;
  }
  if (buttonStates[8] == 1) {
    p1.isMovingLeft = false;
  }
  if (buttonStates[0] == 1) {
    if (spacePressed == true && justFlourished == false) {
      playerIdleAnimationR.index = 16;
      playerIdleAnimationL.index = 16;
    } else if (justFlourished == true) {
      justFlourished = false;
    }

    spacePressed = false;
  }
  //if (key == 'r') {
  //}
  if (buttonStates[1] == 1) {
    if (shiftPressed == true) {
      finishedTalking = true;
      canSpeak = true;
    }
    shiftPressed = false;
  }
}

//=========================================================================================================//

void initButtons() {
  for (int i = 0; i < numButtons; i++) {
    try {
      GPIO.pinMode(buttonPins[i], GPIO.INPUT_PULLUP);
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
}

void checkJoy() {
  for (int i = 0; i < numButtons; i++) {
    int s = GPIO.digitalRead(buttonPins[i]);
    if (s == GPIO.LOW) {
      println("Button " + i + " -- PIN " + buttonPins[i] + " was pushed!");
      buttonStates[i] = 1;
    } else {
      buttonStates[i] = 0;
    }
  }
}
