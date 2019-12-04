import gifAnimation.*;

Data data;

ParticipantDatum participantDatum;

// An array with a reference to all scene objects
Scene[] scenes;

// A reference to the current scene
Scene currentScene;

// A reference to the next scene
Scene nextScene;

String fontName = "Roboto-Bold.ttf";
String fontName2 = "Roboto-Regular.ttf";
PFont font;
PFont font2;

void setup () {
  // Set Processing display size
  fullScreen();

  frameRate(30);

  font = createFont(fontName, 40);
  font2 = createFont(fontName2, 24);

  participantDatum = new ParticipantDatum();

  data = new Data();
  data.load();

  String frontPageTitle = "DRAG AND INSERT THE HUMAN IMPLANT CHIP";

  String questionOne = "Would you replace your wallet with a microchip implant?";
  
  String noPageTitle = "A microchip compared to your phone";
  String[] noPage = new String[]{
    "A microchip implant stores the same amount of personal information as a phone",
    "Phones are more exposed to the threat of security breach since it’s connected to a network and the \ninternet and can be accessed from a distance. ",
    "A microchip doesn’t contain a power source and can only be accessed when in proximity of a chip reader. ",
      "Since the implementation of voice activation programs such as Siri, your phone needs to be listening\n all the time for the activation phrase. Therefore, you sometimes experience targeted ads about things you have only talked about. ",
    "If you are afraid of being tracked, then your mobile phone and internet history is a much bigger threat\n than any microchip can ever be. ",
  };
  
  String yesPageTitle = "What is a microchip";
  String[] yesPage = new String[]{
    "A microchip is only the size of a grain of rice", 
    "It leaves no scar or mark when implanted",
    "It only takes 5 – 10 minutes to implant, and can be removed just as quickly ",
    "One of the more common uses for the microchip implants is to be used as fitness cards to their fitness center\n, and train tickets for those who often travel by train. The microchip implant is for this reason also referred to as “An electronic handbag”. ",
    "Microchip implants is sometimes seen as something futuristic, however, there are already as many as 5000+ people\n who already use microchip implants in their hands in everyday life. ",
  };
  
  String infoPage1Title = "The technology behind it";
  String[] infoPage1 = new String[]{
    "The microchip implant itself doesn’t contain any data. It contains a code that can be scanned by specific\n scanners, just like a credit card can’t be scanned anywhere, but only at authorized terminals. ", 
    "The microchip implant, in terms of how it works, uses radio identification frequency, which is a frequency\n that is right now used to identify products, animals, or access cards to limited areas. This technology only works together with its intended receiver, which means that the info from the microchip can’t be accessed by someone from the outside."
  };
  
  String infoPage2Title = "Medical patients";
  String[] infoPage2 = new String[]{
    "Microchip implants, as of now, are most often seen in medical patients, and are used by doctors and\n nurses to quickly check the patients' medical history, so that action can be taken more swiftly. ", 
    "This is extremely useful in dire situations where a patient has either passed out, or in other conditions\n where time is of the essence. This is not widely used around the world yet, which means that the hospitals don’t necessarily know what patients have a microchip, and who doesn’t.",
    "If everyone had a microchip implant, hospitals could check and take action much faster than today",
    "It would become second nature for doctors to check for implants as soon as they get a new patient "
  };
  
  String questionTwo = "Did the information have a positive influence on your attitude about human implant chips?";
  
  String thankYouPageTxt = "Thank you for your participation";

  int titleFontSize = 30;
  int frontPageFontSize = 40;
  PVector bigTitlePosition = new PVector(0, 30);
  PVector bigTitleSize = new PVector(width-150, 50);
  
  PVector smallTitlePosition = new PVector(200, 30);
  PVector smallTitleSize = new PVector(width-400, 50);
  
  PVector bigTextBoxPosition = new PVector(50, 100);
  PVector bigTextBoxSize = new PVector(width-250, height-200);
  
  PVector smallTextBoxPosition = new PVector(200, 100);
  PVector smallTextBoxSize = new PVector(width-400, height-200);
  
  PVector buttonLeftPos = new PVector (0, 0);
  PVector buttonRightPos = new PVector (width-150, 0);
  
  PVector buttonSize = new PVector (150, height);
  
  PVector questionPosition = new PVector (200, height/2);
  PVector questionSize = new PVector (width-400, 100);

  // Create an instance of an array
  scenes = new Scene[] {

    // create a new instance of the frontpage object 
    // and add to the scene array
    new Scene(
    new Title(frontPageTitle, new PVector (0, 50), new PVector (width, 50), CENTER, frontPageFontSize), color(255), 
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
      new Image[] { new Image(new PVector (width-550, -120), new PVector (780, height), loadImage("hand.png")),
    }, 
    1
    ), 
    new Scene(
    new Title(questionOne, questionPosition, questionSize, CENTER, titleFontSize), color(255), 
    new Button[]{
      new Button(buttonLeftPos, buttonSize, "NO", 2, true, RIGHT), 
      new Button(buttonRightPos, buttonSize, "YES", 3, true, LEFT)
    }, false
    ), 
    new Scene(
    new Title(noPageTitle, bigTitlePosition, bigTitleSize, CENTER, titleFontSize), color(255), 
    new Button[]{      
      new Button(buttonRightPos, buttonSize, 3, false, LEFT, RIGHT)
    }, 
    new TextBox[]{
      new TextBox(noPage, bigTextBoxPosition, bigTextBoxSize, LEFT),       
    }, false
    ), 
    new Scene(
    new Title(yesPageTitle, bigTitlePosition, bigTitleSize, CENTER, titleFontSize), color(255), 
    new Button[]{      
      new Button(buttonRightPos, buttonSize, 4, false, LEFT, RIGHT)
    }, 
    new TextBox[]{
      new TextBox(yesPage, bigTextBoxPosition, bigTextBoxSize, LEFT),       
    }, false
    ), 
    new Scene(
    new Title(infoPage1Title, smallTitlePosition, smallTitleSize, CENTER, titleFontSize), color(255), 
    new Button[]{
      new Button(buttonLeftPos, buttonSize, 3, false, RIGHT, LEFT), 
      new Button(buttonRightPos, buttonSize, 5, false, LEFT, RIGHT)
    }, 
    new TextBox[]{
      new TextBox(infoPage1, smallTextBoxPosition, smallTextBoxSize, LEFT),  
    }, false
    ), 
    new Scene(
    new Title(infoPage2Title, smallTitlePosition, smallTitleSize, CENTER, titleFontSize), color(255), 
    new Button[]{
      new Button(buttonLeftPos, buttonSize, 4, false, RIGHT, LEFT), 
      new Button(buttonRightPos, buttonSize, 6, false, LEFT, RIGHT)
    }, 
    new TextBox[]{
      new TextBox(infoPage2, smallTextBoxPosition, smallTextBoxSize, LEFT),  
    }, false
    ), 
    new Scene(
    new Title(questionTwo, questionPosition, questionSize, CENTER, titleFontSize), color(255), 
    new Button[]{
      new Button(buttonLeftPos, buttonSize, "NO", 7, true, RIGHT), 
      new Button(buttonRightPos, buttonSize, "YES", 7, true, LEFT)
    }, true
    ), 
    new Scene(
    new Title(thankYouPageTxt, questionPosition, questionSize, CENTER, titleFontSize), color(255), 
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
