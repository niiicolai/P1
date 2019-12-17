// Defines an object that draws an image and follow the mouse position if it is pressed within its position and size 
public class DraggableImage {
  
  // The start position of the object
  private PVector startPosition;
  
  // The position of the object
  private PVector position;
  
  // The size of the object
  private PVector size;
  
  // A reference to a GIF object
  private Gif gifImage;
  
  // Used to check if the user is currently dragging the object
  private boolean isDragging;
  
  // The DraggableImage's constructor
  DraggableImage(PVector _position, PVector _size, Gif _gifImage) {
    
    // store the values passed to the constructor in a suitable variable
    startPosition = new PVector(_position.x, _position.y);
    position = _position;
    size = _size;
    gifImage = _gifImage;    
    
    // call the GIF object's play function 
    gifImage.play();
  }
  
  // Call to reset the position of the object to the start position
  // and ensure dragging is disabled
  public void reset() {
     position = new PVector(startPosition.x, startPosition.y);
     isDragging = false;
  }
  
  // Call to draw the object relative to the scene
  public void display(Scene scene) {
    
    // If the user is currently dragging the object
    if (isDragging) {
      
      // Follow the position of the mouse
      position = new PVector(mouseX-(size.x/2), mouseY-(size.y/2)); 
    }
    
    // Draw the gift relative to the scene with a size
    image(gifImage, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
  
  // returns true if the mouse is within the objects position and size
  public boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
  
  // Call to move the object inside the scene in cases where it is dragged outside proccesing display window
  public void boundariesCheck(Scene scene) {
    
    // if the object's x position is less than the scene's x position
    // move the object's x position to the scene's x position
    if (position.x < scene.position.x) position.x = scene.position.x;
    
    // else if the object's x position is greater than the scene's x position plus the display windows width
    // move the object's x position to the scene's x position plus the display windows width
    else if (position.x+size.x > scene.position.x+width) position.x = scene.position.x+width-size.x;
    
    // if the object's y position is less than the scene's y position
    // move the object's y position to the scene's y position
    if (position.y < scene.position.y) position.y = scene.position.y;
    
    // else if the object's y position is greater than the scene's y position plus the display windows height
    // move the object's y position to the scene's y position plus the display windows height
    else if (position.y+size.y > scene.position.y+height) position.y = scene.position.y+height-size.y;
  }
  
  // called when the user clicks the screen
  public void onMousePressed() {
    
    // if the user clicked within and the object isn't dragging already    
    if (mouseWithin() && !isDragging) {
      
      // activate the dragging functionality
      isDragging = true;
    }
  }
  
  // called when the user removes the finger from the screen
  public void onMouseReleased() {
    
    // if the object is dragging
    if (isDragging) {
      
      // disable the dragging functionality
      isDragging = false; 
    }
  }
  
  // Returns a PVector object with the center position of the draggable image
  public PVector center() {
    return new PVector(position.x+(size.x/2), position.y+(size.y/2)); 
  }
}
