final static float MOVE_SPEED = 6.0;
final static float SPRITE_SCALE = 64/64;
final static int SPRITE_SIZE = 64;
final static float GRAVITY = 0.6;
final static float JUMPING_SPEED = 14;

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 400;
final static float VERTICAL_MARGIN = 40;

final static float SCREEN_WIDTH = SPRITE_SIZE * 15;
final static float SCREEN_HEIGHT = SPRITE_SIZE * 10;
final static float GROUND_LEVEL = SCREEN_HEIGHT - SPRITE_SIZE;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;

Player player;
PImage character, tiles, imgHolder;
PImage[] imgArray;
ArrayList <Sprite> platforms;

float viewX;
float viewY;

boolean isGameOver;
boolean obstacle;
boolean win = false;
boolean showEditor = false;
boolean showControls = true;

int level = 1;
int timesPressed1 = 0;
int timesPressed2 = 1;
int imgNum;
int col, row;
int positionX, positionY;

int[] mapLevel1 = {
  24,24,24,24,24,24,24,24,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,19,19,19,19,19,10,10,10,10,10,10,10,10,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,19,19,19,19,19,19,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,10,10,10,19,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,22,22,22,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,1,24,24,1,24,24,1,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,31,31,31,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,37,24,24,24,24,24,24,24,39,24,24,24,39,24,24,39,24,24,1,24,24,39,1,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,24,24,39,24,24,24,24,24,24,24,24,24,39,24,24,24,24,24,24,24,39,24,24,24,39,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,36,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  1,1,1,1,46,1,1,1,1,1,1,1,48,1,1,1,48,1,1,48,24,24,24,24,24,48,10,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,1,1,48,1,42,42,42,1,1,24,24,1,48,1,42,1,24,24,1,1,48,42,42,1,48,1,1,1,1,1,24,1,1,1,1,6,7,8,1,1,45,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,43,43,43,43,43,10,10,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,10,24,24,10,10,10,10,51,51,51,10,10,24,24,10,10,10,51,10,43,43,10,10,10,51,51,10,10,10,10,10,10,10,24,10,10,10,10,15,16,17,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
};

int[] mapLevel2 = {
  24,24,24,24,24,24,24,24,24,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,10,10,10,10,10,10,10,10,10,10,10,10,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,22,22,10,10,10,10,10,10,10,10,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,31,31,10,10,10,10,10,10,19,19,24,24,24,24,24,24,24,24,39,24,24,24,39,24,24,39,24,24,39,24,24,24,24,24,24,24,24,24,19,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,22,22,22,22,22,22,24,24,24,24,24,24,24,24,24,1,48,1,24,1,48,1,1,48,24,1,48,1,1,24,24,24,24,24,24,24,24,19,19,10,10,10,19,19,19,19,19,19,19,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,31,31,31,31,31,31,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,22,22,22,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,31,31,31,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,1,24,1,1,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,39,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,37,24,24,24,24,24,24,24,24,42,24,24,24,24,24,24,24,24,24,1,24,39,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,1,1,39,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,48,24,24,24,1,39,24,24,24,24,24,24,24,24,39,24,24,24,24,39,42,24,24,36,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  1,1,1,1,46,1,1,1,1,42,42,1,1,51,1,1,24,24,24,1,24,24,24,24,24,48,24,24,1,1,24,42,42,42,42,24,42,42,42,42,24,24,24,24,48,1,6,7,8,1,1,6,7,8,1,24,24,1,24,24,24,24,24,24,24,48,1,1,24,1,1,42,42,1,48,24,24,1,1,48,51,1,1,45,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  10,10,10,10,10,10,10,10,10,51,51,10,10,10,10,10,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,51,51,51,51,24,51,51,51,51,24,24,24,24,24,24,15,16,17,10,10,15,16,17,24,24,24,24,24,24,24,24,24,24,24,10,10,10,24,10,10,51,51,10,10,24,24,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
};

