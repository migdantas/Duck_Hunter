class Bullet {
  PImage ima;
  int posX, posY;
  int speed;
  
  //bullet constructor
  Bullet(int x,int y) {
    ima = loadImage("bullet.png");
    posX = x;
    posY = y;
    speed = 20;
  }
  
  //function that draws the shooting bullet
  void shoot() {
    posX += speed;
    imageMode(CENTER);
    ima.resize(30,20);
    image(ima, posX, posY);
  }
}
