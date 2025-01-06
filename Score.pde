Image scor, high;

class Score {
  PImage ima, frame;
  int posX, posY, score;
  
  //score constructor
  Score() {
    scor = new Image("score.png");
    high = new Image("hiscore.png");
    score = 0;
    ima = loadImage("numbers.png");
  }
  
  //function that draws both the score and highscore
  void draws(int x, int y, int sc, boolean highscore) {
    imageMode(CORNER);
    int current;
    int inc;
    score = sc;
    
    //positioning both the score and highscore
    if (highscore) {
      high.drawscore(x,y,highscore);
      inc = 80 + 115;
    }
    else {
      scor.drawscore(x,y,highscore);
      inc = 80 + 90;
    }
    
    // "printing" the score in 6 digits
    for(int i=0;i<6;i++) {
      current = score%10;
      score = score/10;
      frame = ima.get(posX+(current*40), posY,30,50);
      frame.resize(15,25);
      image(frame, x+inc-(16*i), y);
    }
  }
}