int[] mapLevel3 = {
  24,24,24,24,24,24,24,24,22,22,22,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,19,19,19,19,19,19,19,19,22,22,22,22,22,22,22,22,22,22,22,22,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,11,22,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,31,31,31,22,22,22,10,10,10,10,10,10,10,10,10,10,10,19,19,19,24,24,24,24,24,24,24,24,31,31,31,31,31,31,31,31,31,31,31,31,19,19,19,19,19,19,19,19,19,19,19,10,10,10,10,10,10,10,10,10,10,10,10,10,11,22,22,31,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,31,31,31,19,19,19,19,19,19,19,19,19,19,19,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,39,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,19,11,10,10,10,10,10,10,10,10,10,10,22,22,31,31,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,1,1,1,1,48,1,1,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,19,11,10,10,10,10,10,10,22,22,22,31,31,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,39,1,24,24,24,22,22,22,22,19,19,19,19,24,24,24,24,24,24,24,24,39,24,24,24,24,24,24,24,24,19,19,19,19,19,19,19,31,31,31,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,36,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,48,33,33,24,24,31,31,31,31,24,24,24,24,24,24,24,1,42,42,1,1,48,1,24,39,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,45,
  24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,33,33,24,24,24,24,24,24,24,24,24,24,24,24,1,10,51,51,10,10,10,10,1,48,1,42,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,1,24,24,24,24,24,24,24,24,24,24,24,24,
  24,24,24,24,37,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,39,39,24,24,24,24,24,24,24,24,39,24,24,24,1,10,10,10,10,10,10,10,10,10,10,10,51,1,39,24,39,39,39,24,24,24,24,24,43,24,39,39,39,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,24,
  1,1,1,1,46,1,1,1,1,1,24,24,24,1,24,24,1,42,42,42,1,1,6,8,1,24,1,24,24,10,1,48,48,1,1,1,24,1,24,1,24,48,1,24,24,10,10,10,10,10,10,10,10,10,10,10,10,10,10,48,1,48,48,48,1,42,42,1,1,52,1,48,48,48,1,34,34,34,34,34,34,34,34,34,34,34,34,34,24,24,24,24,24,24,24,24,24,24,24,24,
  10,10,10,10,10,10,10,10,10,10,43,43,43,10,24,24,10,51,51,51,10,10,15,17,10,24,24,24,24,10,10,10,10,10,10,10,24,10,24,10,24,10,10,43,43,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,51,51,10,10,10,10,10,10,10,10,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43
};

void setup(){
  size(960,640);
  imageMode(CENTER);
  character = loadImage("004res.png");
  player = new Player(character, 0.9);
  player.setBottom(GROUND_LEVEL);
  player.centerX = 435;
  
  platforms = new ArrayList <Sprite>();
  
  isGameOver = false;
  obstacle = false;
  win = false;
  
  tiles = loadImage("Tilemap.png");
  col = tiles.width / SPRITE_SIZE;
  row = tiles.height / SPRITE_SIZE;
  createImgArray();
  
  createLevel();

  viewX = 0;
  viewY = 0;
}

void draw(){
  if(level == 1){
    background(175,175,175);
  }else if (level == 2){
    background(188,176,117);
  }else{
    background(104,127,161);
  }
  
  moveScreen();
  
  for(Sprite s: platforms){
    s.display();
  }
  player.display();
  
  if(!showEditor && showControls){
    displayControls();
  }
  
  if(showEditor){   
    image(tiles, viewX + (tiles.width / 4), viewY + (tiles.height / 4), 576/2, 576/2);
    image(imgHolder, mouseX + viewX, mouseY + viewY, 64, 64);
  }
  
  if(isGameOver){
    displayText();
  }
  
  if(!isGameOver){
    player.updateAnimation();
    resolveCollisions(player, platforms);
    isDead();
  } 
}

