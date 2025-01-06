//class for the dog, since he's the only one capable of shooting.
Image doggo, heart;

class Dog {
  int posX, posY, speed, health;
  
  //Dog constructor
  Dog() {
  posX = 200;
  posY = 360;
  health = 0;
  speed = 5;
  doggo = new Image("doggo.png");
  heart = new Image("heart.png");
  }
  
  void moving(int a) {
    //applies movement & restrictions
    if(posY > 83 && a == 1)  posY -= 3;
    else if(posX < (width - 100) && a == 2)  posX += 3;
    else if(posY < (height - 83) && a == 3)  posY += 3;
    else if(posX > 100 && a == 4)  posX -= 3;
    doggo.drawsidle(posX,posY,700,550);
  }
  
  //controls the drawing of the Dogs health
  void hearts(int x, int y) {
    for(int i=0;i<health;i++) {
      heart.drawobjects(x+(i*35),y,35,35);
    }
  }
}
