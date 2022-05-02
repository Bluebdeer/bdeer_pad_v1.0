//===================//
// bdeerPad TestGame //
//===================//

//-// Libraries //-//
import processing.io.*;


//-// Global Vars //-//

int playerX;
int playerY;
color playerC;

boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

boolean xState;
boolean yState;
boolean aState;
boolean bState;

//==//==========================================================//==//
int[] buttonPins = {2, 3, 4, 17, 27, 22, 5, 6, 13, 14, 15, 12}; //==//
int[] buttonStates = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};      //==//
int numButtons = 12;                                            //==//
//==//==========================================================//==//

//-// Setup //-//

void setup() {

  size(640, 480);
  playerX = width/2;
  playerY = height/2;
  playerC = color(0, 150, 150);
  
  isMovingUp = false;
  isMovingDown = false;
  isMovingLeft = false;
  isMovingRight = false;
  
  xState = false;
  yState = false;
  aState = false;
  bState = false;

  //============//==//
  initButtons();//==//
  //============//==//
}

//-// Draw //-//

void draw() {
  
  background(42);
  checkJoy();
  playerRend();
  
}

//-// Functions //-//

void playerRend(){
  keyPressed();
  playerMove();
  playerColor();
  fill(playerC);
  rect(playerX, playerY, 15, 15);
  keyReleased();
}

void playerColor() {
  if(xState == true){
    playerC = color(150,150,150);
  }
  if(yState == true){
    playerC = color(0,0,150);
  }
  if(aState == true){
    playerC = color(255,255,255);
  }
  if(bState == true){
    playerC = color(0,150,0);
  }
}

void playerMove() {
  if(isMovingUp == true){
    playerY -= 3;
    println("MovingUp");
  }
  if(isMovingDown == true){
    playerY += 3;
    println("MovingDown");
  }
  if(isMovingLeft == true){
    playerX -= 3;
    println("MovingLeft");
  }
  if(isMovingRight == true){
    playerX += 3;
    println("MovingRight");
  }
}

void keyPressed() {
  if (buttonStates[7] == 1) {
    isMovingDown = true;
  }
  if (buttonStates[6] == 1) {
    isMovingUp = true;
  }
  if (buttonStates[11] == 1) {
    isMovingRight = true;
  }
  if (buttonStates[8] == 1) {
    isMovingLeft = true;
  }
  
  if (buttonStates[0] == 1) {
    aState = true;
  }
  if (buttonStates[2] == 1) {
    xState = true;
  }
  if (buttonStates[1] == 1) {
    bState = true;
  }
  if (buttonStates[3] == 1) {
    yState = true;
  }
}

void keyReleased() {
  if (buttonStates[7] == 1) {
    isMovingDown = false;
  }
  if (buttonStates[6] == 1) {
    isMovingUp = false;
  }
  if (buttonStates[11] == 1) {
    isMovingRight = false;
  }
  if (buttonStates[8] == 1) {
    isMovingLeft = false;
  }
  
  if (buttonStates[0] == 1) {
    aState = false;
  }
  if (buttonStates[2] == 1) {
    xState = false;
  }
  if (buttonStates[1] == 1) {
    bState = false;
  }
  if (buttonStates[3] == 1) {
    yState = false;
  }
}

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
      //println("Button " + i + " -- PIN " + buttonPins[i] + " was pushed!");
      buttonStates[i] = 1;
    } else {
      buttonStates[i] = 0;
    }
  }
}