public void displayControls(){
    fill(255);
    textSize(28);
    text("CONTROLS: ",viewX + 40, viewY + 60);
    text("Move right: →", viewX + 40, viewY + 105);
    text("Move left: ←", viewX + 40, viewY + 155);
    text("Jump: ↑", viewX + 40, viewY + 205);
    text("Edit tilemap: e", viewX + 40, viewY + 255);
    text("Show controls: c", viewX + 40, viewY + 305);
    text("Exit: esc", viewX + 40, viewY + viewY + 355);
}

public void displayText(){
    fill(255);
    textSize(32);
    if(win){
      if (level >= 3){
        text("YOU HAVE COMPLETED THE GAME!", viewX + width/2 - 100, viewY + height/2);
        text("Press SPACE to restart", viewX + width/2 - 100, viewY + height/2 + 100);
      }else{
         text("LEVEL COMPLETED!", viewX + width/2 - 100, viewY + height/2);
         text("Press SPACE to go to the next level", viewX + width/2 - 100, viewY + height/2 + 100);
      }
    }
    else{
      text("GAME OVER!", viewX + width/2 - 100, viewY + height/2);
      text("Press SPACE to restart", viewX + width/2 - 100, viewY + height/2 + 100);
    }
}

void createLevel(){
  if(level == 1){
    createPlatforms(mapLevel1);
  }
  if(level == 2){
    createPlatforms(mapLevel2);
  }
  else if (level == 3){
    createPlatforms(mapLevel3);
  }else{
    createPlatforms(mapLevel1);
  }
}

void isDead(){
  boolean fall = player.getBottom() > GROUND_LEVEL;
  if(fall || obstacle || win){
    isGameOver = true;
  }
}

void moveScreen(){

  float rBound = viewX + width - RIGHT_MARGIN;
  if(player.getRight() > rBound){
    viewX += player.getRight() - rBound;
  }
 
  float lBound = viewX + LEFT_MARGIN;
  if(player.getLeft() < lBound){
    viewX -= lBound - player.getLeft();
  }
  
  float bBound = viewY + height - VERTICAL_MARGIN;
  if(player.getBottom() > bBound){
    viewY += player.getBottom() - bBound;
  }
  
  float tBound = viewY + VERTICAL_MARGIN;
  if(player.getTop() < tBound){
    viewY -= tBound - player.getTop();
  }
  
  translate(-viewX, -viewY);
}

public boolean isOnPlatform(Sprite s, ArrayList <Sprite> blocks){
  s.centerY += 5;
  ArrayList <Sprite> collision = checkCollisionList(s, blocks);
  s.centerY -= 5;
  if(collision.size() > 0){
    return true;
  }
  else{
    return false;
  }
}

boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap, noYOverlap;
  
  if(s2.image != imgArray[37] && 
     s2.image != imgArray[24] &&
     s2.image != imgArray[39] && 
     s2.image != imgArray[31]){
    noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
    noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  }
  else{
    noXOverlap = true;
    noYOverlap = true;
  }
  
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}

public ArrayList <Sprite> checkCollisionList (Sprite s, ArrayList <Sprite> spriteList){
  ArrayList <Sprite> collisionList = new ArrayList <Sprite>();
  for(Sprite p: spriteList){
    if(checkCollision(s, p)){
      collisionList.add(p);
    }
  }
  return collisionList;
}

