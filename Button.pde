//----------------//
//  Button Class  //
//----------------//

class Button {

  //-// Class Variables //-//

  float x;  // x pos
  float y;  // y pos
  float w;  // width
  float h;  // height
  color c;  // color

  //---// Constructor //---//

  Button(float tempX, float tempY, float tempW, float tempH, color tempC) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    c = tempC;
  }

  //-// Functions //-//

  void render() {
    fill(c);
    noStroke();
    rect(x, y, w, h, w/2-w/4);
  }

  //---// Button Pressed Func Stuff //---//

  boolean isBetween(float in1, float in2, float in3) {
    if (in1 > in2 && in1 < in3) {
      return true;
    } else {
      return false;
    }
  }

  boolean isInButton(float x, float y, float butWidth, float butHeight) {
    if (isBetween(mouseX, x, x+butWidth) == true && isBetween(mouseY, y, y+butHeight)) {
      return true;
    } else {
      return false;
    }
  }

  boolean isPressed() {
    if (mousePressed == true && isInButton(x, y, w, h) == true) {
      return true;
    } else {
      return false;
    }
  }

  //---------------------------------------//
}
