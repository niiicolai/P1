// Defines a custom class we call 'Scene'
// This will describe what a scene can 
// and handle the general display
public class Scene {
  
  PVector position = new PVector(0, 0);
  PVector slideVelocity = new PVector(-25, 0);
  color backgroundColor;
  
  int previousSceneIndex;
  int nextSceneIndex;
  
  // A reference to a title object
  // This object is only required on scenes
  // where a title is necessary
  Title title;
  
  DragableImage dragableImage;
  
  DragableImageTrigger dragableImageTrigger;
  
  Button[] buttons;
  
  // The scene class' constructor
  // Defines the needed parameters a scene object
  // when creating an instance
  Scene (Title _title, color _backgroundColor, DragableImage image, DragableImageTrigger trigger, int _nextSceneIndex) {
    title = _title;
    backgroundColor = _backgroundColor;
    dragableImage = image;
    dragableImageTrigger = trigger;
    nextSceneIndex = _nextSceneIndex;
  }
  
  Scene (Title _title, color _backgroundColor, Button[] _buttons) {
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
  }
  
  public boolean slideOut() {
    if (position.x+width > 0) {
      position.add(slideVelocity);
      return false;
    } else {      
      return true; 
    }      
  }
  
  public boolean slideIn() {
    if (position.x > 0) {
      position.add(slideVelocity);
      return false;
    } else {      
      return true; 
    }      
  }
  
  // The scene's before display function
  // will handle all resets needed before 'redisplaying' a scene
  public void beforeDisplay() {
    if (dragableImage != null) dragableImage.reset();
    if (dragableImageTrigger != null) dragableImageTrigger.reset();
  }
  
  // The scene's display function
  // This will be called from draw
  public void display() {
    noStroke();
    fill(backgroundColor);    
    rect(position.x, position.y, width, height);
    
    // if this scene has a title
    // call the title object's display function
    if (title != null) title.display(this);   
    
    if (dragableImage != null) {
      if (dragableImageTrigger != null) {
        dragableImageTrigger.display(this);
        if (dragableImageTrigger.collidesWith(dragableImage) && !dragableImageTrigger.didTrigger) {
           dragableImageTrigger.didTrigger = true;
           navigate(scenes[nextSceneIndex]);
        }
      }
      
      dragableImage.display(this);
      dragableImage.boundariesCheck(this);
    }
    
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        buttons[i].display(this); 
      }
    }
  }
  
  public void onMousePressed() {
    if (dragableImage != null) dragableImage.onMousePressed();
    
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        buttons[i].onMousePressed(); 
      }
    }
  }
  
  public void onMouseReleased() {
    if (dragableImage != null) dragableImage.onMouseReleased();
  }
}
