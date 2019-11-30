// An array with a reference to all scene objects
Scene[] scenes;

// A reference to the current scene
Scene currentScene;

Scene nextScene;

String fontName = "Arial";
PFont font;

void setup () {
  // Set Processing display size
  size (1000, 700);
  
  font = createFont(fontName, 25);
  
  // Create an instance of an array
  scenes = new Scene[] {
    
    // create a new instance of the frontpage object 
    // and add to the scene array
    new Scene(
      new Title("HUMAN IMPLANT CHIPS", new PVector (0, 50), new PVector (width, 50), CENTER), color(255),
      new DragableImage(new PVector(200, 200), new PVector(50, 50), loadImage("chip.jpg")),
      new DragableImageTrigger(new PVector(width/2, height/2), new PVector(50, 50)),
      1
    ),
    new Scene(
      new Title("Lorem ipsum dolor sit amet?", new PVector (0, 50), new PVector (width, 50), CENTER), color(255),
      2,2
    )
  };
  
  // set the default scene to the first scene object of the scene array
  currentScene = scenes[0];
}

void draw() {
  // if we the value of currentScene is NOT equal to 'null'
  // call the display function on the current scene object
  if (currentScene != null) currentScene.display();
  
  if (currentScene != null && nextScene != null) {
    nextScene.display();
    boolean currentIsOut = currentScene.slideOut();
    boolean newIsIn = nextScene.slideIn();
    if (currentIsOut && newIsIn) {
      currentScene = nextScene;
      nextScene = null;
    }
  }
}

void mousePressed() {
  if (currentScene != null) currentScene.onMousePressed();
}

void mouseReleased() {
  if (currentScene != null) currentScene.onMouseReleased();
}

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
  
  Scene (Title _title, color _backgroundColor, int _previousSceneIndex, int _nextSceneIndex) {
    title = _title;
    backgroundColor = _backgroundColor;
    previousSceneIndex = _previousSceneIndex;
    nextSceneIndex = _nextSceneIndex;
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
           scenes[nextSceneIndex].position = new PVector(width, 0);
           nextScene = scenes[nextSceneIndex];
        }
      }
      
      dragableImage.display(this);
      dragableImage.boundariesCheck(this);
    }
  }
  
  public void onMousePressed() {
    if (dragableImage != null) dragableImage.onMousePressed();
  }
  
  public void onMouseReleased() {
    if (dragableImage != null) dragableImage.onMouseReleased();
  }
}

// Defines a custom class called 'Title'
// In cases where a scene needs a title should an instance of this object
// be passed to the scene constructor and a similar title will be drawed
// on each page
public class Title {
  
  // A refernce to a string object hold the title's text
  private String text;
  
  // The position of the title
  private PVector position;
  
  // The position of the title
  private PVector size;
  
  // The color of the title's text
  private color textColor = color(0);  
  
  private int align;
  
  // The title's constructor
  Title(String _text, PVector _position, PVector _size, int _align) {
    text = _text;
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
  }
  
  public void display(Scene scene) {
    fill(textColor);
    textFont(font);
    textAlign(align);
    text(text, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}
