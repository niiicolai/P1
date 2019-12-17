// Defines a custom class called 'Scene'
// Used to define what information that should be display on each scene (also known as slides or pages)
public class Scene {
  
  // The scene's position
  PVector position = new PVector(0, 0);
  
  // The amount of velocity that should be applied to the scene on slide
  PVector slideVelocity = new PVector(60, 0);  
  
  // The amount of velocity that should be applied before reaching the 'slide to position'
  // in order to avoid wierd flickering when using slide with high speed
  PVector slideVelocityDamper = new PVector(2, 0); 
  
  // The point where the velocity damper should be applied
  float slideDamperPoint = 55;
  
  // The direction the scene should slide out
  int slideOutDirection = LEFT;
  
  // The direction the scene should slide in
  int slideInDirection = LEFT;
  
  // The background color of the scene
  color backgroundColor;
  
  // The scene that are previous from this
  int previousSceneIndex;
  
  // The scene that are next from this 
  int nextSceneIndex;
  
  // A reference to a title object
  // This object is only required on scenes
  // where a title is necessary
  Title title;

  // A reference to a draggableImage object
  DraggableImage draggableImage;
  
  // A reference to a draggableImageTrigger object
  DraggableImageTrigger draggableImageTrigger;
  
  // A reference to an image array
  Image[] images;
  
  // A reference to a button array
  Button[] buttons;
  
  // A reference to a textbox array
  TextBox[] textBoxes;
  
  // A reference to an arrow array
  Arrow[] arrows;
  
  // A reference to a scene loader object
  SceneLoader sceneLoader;
  
  // Determines wether or not the current participant should be saved when leaving the scene
  // and create a new participant
  boolean saveParticipantOnLeave;
  
