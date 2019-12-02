import gifAnimation.*;

Data data;

ParticipantDatum participantDatum;

// An array with a reference to all scene objects
Scene[] scenes;

// A reference to the current scene
Scene currentScene;

// A reference to the next scene
Scene nextScene;

String fontName = "Arial Black";
String fontName2 = "Arial";
PFont font;
PFont font2;

void setup () {
  // Set Processing display size
  size (1000, 700);
  
  frameRate(30);
  
  font = createFont(fontName, 32);
  font2 = createFont(fontName2, 16);
  
  participantDatum = new ParticipantDatum();
  
  data = new Data();
  data.load();
  println(data.participantdata.size());
  String dummyText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius.";
  
  // Create an instance of an array
  scenes = new Scene[] {
    
    // create a new instance of the frontpage object 
    // and add to the scene array
    new Scene(
      new Title("INSERT THE HUMAN IMPLANT CHIP", new PVector (0, 50), new PVector (width-230, 50), CENTER, 30), color(255),
      new DragableImage(new PVector(100, (height/2)-70), new PVector(150, 190), new Gif(this, "chip.gif")),
      new DragableImageTrigger(new PVector(width-280, (height/2)), new PVector(50, 50)),
      new Arrow[]{
        new Arrow(new PVector(300, (height/2)), 50, 200, RIGHT),
        new Arrow(new PVector(325, (height/2)), 50, 175, RIGHT),
        new Arrow(new PVector(350, (height/2)), 50, 150, RIGHT),
        new Arrow(new PVector(375, (height/2)), 50, 125, RIGHT),
        new Arrow(new PVector(400, (height/2)), 50, 100, RIGHT),
        new Arrow(new PVector(425, (height/2)), 50, 75, RIGHT),
        new Arrow(new PVector(450, (height/2)), 50, 50, RIGHT),
      },
      new Image[]{
        new Image(new PVector (width-550, -120), new PVector (780, 880), loadImage("hand.png")),
      },
      1
    ),
    new Scene(
      new Title("Lorem ipsum dolor sit amet?", new PVector (200, height/2), new PVector (width-400, 50), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), "NO", 2, true, RIGHT),
        new Button(new PVector (width-150, 0), new PVector (150, height), "YES", 3, true, LEFT)
      }, false
    ),
    new Scene(
      new Title("LAST ANSWER WAS NO", new PVector (0, 50), new PVector (width-150, 50), CENTER, 22), color(255),
      new Button[]{
        //new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 0, false),
        new Button(new PVector (width-150, 0), new PVector (150, height), 3, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(dummyText, new PVector (50, 100), new PVector (width-250, 150), LEFT),
        new TextBox(dummyText, new PVector (50, 270), new PVector (width-250, 150), LEFT),
        new TextBox(dummyText, new PVector (50, 440), new PVector (width-250, 150), LEFT),
      }, false
    ),
    new Scene(
      new Title("LAST ANSWER WAS YES", new PVector (0, 50), new PVector (width-150, 50), CENTER, 22), color(255),
      new Button[]{
        //new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 0, false),
        new Button(new PVector (width-150, 0), new PVector (150, height), 4, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(dummyText, new PVector (50, 100), new PVector (width-250, 150), LEFT),
        new TextBox(dummyText, new PVector (50, 270), new PVector (width-250, 150), LEFT),
        new TextBox(dummyText, new PVector (50, 440), new PVector (width-250, 150), LEFT),
      }, false
    ),
    new Scene(
      new Title("Euismod tincidunt ut laoreet dolore", new PVector (200, 50), new PVector (width-400, 50), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), 3, false, RIGHT, LEFT),
        new Button(new PVector (width-150, 0), new PVector (150, height), 5, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(dummyText, new PVector (200, 100), new PVector (width-400, 170), LEFT),
        new TextBox(dummyText, new PVector (200, 290), new PVector (width-400, 170), LEFT),
        new TextBox(dummyText, new PVector (200, 480), new PVector (width-400, 170), LEFT),
      }, false
    ),
    new Scene(
      new Title("Ut wisi enim ad minim veniamr sit amet", new PVector (200, 50), new PVector (width-400, 50), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), 4, false, RIGHT, LEFT),
        new Button(new PVector (width-150, 0), new PVector (150, height), 6, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(dummyText, new PVector (200, 100), new PVector (width-400, 170), LEFT),
        new TextBox(dummyText, new PVector (200, 290), new PVector (width-400, 170), LEFT),
        new TextBox(dummyText, new PVector (200, 480), new PVector (width-400, 170), LEFT),
      }, false
    ),
    new Scene(
      new Title("Non habent claritatem insitam", new PVector (200, 50), new PVector (width-400, 50), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), 5, false, RIGHT, LEFT),
        new Button(new PVector (width-150, 0), new PVector (150, height), 7, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(dummyText, new PVector (200, 100), new PVector (width-400, 170), LEFT),
        new TextBox(dummyText, new PVector (200, 290), new PVector (width-400, 170), LEFT),
        new TextBox(dummyText, new PVector (200, 480), new PVector (width-400, 170), LEFT),
      }, false
    ),
    new Scene(
      new Title("Sed do eiusmod tempor incididunt?", new PVector (200, height/2), new PVector (width-400, 50), CENTER, 30), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), "NO", 8, true, RIGHT),
        new Button(new PVector (width-150, 0), new PVector (150, height), "YES", 8, true, LEFT)
      }, true
    ),
    new Scene(
      new Title("Thank you for your participation", new PVector (200, height/2), new PVector (width-400, 50), CENTER, 30), color(255),
      new SceneLoader(new PVector (200, height/2), new PVector (width-400, 50)), 0
    )
  };
  
  // set the default scene to the first scene object of the scene array
  currentScene = scenes[0];
}

void draw() {
  background(#33daf8);
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
      currentScene.position.x = 0;
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

void navigate(Scene scene, boolean resetPosition) {
  scene.beforeDisplay();   
  if (resetPosition) {
    if (scene.slideInDirection == LEFT) {
      scene.position = new PVector(width, 0);
    } else {
      scene.position = new PVector(-width, 0);
    }
  }
  nextScene = scene;
}

public void addParticipantDatum() {
  data.participantdata.add(participantDatum);
  data.save();
  participantDatum = new ParticipantDatum();
}
