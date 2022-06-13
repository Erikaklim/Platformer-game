public class SpriteAnimation extends Sprite{
  PImage[] currentImages;
  PImage[] stand;
  PImage[] moveLeft;
  PImage[] moveRight;
  int direction, index, frame;
  
  public SpriteAnimation(PImage image, float scale){
    super(image, scale);
    direction = NEUTRAL_FACING;
    index = 0;
    frame = 0;
  }
  
  public void updateAnimation(){
    frame++;
    if(frame % 5 == 0){
      setDirection();
      setCurrentImages();
      advanceToNextImage();
    }
  }
  
  public void setDirection(){
    if(changeX > 0){
      direction = RIGHT_FACING;
    }
    else if(changeX < 0){
      direction = LEFT_FACING;
    }
    else{
      direction = NEUTRAL_FACING;
    }
  }
  
  public void setCurrentImages(){
    if(direction == RIGHT_FACING){
      currentImages = moveRight;
    }
    else if(direction == LEFT_FACING){
      currentImages = moveLeft;
    }
    else{
      currentImages = stand;
    }
  }
  
  public void advanceToNextImage(){
    index++;
    if(index >= currentImages.length){
      index = 0; 
    }
    image = currentImages[index];
  }
  
}
