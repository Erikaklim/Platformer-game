public class Player extends SpriteAnimation{
  boolean onPlatform, inPlace;
  PImage[] standLeft;
  PImage[] standRight;
  PImage[] jumpLeft;
  PImage[] jumpRight;
 
  public Player(PImage image, float scale){
    super(image, scale);  
    direction = RIGHT_FACING;
    onPlatform = true;
    inPlace = true;
    
    standLeft = new PImage[1];
    standLeft[0] = loadImage("004L.png");
    
    standRight = new PImage[1];
    standRight[0] = loadImage("004.png");
    
    jumpLeft = new PImage[1];
    jumpLeft[0] = loadImage("jump/000L.png");
    
    jumpRight = new PImage[1];
    jumpRight[0] = loadImage("jump/000.png");
    
    moveLeft = new PImage[5];
    moveLeft[0] = loadImage("walk/008L.png");
    moveLeft[1] = loadImage("walk/012L.png");
    moveLeft[2] = loadImage("walk/017L.png");
    moveLeft[3] = loadImage("walk/018L.png");
    moveLeft[4] = loadImage("walk/020L.png");
    
    moveRight = new PImage[5];
    moveRight[0] = loadImage("walk/008.png");
    moveRight[1] = loadImage("walk/012.png");
    moveRight[2] = loadImage("walk/017.png");
    moveRight[3] = loadImage("walk/018.png");
    moveRight[4] = loadImage("walk/020.png");
    
    currentImages = standRight;
  }
  
  @Override
  public void updateAnimation(){
    onPlatform = isOnPlatform(this, platforms);
    inPlace = changeX == 0 && changeY == 0;
    super.updateAnimation();
  }
  
  @Override
  public void setDirection(){
    if(changeX > 0){
      direction = RIGHT_FACING;
    }
    else if(changeX < 0){
      direction = LEFT_FACING;
    }
  }
  
  @Override
  public void setCurrentImages(){
    if(direction == RIGHT_FACING){
      if(inPlace){
        currentImages = standRight;
      }
      else if(!onPlatform){
        currentImages = jumpRight;
      }
      else{
        currentImages = moveRight;
      }
    }
    
    else if(direction == LEFT_FACING){
      if(inPlace){
        currentImages = standLeft;
      }
      else if(!onPlatform){
        currentImages = jumpLeft;
      }
      else{
        currentImages = moveLeft;
      }
    }
  }
  
}
