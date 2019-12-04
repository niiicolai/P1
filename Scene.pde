// Defines a custom class we call 'Scene'
// This will describe what a scene can 
// and handle the general display
public class Scene {
  
  PVector position = new PVector(0, 0);
  
  PVector slideVelocity = new PVector(60, 0);  
  PVector slideVelocityDamper = new PVector(2, 0); 
  int slideOutDirection = LEFT;
  int slideInDirection = LEFT;
  
  color backgroundColor;
  
  int previousSceneIndex;
  int nextSceneIndex;
  
  // A reference to a title object
  // This object is only required on scenes
  // where a title is necessary
  Title title;
  
  DragableImage dragableImage;
  
  DragableImageTrigger dragableImageTrigger;
  
  Image[] images;
  
  Button[] buttons;
  
  TextBox[] textBoxes;
  
  Arrow[] arrows;
  
  SceneLoader sceneLoader;
  
  boolean saveParticipantOnLeave;
  
  // The scene class' constructor
  // Defines the needed parameters a scene object
  // when creating an instance
  Scene (Title _title, color _backgroundColor, DragableImage image, DragableImageTrigger trigger, Arrow[] _arrows, Image[] _images, int _nextSceneIndex) {
    title = _title;
    backgroundColor = _backgroundColor;
    dragableImage = image;
    dragableImageTrigger = trigger;
    images = _images;
    arrows = _arrows;
    nextSceneIndex = _nextSceneIndex;
  }
  
  Scene (Title _title, color _backgroundColor, Button[] _buttons, boolean _saveParticipantOnLeave) {
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    saveParticipantOnLeave = _saveParticipantOnLeave;
  }
  
  Scene (Title _title, color _backgroundColor, SceneLoader _sceneLoader, int _nextSceneIndex) {
    title = _title;
    backgroundColor = _backgroundColor;
    sceneLoader = _sceneLoader;
    nextSceneIndex = _nextSceneIndex;
  }
  
  Scene (Title _title, color _backgroundColor, Button[] _buttons, TextBox[] _textBoxes, boolean _saveParticipantOnLeave) {
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    textBoxes = _textBoxes;
    saveParticipantOnLeave = _saveParticipantOnLeave;
  }
  
  public boolean slideOut() {    
    boolean insideTheScreen = (slideOutDirection == LEFT ? position.x+width > 0 : position.x < width);
    if (insideTheScreen) {
      position.add(slideOutDirection == LEFT ? new PVector(-slideVelocity.x, -slideVelocity.y) : slideVelocity);
      return false;
    } else {      
      return true; 
    }      
  }
  
  public boolean slideIn() {
    boolean outsideTheScreen = (slideInDirection == LEFT ? position.x > 0 : position.x < 0);
    if (outsideTheScreen) {
      PVector velocity = slideVelocity;
      if (slideInDirection == LEFT && position.x < slideVelocity.x-5 ||
          slideInDirection == RIGHT && position.x > slideVelocity.x-5) velocity = slideVelocityDamper;
      position.add(slideInDirection == LEFT ? new PVector(-velocity.x, -velocity.y) : velocity);
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
    if (sceneLoader != null) sceneLoader.reset();
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        buttons[i].reset(); 
      }
    }
  }
  
  // The scene's display function
  // This will be called from draw
  public void display() {
    noStroke();
    fill(backgroundColor);    
    rect(position.x, position.y, width, height);

    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        images[i].display(this); 
      }
    }
    
    if (arrows != null) {
      for (int i = 0; i < arrows.length; i++) {
        arrows[i].display(this); 
      }
    }
    
    if (sceneLoader != null) sceneLoader.display(this);
    
    // if this scene has a title
    // call the title object's display function
    if (title != null) title.display(this);          
    
    if (textBoxes != null) {
      for (int i = 0; i < textBoxes.length; i++) {
        textBoxes[i].display(this); 
      }
    }
    
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        buttons[i].display(this); 
      }
    }
    
    if (dragableImage != null) {
      if (dragableImageTrigger != null) {
        dragableImageTrigger.display(this);
        if (dragableImageTrigger.collidesWith(dragableImage) && !dragableImageTrigger.didTrigger) {
           dragableImageTrigger.didTrigger = true;
           navigate(scenes[nextSceneIndex], true);
        }
      }
      
      dragableImage.display(this);
      dragableImage.boundariesCheck(this);
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
    
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        buttons[i].onMouseReleased(); 
      }
    }
  }
}
