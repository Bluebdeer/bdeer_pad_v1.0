//--------------//
//  Cell Class  //
//--------------//

class Cell {


  //-// Class Variables //-//

  int cellType;  // stores a number value associated with a given cell type
  boolean home;  // home campfire cell (where the player starts)
  boolean wild;  // places other than the home cell
  boolean firstR;
  boolean firstL;

  boolean firstBack;
  boolean secondBack;
  boolean thirdBack;
  boolean fourthBack;
  boolean fifthBack;

  ArrayList<Object> objectList;  // a list that comprises all objects in the cell
  Object forObjects;             // an object that will (in a for loop) equal each object

  int backNum;

  //---// Constructor //---//

  Cell(int tempCellType) {
    cellType = tempCellType;
    objectList = new ArrayList<Object>();
  }

  //-// Functions //-//

  void checkType() {
    if (cellType == 0) {
      home = true;
    }
    if (cellType == 1) {
      wild = true;
    }
    if (cellType == 2) {
      firstR = true;
    }
    if (cellType == 3) {
      firstL = true;
    }
  }

  //-// Create Cell Func //-//
  // This acutally solved a major bug that would constantly
  // add new Objects to ObjectLists in cells as the objectList.add
  // was actually in the typeCell function that was being rendered.

  void generateCell() {
    if (home == true) {
      objectList.add(new Object(width/2-150/2-25, height/3*2-150, 3));
      objectList.add(new Object(width/2-150/2, height/3*2-150/2+25, 0));
      objectList.add(new Object(width/3-60, height/3*2+57, 1));
      objectList.add(new Object(width/3, height/3*2+25, 1));
    }

    if (firstR == true) {
      objectList.add(new Object(width/2, height/3*2+75, 1));
      objectList.add(new Object(width-250, height/3*2+25, 2));
    }

    if (firstL == true) {
      objectList.add(new Object(width/2, height/3*2+75, 1));
      objectList.add(new Object(250, height/3*2+25, 2));
    }

    int wildVariation = 0;

    if (wild == true) {

      backNum = int(random(1, 100)); //Random number to determine background variant

      if (firstBack == true) {  //These make sure the previous background isn't repeated right after it
        backVar = 1;
      };
      if (secondBack == true) {
        backVar = 2;
      };
      if (thirdBack == true) {
        backVar = 3;
      };
      if (fourthBack == true) {
        backVar = 4;
      };
      if (fifthBack == true) {
        backVar = 5;
      };

      wildVariation = int(random(0, 10));
      println("wildvaritaion true");

      if (wildVariation >= 0 && wildVariation < 1) {
        objectList.add(new Object(200, height/3*2, 2));
        objectList.add(new Object(450, height/3*2, 2));
        objectList.add(new Object(600, height/3*2+57, 1));
        objectList.add(new Object(650, height/3*2+25, 1));
        objectList.add(new Object(700, height/3*2+57, 1));
      }
      if (wildVariation >= 1 && wildVariation < 2) {
        objectList.add(new Object(width/3+200, height/3*2+25, 1));
        objectList.add(new Object(width-400, height/3*2, 2));
      }
      if (wildVariation >= 2 && wildVariation < 3) {
        objectList.add(new Object(width/2, height/3*2+50, 1));
        objectList.add(new Object(width/2+50, height/3*2+75, 1));
        objectList.add(new Object(375, height/3*2+25, 2));
        objectList.add(new Object(width-375, height/3*2, 2));
      }
      if (wildVariation >= 3 && wildVariation < 4) {
        objectList.add(new Object(200, height/3*2+50, 1));
        objectList.add(new Object(600, height/3*2, 2));
        objectList.add(new Object(850, height/3*2, 2));
        objectList.add(new Object(1000, height/3*2, 2));
      }
      if (wildVariation >= 4 && wildVariation < 5) {
        objectList.add(new Object(width-150, height/3*2+50, 1));
        objectList.add(new Object(width-100, height/3*2+75, 1));
        objectList.add(new Object(150, height/3*2, 2));
        objectList.add(new Object(375, height/3*2, 2));
      }
      if (wildVariation >= 5 && wildVariation < 6) {
        objectList.add(new Object(width/2, height/3*2+50, 1));
        objectList.add(new Object(width/2+50, height/3*2+75, 1));
        objectList.add(new Object(width-200, height/3*2+100, 1));
        objectList.add(new Object(200, height/3*2+60, 1));
      }
      if (wildVariation >= 6 && wildVariation < 7) {
        objectList.add(new Object(width/2, height/3*2, 2));
      }
      if (wildVariation >= 7 && wildVariation < 8) {
        objectList.add(new Object(200, height/3*2+50, 1));
        objectList.add(new Object(850, height/3*2, 2));
      }
      if (wildVariation >= 8 && wildVariation < 9) {
        objectList.add(new Object(width/2, height/3*2+80, 1));
      }
      if (wildVariation >= 9 && wildVariation < 10) {
        objectList.add(new Object(300, height/3*2, 2));
        objectList.add(new Object(width/2, height/3*2, 2));
        objectList.add(new Object(width-300, height/3*2, 2));
      }
    }
  }

  //---------------------------//

  void homeCell() {
    background(42);
    tint(255, 255);
    image(backgroundHomeStill, 0, 0);
    image(homeFloorStill, 0, height/3*2-50);
  }

  void wildCell() {

    background(42);
    tint(255, 255);

    if (backNum < 20 && backVar != 1) {  //Tree Background Selector
      image(wildBackground1, 0, 0);
      firstBack = true;
    }
    if (backNum >= 20 && backNum < 40 && backVar != 2) {
      image(wildBackground2, 0, 0);
      secondBack = true;
    }
    if (backNum >= 40 && backNum < 60 && backVar != 3) {
      image(wildBackground3, 0, 0);
      thirdBack = true;
    }
    if (backNum >= 60 && backNum < 80 && backVar != 4) {
      image(wildBackground4, 0, 0);
      fourthBack = true;
    }
    if (backNum >= 80 && backNum <= 100 && backVar != 5) {
      image(wildBackground5, 0, 0);
      fifthBack = true;
    }
    image(wildFloor, 0, height/3*2-50);
  }

  void chosenCell() {
    if (home == true) {
      homeCell();
      //println("home true");
    }
    if (wild == true) {
      wildCell();
      //println("wild true");
    }
    if (firstR == true) {
      wildCell();
    }
    if (firstL == true) {
      wildCell();
    }
  }

  void playSpaceCheck() {
    if (p1.y <= height/3+height/3) {
      p1.isAbleToMoveUp = false;
    }
    if (p1.y+p1.size >= height) {
      p1.isAbleToMoveDown = false;
    }
  }

  void renderObjects() {

    p1.isAbleToMoveUp = true;
    p1.isAbleToMoveDown = true;
    p1.isAbleToMoveLeft = true;
    p1.isAbleToMoveRight = true;

    for (int i=objectList.size()-1; i >= 0; i--) {
      forObjects = objectList.get(i);

      if (forObjects.logMoved == true) {
        objectList.remove(i);
      }

      if (forObjects.isGathered == true) {
        objectList.remove(i);
        p1.totalSticks += 1;
        println("Num of Sticks:" + p1.totalSticks);
      } else {
        forObjects.render();
      }
    }
  }

  void render() {
    checkType();
    chosenCell();
    renderObjects();
    playSpaceCheck();
  }
}