public void resolveCollisions(Sprite s, ArrayList <Sprite> blocks){

  s.changeY += GRAVITY;
  s.centerY += s.changeY;
  ArrayList <Sprite> collisions = checkCollisionList(s, blocks);
  if(collisions.size() > 0){ 
    Sprite collided = collisions.get(0);
    if(collided.image == imgArray[48] ||
       collided.image == imgArray[22] ||
       collided.image == imgArray[42] || 
       collided.image == imgArray[43] ||
       collided.image == imgArray[6] ||
       collided.image == imgArray[7] ||
       collided.image == imgArray[8]){
      obstacle = true;
    }
    if(collided.image == imgArray[36]){
      win = true;
      level++;
    }
    if(s.changeY > 0){ 
      s.setBottom(collided.getTop());
    }
    else if(s.changeY < 0){ 
      s.setTop(collided.getBottom());
    }
    s.changeY = 0;
  }
   
  s.centerX += s.changeX;
  collisions = checkCollisionList(s, blocks);
  if(collisions.size() > 0){ 
    Sprite collided = collisions.get(0);
    if(collided.image == imgArray[48] ||
       collided.image == imgArray[22] ||
       collided.image == imgArray[42] || 
       collided.image == imgArray[43] ||
       collided.image == imgArray[6] ||
       collided.image == imgArray[7] ||
       collided.image == imgArray[8]){
      obstacle = true;
    }
    if(collided.image == imgArray[36]){
      win = true;
      level++;
    }
    if(s.changeX > 0){ 
      s.setRight(collided.getLeft());
    }
    else if(s.changeX < 0){ 
      s.setLeft(collided.getRight());
    }
  }
}

void keyPressed(){
  if(keyCode == RIGHT){
    player.changeX = MOVE_SPEED;
  }
  else if(keyCode == LEFT){
    player.changeX = -MOVE_SPEED;
  }
  else if(keyCode == UP && isOnPlatform(player, platforms)){
    player.changeY = -JUMPING_SPEED;
  }
  else if(isGameOver && key == ' '){
    setup();
  }
  else if(key == 'e'){
    timesPressed1++;
    if(timesPressed1 >= 2){
      showEditor = false;
      timesPressed1 = 0;
    }
    else{
      showEditor = true;
    }
  }
  else if(key == 'c'){
    timesPressed2++;
    if(timesPressed2 >= 2){
      showControls = false;
      timesPressed2 = 0;
    }
    else{
      showControls = true;
  }
 }
}

void keyReleased(){
  if(keyCode == RIGHT){
    player.changeX = 0;
  }
  else if(keyCode == LEFT){
    player.changeX = 0;
  }
}

void mousePressed(){
  if(showEditor && mouseX + viewX >= 0 && mouseX < (tiles.width / 2) 
     && mouseY + viewY >= 0 && mouseY < (tiles.height / 2)){
    imgNum = mouseY/(SPRITE_SIZE/2)*col + mouseX/(SPRITE_SIZE/2);
    imgHolder = imgArray[imgNum];
  }
  if(showEditor &&  (mouseX  + viewX > (tiles.width / 2) + viewX || mouseY + viewY > (tiles.height / 2) + viewY)){
  
    mouseX += viewX;
    mouseY += viewY;
    positionX = mouseX / SPRITE_SIZE;
    positionY = mouseY / SPRITE_SIZE;
    if(level == 1){
      mapLevel1[positionY * 100 + positionX] = imgNum;
      createPlatforms(mapLevel1);
    }
    if(level == 2){
      mapLevel2[positionY * 100 + positionX] = imgNum;
      createPlatforms(mapLevel2);
    }
    else if (level == 3){
      mapLevel3[positionY * 100 + positionX] = imgNum;
      createPlatforms(mapLevel3);
    }
    else{
      mapLevel1[positionY * 100 + positionX] = imgNum;
      createPlatforms(mapLevel1);
    }
  }
}

void createImgArray(){
   imgArray = new PImage[col*row];
   for(int i = 0; i < row; i++) {
      for(int j = 0; j < col; j++) {
        imgHolder = tiles.get(j*SPRITE_SIZE, i*SPRITE_SIZE, SPRITE_SIZE, SPRITE_SIZE);
        imgArray[i*col+j] = imgHolder;
      }
   }
}

void createPlatforms(int[] mapArray){
  for(int rows = 0; rows < 10; rows++){
    for(int columns = 0; columns < 100; columns++){
      int index = mapArray[rows * 100 + columns];
      Sprite s = new Sprite(imgArray[index], SPRITE_SCALE);
      s.centerX =  SPRITE_SIZE/2 + columns * SPRITE_SIZE;
      s.centerY =  SPRITE_SIZE/2 + rows * SPRITE_SIZE;
      platforms.add(s); 
    }
  }
}
