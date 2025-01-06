Image ducky1, ducky2;

class Ducks {
  int ms, dcs;
  int health, score;
  int posX, posY, speed, ducky;
  boolean firstrun = true;
  boolean fdeath = false;
  
  //Duck constructor
  Ducks() {
    ms = 0;
    health = 0;
    score = 0;
    posX = int(random(2000,4000));
    posY = int(random(100,630));
    ducky1 = new Image("duck1.png");
    ducky2 = new Image("duck2.png");
  }
  
  void moving(int difficulty) {
    //firstrun sets up all stats for the Ducks
    if (firstrun) {
      posX = int(random(2000,4000));
      posY = int(random(100,630));
      // difficulty 0(Easy) Initialize
      if (difficulty == 0) {                  
        speed = int(random(1,3));
        posX -= speed;
        //randomizer for the 2 types of Duck
        if(0.15>random(0,1)) {
          ducky2.drawsidle(posX,posY,400,400);
          ducky = 2;
          health = 2;
        }
        else {
          ducky1.drawsidle(posX,posY,400,400);
          ducky = 1;
          health = 1;
        }
      }
      // difficulty 1(Normal) Initialize
      else if (difficulty == 1) {
        speed = int(random(2,5));
        posX -= speed;
        //randomizer for the 2 types of Duck
        if(0.2>random(0,1)) {
          ducky2.drawsidle(posX,posY,400,400);
          ducky = 2;
          health = 2;
        }
        else {
          ducky1.drawsidle(posX,posY,400,400);
          ducky = 1;
          health = 1;
        }
      }
      // difficulty 2(Hard) Initialize
      else if (difficulty == 2) {
        speed = int(random(5,7));
        posX -= speed;
        //randomizer for the 2 types of Duck
        if(0.3>random(0,1)) {
          ducky2.drawsidle(posX,posY,400,400);
          ducky = 2;
          health = 2;
        }
        else {
          ducky1.drawsidle(posX,posY,400,400);
          ducky = 1;
          health = 1;
        }
      }
      //switch the first run off
      firstrun = false;
    }
    else {
      posX -= speed;
      //average draw of the ducks
      if (ducky == 1) ducky1.drawsidle(posX,posY,400,400);
      else if (ducky == 2) ducky2.drawsidle(posX,posY,400,400);
      //position restart
      if (posX <=-120) {
        posX = int(random(2000,4000));
        posY = int(random(100,630));
      }
    }
  }
  
  int hit() {
    score = 0;
    health--;
    if(health == 0) {
      if(ducky == 1) {
        score = 100;
        health = 1;
      }
      if(ducky == 2) {
        score = 220;
        health = 2;
      }
      posX = int(random(2000,5000));
      posY = int(random(60,630));
    }
    return score;
  }
}
