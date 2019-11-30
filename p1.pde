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
      new Title("HUMAN IMPLANT CHIPS", new PVector (50, 50)), color(255),
      new DragableImage(new PVector(200, 200), new PVector(50, 50), loadImage("chip.jpg"))
    )
  };
  
  // set the default scene to the first scene object of the scene array
  currentScene = scenes[0];
}

void navigate(Scene scene) {
  
  currentScene = scene;
}

void draw() {
  // if we the value of currentScene is NOT equal to 'null'
  // call the display function on the current scene object
  if (currentScene != null) currentScene.display();
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
  
  color backgroundColor;
  
  // A reference to a title object
  // This object is only required on scenes
  // where a title is necessary
  Title title;
  
  DragableImage dragableImage;
  
  // The scene class' constructor
  // Defines the needed parameters a scene object
  // when creating an instance
  Scene (Title _title, color _backgroundColor, DragableImage image) {
    title = _title;
    backgroundColor = _backgroundColor;
    dragableImage = image;
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
      dragableImage.display();
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
  
  // The color of the title's text
  private color textColor = color(0);  
  
  // The title's constructor
  Title(String _text, PVector _position) {
    text = _text;
    position = new PVector(_position.x, _position.y);
  }
  
  public void display(Scene scene) {
    fill(textColor);
    textFont(font);
    text(text, scene.position.x+position.x, scene.position.y+position.y);
  }
}

public class DragableImage {
 
  PVector position;
  PVector size;
  PImage _image;
  boolean isDragging;
  
  DragableImage(PVector _position, PVector _size, PImage __image) {
    position = _position;
    size = _size;
    _image = __image;
  }
  
  void display() {
    if (isDragging) {
      position = new PVector(mouseX, mouseY); 
    }
    
    image(_image, position.x, position.y, size.x, size.y);
  }
  
  boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
  
  public void boundariesCheck(Scene scene) {
    if (position.x < scene.position.x) position.x = scene.position.x;
    else if (position.x+size.x > scene.position.x+width) position.x = scene.position.x+width-size.x;
    
    if (position.y < scene.position.y) position.y = scene.position.y;
    else if (position.y+size.y > scene.position.y+height) position.y = scene.position.y+height-size.y;
  }
  
  public void onMousePressed() {
    if (mouseWithin()) {
      isDragging = true;
    }
  }
  
  public void onMouseReleased() {
    if (isDragging) {
      isDragging = false; 
    }
  }
}
