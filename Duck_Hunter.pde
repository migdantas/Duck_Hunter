//Initialize custom global variables
Clouds[] cloud;                           //initialize cloud objects
Ducks[] duck;                             //initialize duck object string
Dog dog;                                  //initialize dog object
Image menu, level, options,pause, hint;   //initialize all backgrounds/big images
Image lose, win;                          //initialize win(normal) and lose images
Image select, check;                      //initialize the menu/options icon and the checkmark
Bullet bullet;                            //initialize bullet
Score curscore, highscore;                //initialize score indicator object
//Initialize global variables
int sx = 295, sy = 405;                   //select menu icon coordenate variables
int ox = 255, oy = 295;                   //select options icon coordenate variables
int bulx, buly;                           //bullet position
int score = 0, highsc = 0;                //for score and highscore in Normal mode
int escore = 0, ehighsc = 0;                //for score and highscore in Endless mode
int screen = 0;                           //determines what screen you're in
int direction = 0, presses = 0;           //for movement of dog
int countinv = 0;                         //counts dog invulnerability
int kills = 0;                            //counts kills for normal mode
int difficulty = 1;                       //difficulty variable, 0, 1, 2 being respectively "Easy", "Normal" and "Hard"
boolean shot = false, hit = false;        //detects if there has been a shot and if there was a hit respectively
boolean healthcheck = true;               //checks if health has been atributed
boolean endless = false;                  //sets game as Normal(False) or Endless(True)
boolean hints = true, firstime = true;    //sets hints turned on, plus flag to check if it can show hints at start

void setup() {
  size(960, 720, P2D);
  
  //initializing strings and new types
  dog = new Dog();
  curscore = new Score();
  highscore = new Score();
  cloud = new Clouds[3];
  duck = new Ducks[8];
  //Initialize all the images
  menu = new Image("menu.png");
  level = new Image("background.png");
  options = new Image("options.png");
  pause = new Image("pause.png");
  hint = new Image("hints.png");
  lose = new Image("lose.png");
  win = new Image("win.png");
  select = new Image("select.png");
  check = new Image("checkmark.png");
  cloud[0] = new Clouds("cloud1.png");
  cloud[1] = new Clouds("cloud2.png");
  cloud[2] = new Clouds("cloud3.png");
  
  //Initialize ducks
  for(int i = 0;i<duck.length;i++) {
    duck[i] = new Ducks();
  }
}


void draw() {
  //Menu Screen
  if(screen == 0) {
    //restart health, hints, escore, score, kills, presses & invincibility counter
    healthcheck = true;
    firstime = true;
    escore = 0;
    score = 0;
    kills = 0;
    presses = 0;
    countinv = 0;
    //restart ducks
    for(int i = 0;i<duck.length;i++) {
      duck[i].firstrun = true;
    }
    menu.draws();
    select.drawsidle(sx,sy,90,90);
  }
  //Game Screen
  if(screen == 1) {
    level.draws();
    
    //clouds moving
    for(int i = 0;i<cloud.length;i++){
      cloud[i].moving();
    }
    
    //Draws hints at start
    if(hints) {
      if(firstime) {
        if(countinv < 250) hint.draws();
        if(countinv == 250) firstime = false;
      }
    }
    
    //dog movement
    dog.moving(direction);
    
    //dogs lives
    if(healthcheck){
      if(difficulty == 0) dog.health = 5;
      else if (difficulty == 1) dog.health = 3;
      else if (difficulty == 2) dog.health = 1;
      healthcheck = false;
    }
    
    //active verification if shot has been shot
    if(shot && bullet.posX < width) bullet.shoot();
    else shot = false;
    
    //everything that ducks do "colisions"
    for(int i = 0;i<duck.length;i++){
      
      //verifies hit with bullet and resets shot and duck
      if(shot && dist(bullet.posX,bullet.posY,duck[i].posX,duck[i].posY) <= 70) {
        hit = true;
        shot = false;
      }
      //increases score in Endless
      if(hit && endless) {
        escore += duck[i].hit();
      }
      //increases score and kill count in Normal
      if(hit && !endless) {
        //current used to verify if the hit was a kill or not
        int current = score;
        score += duck[i].hit();
        if (current != score) kills++;
        if(kills == 10) screen = 4;
      }
      hit = false;
      
      if(!hit) duck[i].moving(difficulty);
      
      //verifies hit with dog and vulnerability
      if(dist((dog.posX),(dog.posY),duck[i].posX,duck[i].posY) <= 70 && countinv>=100) {
        dog.health--;
        //checks lose condition
        if(dog.health == 0) screen = 5;
        countinv = 0;
      }
    }
    
    //draws current hearts
    dog.hearts(1,684);
    
    if(endless) {
      //draws the current score
      curscore.draws(1,1,escore, false);
      //replaces(if higher) and draws highscore
      if(escore > ehighsc) ehighsc = escore;
      highscore.draws(749,1,ehighsc, true);
    }
    else {
      //draws the current score
      curscore.draws(1,1,score, false);
      //replaces(if higher) and draws highscore
      if(score > highsc) highsc = score;
      highscore.draws(749,1,highsc, true);
    }
    //invulnerability counter iterating
    countinv++;
  }
  //Options Menu
  if(screen == 2) {
    options.draws();
    select.drawsidle(ox,oy,90,90);
    if(hints) check.drawobjects(840,640,100,50);
  }
  //Pause screen
  if(screen == 3) {
    pause.draws();
  }
  //Win screen
  if(screen == 4) {
    win.draws();
  }
  //Lose screen
  if(screen == 5) {
    lose.draws();
  }
}

