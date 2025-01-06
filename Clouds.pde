//Creeated for optimization purposes, since clouds just have these and there's still a fair amount of them.
class Clouds {
  //Global variables.
  PImage ima;
  float posX, posY, speed;
  
  //Clouds constructor
  Clouds(String im) {
    ima = loadImage(im);
    posX = random(60,900);
    posY = random(80,520);
    speed = random(0.3,1.5);
  }
  
  //Movement function for clouds 
  void moving() {
    imageMode(CENTER);
    if(posX <= -150) {
      posX = 1110;
      posY = random(80,520);
    }
    posX -= speed;
    image(ima, posX, posY);
  }
}
