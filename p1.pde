// An array with a reference to all scene objects
Scene[] scenes;

// A reference to the current scene
Scene currentScene;

void setup () {
  // Set Processing display size
  size (500, 500);
  
  // Create an instance of an array
  scenes = new Scene[] {
    
    // create a new instance of the frontpage object 
    // and add to the scene array
    new Scene(
      new Title("Some random text", #0099cc, new PVector (width/2, height/2))
    )    
  };
  
  // set the default scene to the first scene object of the scene array
  currentScene = scenes[0];
}

void draw() {
  // if we the value of currentScene is NOT equal to 'null'
  // call the display function on the current scene object
  if (currentScene != null) currentScene.display();
}

// Defines a custom class we call 'Scene'
// This will describe what a scene can 
// and handle the general display
public class Scene {
  
  // A reference to a title object
  // This object is only required on scenes
  // where a title is necessary
  Title title;
  
  // The scene class' constructor
  // Defines the needed parameters a scene object
  // when creating an instance
  Scene (Title _title) {
    title = _title;
  }
  
  // The scene's display function
  // This will be called from draw
  public void display() {
    
    // if this scene has a title
    // call the title object's display function
    if (title != null) title.display();
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
  private color textColor;  
  
  
  // The title's constructor
  Title(String _text, color _color, PVector _position) {
    text = _text;
    textColor = _color;
    position = new PVector(_position.x, _position.y);
  }
  
  public void display() {
    fill(textColor);
    text(text, position.x, position.y);
  }
}
