Data data;

ParticipantDatum participantDatum;

// An array with a reference to all scene objects
Scene[] scenes;

// A reference to the current scene
Scene currentScene;

// A reference to the next scene
Scene nextScene;

String fontName = "Arial";
PFont font;

void setup () {
  // Set Processing display size
  size (1000, 700);
  
  participantDatum = new ParticipantDatum();
  
  data = new Data();
  data.load();
  println(data.participantdata.size());
  
  font = createFont(fontName, 15);
  
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
      new Button[]{
        new Button(new PVector (0, 0), new PVector (200, height), "NO", 2, true),
        new Button(new PVector (width-200, 0), new PVector (200, height), "YES", 3, true)
      }, false
    ),
    new Scene(
      new Title("Lorem ipsum dolor sit amet? LAST ANSWER WAS NO", new PVector (0, 50), new PVector (width, 50), CENTER), color(255),
      new Button[]{
        //new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 0, false),
        new Button(new PVector (width-200, 0), new PVector (200, height), "NEXT", 3, false)
      }, false
    ),
    new Scene(
      new Title("Lorem ipsum dolor sit amet? LAST ANSWER WAS YES 1", new PVector (0, 50), new PVector (width, 50), CENTER), color(255),
      new Button[]{
        //new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 0, false),
        new Button(new PVector (width-200, 0), new PVector (200, height), "NEXT", 4, false)
      }, false
    ),
    new Scene(
      new Title("Lorem ipsum dolor sit amet? LAST ANSWER WAS YES 2", new PVector (0, 50), new PVector (width, 50), CENTER), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 3, false),
        new Button(new PVector (width-200, 0), new PVector (200, height), "NEXT", 5, false)
      }, false
    ),
    new Scene(
      new Title("Lorem ipsum dolor sit amet? LAST ANSWER WAS YES 3", new PVector (0, 50), new PVector (width, 50), CENTER), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (200, height), "NO", 0, true),
        new Button(new PVector (width-200, 0), new PVector (200, height), "YES", 0, true)
      }, true
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
      if (currentScene.saveParticipantOnLeave) addParticipantDatum();
      currentScene = nextScene;   
      currentScene.beforeDisplay();
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

void navigate(Scene scene) {
  scene.beforeDisplay(); 
  scene.position = new PVector(width, 0);
  nextScene = scene;
}

public void addParticipantDatum() {
  data.participantdata.add(participantDatum);
  data.save();
  participantDatum = new ParticipantDatum();
}
