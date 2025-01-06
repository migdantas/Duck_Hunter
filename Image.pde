class Image {
  //Global variables.
  PImage ima, frame;
  int posX, posY;
  int ms, dcs, dms;
  String imgname;
  
  //Constructor for image type.
  Image(String im) {
    ima = loadImage(im);
    imgname = im;
    ms = millis();
    dcs = 0;
    dms = 0;
    posX = 0;
    posY = 0;
  }
  
  //Draw static background images.
  void draws() {
    imageMode(CENTER);
    image(ima, width/2, height/2);
  }
  
  //Draw idle "animations" for dog and ducks
  void drawsidle(int x, int y, int incx, int incy) {
    
    ms = millis();
    dcs = ((ms/ 100) % 60)%10;
    
    //These 2 if conditionals alternate between the normal animation, using a counter variable (ms) to know when to switch.
    if(dcs >= 0 && dcs < 5) {
      frame = ima.get(posX, posY,incx,incy);
    }
    else if(dcs >= 5 && dcs < 10) {
      frame = ima.get(incx, posY,incx,incy);
    }
    
    //Resize the dog and ducks
    if(imgname == "doggo.png") frame.resize(210,165);
    else if(imgname == "duck1.png" || imgname == "duck2.png") frame.resize(120,120);
    image(frame, x, y);
  }
  
  //Draw static images, in this case, just for score pics.
  void drawscore(int x, int y,boolean highscore) {
    posX = x;
    posY = y;
    imageMode(CORNER);
    if(highscore) ima.resize(110,25);
    else ima.resize(85,25);
    image(ima, x, y);
  }
  
  //class that draws any object that we may wish to resize, being x and y the top coordinates and rx and ry the coordinates to resize to
  void drawobjects(int x, int y,int rx, int ry) {
    posX = x;
    posY = y;
    imageMode(CORNER);
    ima.resize(rx,ry);
    image(ima, x, y);
  }
}