  // The scene class' first constructor
  // Used in cases when a draggable image, trigger, arrows and images are neccesary
  Scene (Title _title, color _backgroundColor, DraggableImage image, DraggableImageTrigger trigger, Arrow[] _arrows, Image[] _images, int _nextSceneIndex) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    draggableImage = image;
    draggableImageTrigger = trigger;
    images = _images;
    arrows = _arrows;
    nextSceneIndex = _nextSceneIndex;
  }
  
  // The scene class' second constructor
  // Used in cases when a title, saving and buttons are neccesary
  Scene (Title _title, color _backgroundColor, Button[] _buttons, boolean _saveParticipantOnLeave) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    saveParticipantOnLeave = _saveParticipantOnLeave;
  }
  
  // The scene class' third constructor
  // Used in cases when a title and a scene loader are neccesary
  Scene (Title _title, color _backgroundColor, SceneLoader _sceneLoader, int _nextSceneIndex) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    sceneLoader = _sceneLoader;
    nextSceneIndex = _nextSceneIndex;
  }
  
  // The scene class' fourth constructor
  // Used in cases when buttons, textboxes, images and saving are neccesary
  Scene (Title _title, color _backgroundColor, Button[] _buttons, TextBox[] _textBoxes, Image[] tempImages, boolean _saveParticipantOnLeave) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    textBoxes = _textBoxes;
    saveParticipantOnLeave = _saveParticipantOnLeave;
    images = tempImages;
  }
  
  // Call to slide the scene out of the display in the given direction from its current position
  // returns false as long it is sliding
  public boolean slideOut() {    
    
    // check if the scene is visible inside the processing display window
    boolean insideTheScreen = (slideOutDirection == LEFT ? position.x+width > 0 : position.x < width);
    
    // if it is inside the display window
    if (insideTheScreen) {
      // move the scene in a given direction using a velocity
      position.add(slideOutDirection == LEFT ? new PVector(-slideVelocity.x, -slideVelocity.y) : slideVelocity);
      // return false
      return false;
    } else {      
      // return true
      return true; 
    }      
  }
  
  // Call to slide the scene in to the display in a given direction from its current position
  // returns false as long it is sliding
  public boolean slideIn() {
    
    // check if the scene is still outside the screen
    boolean outsideTheScreen = (slideInDirection == LEFT ? position.x > 0 : position.x < 0);
    
    // if it is
    if (outsideTheScreen) {
      
      // set the default velocity to the value of 'slideVelocity'
      PVector velocity = slideVelocity;
      
      // if the scene's position reached the damping point, reduce the slide speed
      if (slideInDirection == LEFT && position.x < slideDamperPoint ||
          slideInDirection == RIGHT && position.x > slideDamperPoint) velocity = slideVelocityDamper;

      // apply the velocity in the wanted direction
      position.add(slideInDirection == LEFT ? new PVector(-velocity.x, -velocity.y) : velocity);
      // return false
      return false;
    } else {      
      // return true
      return true; 
    }      
  }
  
  // The scene's before display function
  // will handle all resets needed before 'redisplaying' a scene
  public void beforeDisplay() {
    
    // reset the draggable image object if any
    if (draggableImage != null) draggableImage.reset();
    
    // reset the draggable image trigger object if any
    if (draggableImageTrigger != null) draggableImageTrigger.reset();
    
    // reset the scene loader object if any
    if (sceneLoader != null) sceneLoader.reset();
    
    // reset all butttons if any
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        buttons[i].reset(); 
      }
    }
  }
  
  // The scene's display function
  // This will be called from draw
  public void display() {
    
    // remove the stroke on the next processing shape
    noStroke();
    
    // set the background color
    fill(backgroundColor);    
    
    // draw a rect which represent a scene
    rect(position.x, position.y, width, height);

    // if the scene have any textboxes
    if (textBoxes != null) {
      
      // loop through all textboxes
      for (int i = 0; i < textBoxes.length; i++) {
        
        // call the textboxes display function
        textBoxes[i].display(this); 
      }
    }

    // if the scene have any images
    if (images != null) {
      
      // loop through all images
      for (int i = 0; i < images.length; i++) {
        
        // call the images display function
        images[i].display(this); 
      }
    }
    
    // if the scene have any arrows
    if (arrows != null) {
      
      // loop through all arrows
      for (int i = 0; i < arrows.length; i++) {
        
        // call the arrows display function
        arrows[i].display(this); 
      }
    }
    
    // if the scene have a scene loader
    // call the scene loader's display function
    if (sceneLoader != null) sceneLoader.display(this);
    
    // if this scene have a title
    // call the title object's display function
    if (title != null) title.display(this);          
    
    
    // if the scene have any buttons
    if (buttons != null) {
      
      // loop through all buttons
      for (int i = 0; i < buttons.length; i++) {
        
        // call the buttons display function
        buttons[i].display(this); 
      }
    }
    
    // if the scene have a draggable image
    if (draggableImage != null) {
      
      // if the scene have a draggable image trigger
      if (draggableImageTrigger != null) {
        
        // call the draggable image trigger's display function
        draggableImageTrigger.display(this);
        
        // if the draggable image trigger object collide with the draggable image and it hasn't triggered yet
        if (draggableImageTrigger.collidesWith(draggableImage) && !draggableImageTrigger.didTrigger) {
          // cache that the draggable image trigger has been triggered once to avoid this function being runned multiple times
          draggableImageTrigger.didTrigger = true;
          
          // navigate to the next scene and reset the positions of this and the next before showing the transition
          navigate(scenes[nextSceneIndex], true);
        }
      }
      
      // call the draggable images display function
      draggableImage.display(this);
      
      // call the draggable images boundaries check function
      draggableImage.boundariesCheck(this);
    }
  }
  
  // Call to trigger all mouse pressed events
  public void onMousePressed() {
    
    // if the scene have a draggable image trigger
    // call its on mouse pressed function
    if (draggableImage != null) draggableImage.onMousePressed();
    
    // if the scene have any buttons
    if (buttons != null) {
      
      // loop through all the buttons
      for (int i = 0; i < buttons.length; i++) {
        
        // call 'onMousePressed' on the current iteration of the array
        buttons[i].onMousePressed(); 
      }
    }
  }
  
  // Call to trigger all mouse released events
  public void onMouseReleased() {
    
    // if the scene have a draggable image
    // call its 'onMouseReleased' function
    if (draggableImage != null) draggableImage.onMouseReleased();
    
    // if the scene have any buttons
    if (buttons != null) {
      
      // loop through all the buttons
      for (int i = 0; i < buttons.length; i++) {
        
        // call 'onMouseReleased' on the current iteration of the array
        buttons[i].onMouseReleased(); 
      }
    }
  }
}