void keyPressed() {
  //Potential menu key presses
  if(screen == 0) {
    if(key == 's' && sy <= 600) sy += 120;
    else if(key == 'w' && sy >= 420) sy -= 120;
    else if(key == 'e' && sy == 405) screen = 1;
    else if(key == 'e' && sy == 525) screen = 2;
    else if(key == 'e' && sy == 645) exit();
  }
  //Potential game key presses
  if(screen == 1) {
    //'wasd' movement keys
    if(key == 'p') {
      screen = 3;
    }
    else if(key == 'w') {
      direction = 1;
      presses++;
    }
    else if(key == 'd') {
      direction = 2;
      presses++;
    }
    else if(key == 's') {
      direction = 3;
      presses++;
    }
    else if(key == 'a') {
      direction = 4;
      presses++;
    }
    //SPACE BAR as shoot button
    else if(key == ' ' && !shot) {
      bulx = dog.posX+105;
      buly = dog.posY+60;
      bullet = new Bullet(bulx,buly);
      shot = true;
    }
  }
  if(screen == 2) {
    //Controls for options(yes, i had to do specific coordinates, i couldn't line up the coordinates while creating assets
    if(key == 'd') {
      if(ox == 255 && oy == 295 || ox == 345 && oy == 525) ox += 360;
      else if(ox == 85 && oy == 525) ox += 260;
      else if(ox == 55 && oy == 665) ox += 550;
    }
    else if(key == 'a') {
      if(ox == 615 && oy == 295 || ox == 705 && oy == 525) ox -= 360;
      else if(ox == 345 && oy == 525) ox -= 260;
      else if(ox == 605 && oy == 665) ox -= 550;
    }
    else if(key == 'w') {
      if(ox == 85 && oy == 525 || ox == 345 && oy == 525 || ox == 705 && oy == 525) {
        ox = 255;
        oy = 295;
      }
      else if(ox == 55 && oy == 665 || ox == 605 && oy == 665) {
        ox = 85;
        oy = 525;
      }
    }
    else if(key == 's') {
      if(ox == 255 && oy == 295 || ox == 615 && oy == 295) {
        ox = 85;
        oy = 525;
      }
      else if(ox == 85 && oy == 525 || ox == 345 && oy == 525 || ox == 705 && oy == 525) {
        ox = 55;
        oy = 665;
      }
    }
    else if(key == 'e') {
      if(ox == 255 && oy == 295) endless = false;
      else if (ox == 615 && oy == 295) endless = true;
      else if(ox == 85 && oy == 525) difficulty = 0;
      else if(ox == 345 && oy == 525) difficulty = 1;
      else if(ox == 705 && oy == 525) difficulty = 2;
      else if(ox == 55 && oy == 665) screen = 0;
      else if(ox == 605 && oy == 665 && hints) hints = false;
      else if(ox == 605 && oy == 665 && !hints) hints = true;
    }
  }
  //Pause Menu
  if(screen == 3) {
    if(key == 'f') screen = 1;
    if(key == ENTER) screen = 0;
  }
  if((screen == 4 || screen == 5) && key >=0 && key <=255) screen = 0;
}

//reset for movement keys
void keyReleased() {
  if(screen == 1) {
    if(key == 'w') presses--;
    else if(key == 'd') presses--;
    else if(key == 's') presses--;
    else if(key == 'a') presses--;
    if(presses == 0) direction = 0;
  }
}
