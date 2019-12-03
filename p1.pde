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
  
  frameRate(60);
  
  font = createFont(fontName, 30);
  font2 = createFont(fontName2, 16);
  
  participantDatum = new ParticipantDatum();
  
  data = new Data();
  data.load();
  println(data.participantdata.size());
  
  String questionOne = "Would you replace your wallet with a microchip implant?";
  String[] noPage = new String[]{
    "A microchip implant is the property of its owner, and is only the size of a rice grain. It can only contain the data that is given by the owner, and can only be used at authorized terminals. The microchip implant can be used as an electronic handbag that can’t be lost. It can contain everyday things such as train tickets, fitness cards, credit cards, etc.",    
    "Just like a phone can, and often contains, credit card, tickets, and other everyday use items, the microchip implant can do the same. However, the microchip implant will not run out of battery, since it is powered by the signal sent by the designated terminal, and the microchip is not hooked up to the internet. This, in terms of use, is just another way to carry everyday use items, at all times, without having to think about remembering, wallet, bag, phone, and other things one may carry with them when going outside."
  };
  String[] yesPage = new String[]{
    "Microchip implants is sometimes seen as something futuristic, however, there are already as many as 5000+ people who already use microchip implants in their hands in everyday life. One of the more common uses for the microchip implants is to be used as fitness cards to their fitness center, and train tickets for those who often travels by train. The microchip implant is for this reason also referred to as “An electronic handbag”.",    
    "Microchip implants are only the size of a grain of rice, and leaves little, to no scar at all. The implant itself is very easy to get, and only takes 5 – 10 minutes to implant, and can be removed just as quickly."
  };
  String[] infoPage1 = new String[]{
    "The microchip implant itself doesn’t contain any data. It contains a code that can be scanned by specific scanners, just like a credit card can’t be scanned anywhere, but only at authorized terminals. ",
    "The microchip implant, in terms of how it works, uses radio identification frequency, which is a frequency that is right now used to identify products, animals, or access cards to limited areas. This technology only works together with its intended receiver, which means that the info from the microchip can’t be accessed by someone from the outside."
  };
  String[] infoPage2 = new String[]{
    "Microchip implants, as of now, are most often seen in medical patients, and are used by doctors and nurses to quickly check the patients medical history, so that action can be taken more swiftly. This is extremely useful in dire situations where a patient is either passed out, or in other conditions where time is of the essence. ",
    "This is not widely used around the world yet, which means that the hospitals don’t necessarily know what patients have a microchip, and who doesn’t. This makes it hard for hospitals to determine when to check the patients for microchip implants, however, if this was more common, it would become second nature for hospitals to check for a microchip implant."
  };
  String questionTwo = "Do you have a positive attitude towards human microchip implant?";  
  
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
      new Title(questionOne, new PVector (200, height/2), new PVector (width-400, 80), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), "NO", 2, true, RIGHT),
        new Button(new PVector (width-150, 0), new PVector (150, height), "YES", 3, true, LEFT)
      }, false
    ),
    new Scene(
      new Title("What could a microchip be used for?", new PVector (0, 50), new PVector (width-150, 50), CENTER, 22), color(255),
      new Button[]{
        //new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 0, false),
        new Button(new PVector (width-150, 0), new PVector (150, height), 3, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(noPage[0], new PVector (50, 100), new PVector (width-250, 150), LEFT),
        new TextBox(noPage[1], new PVector (50, 270), new PVector (width-250, 165), LEFT),
      }, false
    ),
    new Scene(
      new Title("Microchip implants as of now", new PVector (0, 50), new PVector (width-150, 50), CENTER, 22), color(255),
      new Button[]{
        //new Button(new PVector (0, 0), new PVector (200, height), "PREVIOUS", 0, false),
        new Button(new PVector (width-150, 0), new PVector (150, height), 4, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(yesPage[0], new PVector (50, 100), new PVector (width-250, 150), LEFT),
        new TextBox(yesPage[1], new PVector (50, 270), new PVector (width-250, 150), LEFT),
      }, false
    ),
    new Scene(
      new Title("The technology behind it", new PVector (200, 50), new PVector (width-400, 50), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), 3, false, RIGHT, LEFT),
        new Button(new PVector (width-150, 0), new PVector (150, height), 5, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(infoPage1[0], new PVector (200, 100), new PVector (width-400, 170), LEFT),
        new TextBox(infoPage1[1], new PVector (200, 290), new PVector (width-400, 170), LEFT),
      }, false
    ),
    new Scene(
      new Title("Medical patients", new PVector (200, 50), new PVector (width-400, 50), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), 4, false, RIGHT, LEFT),
        new Button(new PVector (width-150, 0), new PVector (150, height), 6, false, LEFT, RIGHT)
      },
      new TextBox[]{
        new TextBox(infoPage2[0], new PVector (200, 100), new PVector (width-400, 170), LEFT),
        new TextBox(infoPage2[1], new PVector (200, 290), new PVector (width-400, 170), LEFT),
      }, false
    ),
    new Scene(
      new Title(questionTwo, new PVector (200, height/2), new PVector (width-400, 80), CENTER, 22), color(255),
      new Button[]{
        new Button(new PVector (0, 0), new PVector (150, height), "NO", 7, true, RIGHT),
        new Button(new PVector (width-150, 0), new PVector (150, height), "YES", 7, true, LEFT)
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
