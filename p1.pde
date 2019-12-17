// import gifAnimation library in order to use the GIF objects
import gifAnimation.*;

// A reference to a 'Data' object
Data data;

// A reference to a 'ParticipantDatum' object
ParticipantDatum participantDatum;

// An array with a reference to all scene objects
Scene[] scenes;

// A reference to the current scene
Scene currentScene;

// A reference to the next scene
Scene nextScene;

// A reference to the name of the first font used
String fontName = "Roboto-Bold.ttf";

// A reference to the name of the second font used
String fontName2 = "Roboto-Regular.ttf";

// A reference to the first font
PFont font;

// A reference to the second font
PFont font2;

// Processing setup function
// Called one time when the application starts
void setup () {
  // Set Processing display window to fullscreen
  fullScreen();

  // Set the application's framerate
  frameRate(30);

  // Load the fonts
  int fontSize = 40;
  font = createFont(fontName, fontSize);
  int font2Size = 30;
  font2 = createFont(fontName2, font2Size);

  // Create an instance of a new participant datum object
  participantDatum = new ParticipantDatum();

  // Create an instance of a new data object  
  data = new Data();
  
  // Load the data that this application has saved from other run times
  data.load();
  
  // Declare the general title font size
  int titleFontSize = 50;
  
  // Declare the frontscene's font size
  int frontsceneFontSize = 70;
  
  // Declare the next scene that should be displayed when triggering navigative from the frontscene scene
  int frontsceneNextSceneIndex = 1;
  
  // Declare the frontscene's background color
  color frontsceneBggColor =  color(255);
  
  // The text used by the frontscene's title object
  String frontsceneTitleTxt = "DRAG AND INSERT THE HUMAN IMPLANT CHIP";
  
  // Declare the position of the frontscene's title
  PVector frontsceneTitlePosition = new PVector (0, 60);
  
  // Declare the size of the frontscene's title
  PVector frontsceneTitleSize = new PVector (width, 100);
  
  // Declare the text alignment of the frontscene's title
  int frontsceneTitleTextAligment = CENTER;
  
  // Create an instance of a new title
  Title frontsceneTitle = new Title(frontsceneTitleTxt, frontsceneTitlePosition, frontsceneTitleSize, frontsceneTitleTextAligment, frontsceneFontSize);
  
  // Declare the start position of the frontscene's draggable image
  PVector frontsceneDraggableImgPosition = new PVector(400, (height/2)+20);
  
  // Declare the size of the frontscene's draggable image
  PVector frontsceneDraggableImgSize = new PVector(250, 320);
  
  // Create an instance of a new gif object to show on the frontscene
  Gif frontsceneGif = new Gif(this, "chip.gif");
  
  // Create an instance of a new DraggableImage object
  DraggableImage frontsceneDraggableImg = new DraggableImage(frontsceneDraggableImgPosition, frontsceneDraggableImgSize, frontsceneGif);
  
  // Declare the position of the frontscene's draggable image trigger
  PVector frontsceneDraggableImgTriggerPosition = new PVector(width-720, (height/2)+140);
  
  // Declare the size of the frontscene's draggable image trigger
  PVector frontsceneDraggableImgTriggerSize = new PVector(50, 50);
  
  // Create an instance of a new DraggableImageTrigger
  DraggableImageTrigger frontsceneDraggableImgTrigger = new DraggableImageTrigger(frontsceneDraggableImgTriggerPosition, frontsceneDraggableImgTriggerSize);
  
  // Declare the position of the frontscene's image
  PVector frontsceneImagePosition = new PVector (width-1000, 220);
  
  // Declare the size of the frontscene's image
  PVector frontsceneImageSize = new PVector (780, 900);
  
  // Load the frontscene's image
  PImage frontscenePImage = loadImage("hand.png");
  
  // Create an instance of a new image
  Image frontsceneImage = new Image(frontsceneImagePosition, frontsceneImageSize, frontscenePImage);
  
  // Create an instance of an array with the image from above
  Image[] frontsceneImages = new Image[] {frontsceneImage};
  
  // Declare the direction of the frontscene's arrows
  int frontsceneArrowDirection = RIGHT;
  
  // Declare the length of the frontscene's arrows
  float frontsceneArrowLength = 150;
  
  // Declare the y position of the frontscene's arrows
  float frontsceneArrowYPosition = (height/2)+100;
  
  // Declare the x start position of the frontscene's arrows
  float frontsceneArrowXStartPosition = 700;
  
  // Declare how much x should increase for each arrow
  float frontsceneArrowXIncrease = 25;
  
  // Declare how much alpha the first arrow should start with
  float frontsceneArrowAlphaStart = 200;
  
  // Declare how much the start alpha should decrease for each arrow
  float frontsceneArrowAlphaDecrease = 25;
  
  // Declare the number of arrows needed on the frontscene
  int numberOfArrows = 7;
  
  // Create an instance of an Arrow array with the length of 'numberOfArrows'
  Arrow[] frontsceneArrows = new Arrow[numberOfArrows];
  
  // loop through the array
  for (int i = 0; i < numberOfArrows; i++) {
    
    // Calculate the x and y position for the current arrow
    PVector arrowPosition = new PVector (frontsceneArrowXStartPosition+(i*frontsceneArrowXIncrease), frontsceneArrowYPosition);
    
    // Calculate the alpha for the current arrow
    float arrowAlpha = frontsceneArrowAlphaStart+(i*frontsceneArrowAlphaDecrease);
    
    // add a new instance of an arrow the frontscene's arrow array
    frontsceneArrows[i] = new Arrow(arrowPosition, frontsceneArrowLength, arrowAlpha, frontsceneArrowDirection);
  }

  // Create an instance of the front page scene
  Scene frontscene = new Scene(frontsceneTitle, frontsceneBggColor, frontsceneDraggableImg, frontsceneDraggableImgTrigger, frontsceneArrows, frontsceneImages, frontsceneNextSceneIndex);
  
  // Declare the position of the question scenes' title object
  PVector questionPosition = new PVector (250, height/2);
  
  // Declare the size of the question scenes' title object
  PVector questionSize = new PVector (width-450, 160);
  
  // Declare the text alignment of the question scenes' title object
  int questionSceneTitleAlignment = CENTER;
  
  // Declare the background color of the question scenes
  color questionSceneColor = color (255);
  
  // Declare the text of the no button   
  String noButtonText = "NO";
  
  // Declare the direction the scene should slide when the no button is clicked
  int noButtonNextSceneDirection = RIGHT;
  
  // Decalre the text of the yes button
  String yesButtonText = "YES";
  
  // Declare the direction the scene should slide when the yes button is clicked
  int yesButtonNextSceneDirection = LEFT;
  
  // Declare wether or not a participant data should be saved on click
  boolean saveParticipantDataOnClick = true;
  
  // Declare the position of the question pages' left button
  PVector buttonLeftPos = new PVector (0, 0);
  
  // Declare the position of the question pages' right button
  PVector buttonRightPos = new PVector (width-150, 0);
  
  // Declare the size of the question pages' buttons
  PVector buttonSize = new PVector (150, height);
  
  // Declare wether or not a participant data should be saved on click
  boolean questionOneSaveCurrentParticipantOnLeave = true;
  
  // Declare the text used for the first question
  String questionOneText = "Are you interested in replacing your various cards from your wallet with a Human Microchip Implant?";
  
  // Declare the title used for the first question
  Title questionOneTitle = new Title(questionOneText, questionPosition, questionSize, questionSceneTitleAlignment, titleFontSize);
  
  // Declare a no button for the first question
  int questionOneNoButtonNextSceneIndex = 2;
  Button questionOneNoButton = new Button(buttonLeftPos, buttonSize, noButtonText, questionOneNoButtonNextSceneIndex, saveParticipantDataOnClick, noButtonNextSceneDirection);
  
  // Declare a yes button for the first question
  int questionYesNoButtonNextSceneIndex = 3;
  Button questionOneYesButton = new Button(buttonRightPos, buttonSize, yesButtonText, questionYesNoButtonNextSceneIndex, saveParticipantDataOnClick, yesButtonNextSceneDirection);
  
  // Create an instance of an array with those two buttons
  Button[] questionOneButtons = new Button[]{questionOneNoButton, questionOneYesButton};
  
  // Create an instance of a scene for the first question
  Scene questionOneScene = new Scene(questionOneTitle, questionSceneColor, questionOneButtons, questionOneSaveCurrentParticipantOnLeave);
  
  // Declare the text used for the second question
  String questionTwoText = "Did the information have a positive influence on your attitude about human implant chips?";
  
  // Declare the title used for the second question
  Title questionTwoTitle = new Title(questionTwoText, questionPosition, questionSize, questionSceneTitleAlignment, titleFontSize);
  
  // Declare a no button for the second question
  int questonTwoNextSceneIndex = 7;
  Button questionTwoNoButton = new Button(buttonLeftPos, buttonSize, noButtonText, questonTwoNextSceneIndex, saveParticipantDataOnClick, noButtonNextSceneDirection);
  
  // Declare a yes button for the second question
  Button questionTwoYesButton = new Button(buttonRightPos, buttonSize, yesButtonText, questonTwoNextSceneIndex, saveParticipantDataOnClick, yesButtonNextSceneDirection);
  
  // Create an instance of an array with those two buttons
  Button[] questionTwoButtons = new Button[]{questionTwoNoButton, questionTwoYesButton};
  
  // Declare wether or not a participant data should be saved on click
  boolean questionTwoSaveCurrentParticipantOnLeave = true;
  
  // Create an instance of a scene for the second question
  Scene questionTwoScene = new Scene(questionTwoTitle, questionSceneColor, questionTwoButtons, questionTwoSaveCurrentParticipantOnLeave);
  
  // Declare a background color used for the info scenes
  color infoScenesBackgroundcolor = color(255);
  
  // Declare a text alignement used for the info scenes
  int infoScenesTitleAlignment = CENTER;
  
  // Declare a position used for a title on info scenes with only one button
  PVector infoScenesBigTitlePosition = new PVector(0, 50);
  
  // Declare a size used for a title on info scenes with only one button
  PVector infoScenesBigTitleSize = new PVector(width-150, 60);  
 
  // Declare a position used for a textbox on info scenes with only one button
  PVector infoScenesBigTextBoxPosition = new PVector(50, 160);
  
  // Declare a size used for a textbox on info scenes with only one button
  PVector infoScenesBigTextBoxSize = new PVector(width-250, height-200);
  
  // Declare the text used for the title on the no page scene
  String noPageTitleText = "A microchip compared to your phone";  
  
  // Create an instance of a title
  Title noPageTitle = new Title(noPageTitleText, infoScenesBigTitlePosition, infoScenesBigTitleSize, infoScenesTitleAlignment, titleFontSize);
  
  // Declare the index number of the scene that will be navigated to if a button on the no page scene is clicked
  int noPageNextSceneIndex = 3;
  
  // Declare the direction the scene should move to
  int noPageNextSceneDirection = LEFT;
  
  // Declare the direction of the arrow inside the scene's buttons
  int noPageArrowDirection = RIGHT;
  
  // Declare if the scene's buttons should save participant data on click
  boolean noPageSaveOnClick = false;
  
  // Create an instance of a button array with an instance of a new button
  Button[] noPageButtons = new Button[] {      
    new Button(buttonRightPos, buttonSize, noPageNextSceneIndex, noPageSaveOnClick, noPageNextSceneDirection, noPageArrowDirection)
  };
  
  // Create an instance of an array with the text used for the bullet points on the no page
  String[] noPageText = new String[]{
    "A microchip implant stores the same amount of personal information as a phone",
    "Phones are more exposed to the threat of security breach since it’s connected to a network and the internet and can be accessed from a distance. ",
    "A microchip doesn’t contain a power source and can only be accessed when in proximity of a chip reader. ",
    "Since the implementation of voice activation programs such as Siri, your phone needs to be listening all the time for the activation phrase. Therefore, you sometimes experience targeted ads about things you have only talked about. ",
    "If you are afraid of being tracked, then your mobile phone and internet history is a much bigger threat than any microchip can ever be. ",
  };
  
  // Create an instance of an array with textboxes for the no page
  TextBox[] noPageTextboxes = new TextBox[] {
    new TextBox(noPageText, infoScenesBigTextBoxPosition, infoScenesBigTextBoxSize),       
  };
  
  // Declare the no page's image's position
  PVector noPageImagePosition = new PVector (width-670, 290);
  
  // Declare the no page's image's size
  PVector noPageImageSize = new PVector (480, 540);
  
  // Load the no page's image
  PImage noPagePImage = loadImage ("phone.png");
  
  // Create an instance of an array with images for the no page
  Image[] noPageImages = new Image[] {
    new Image(noPageImagePosition, noPageImageSize, noPagePImage)
  };
  
  // Declare wether or not the no page should save participant datum on leave
  boolean noPageSaveOnSceneLeave = false;
  
  // Create an instance of a scene
  Scene noPageScene = new Scene(noPageTitle, infoScenesBackgroundcolor, noPageButtons, noPageTextboxes, noPageImages, noPageSaveOnSceneLeave);
  
  // Declare the text used for the title on the yes page scene
  String yesPageTitleText = "What is a microchip";  
  
  // Create an instance of a title
  Title yesPageTitle = new Title(yesPageTitleText, infoScenesBigTitlePosition, infoScenesBigTitleSize, infoScenesTitleAlignment, titleFontSize);
  
  // Declare the index number of the scene that will be navigated to if a button on the yes page scene is clicked
  int yesPageNextSceneIndex = 4;
  
  // Declare the direction the scene should move to
  int yesPageNextSceneDirection = LEFT;
  
  // Declare the direction of the arrow inside the scene's buttons
  int yesPageArrowDirection = RIGHT;
  
  // Declare if the scene's buttons should save participant data on click
  boolean yesPageSaveOnClick = false;
  
  // Create an instance of a button array with an instance of a new button
  Button[] yesPageButtons = new Button[] {      
    new Button(buttonRightPos, buttonSize, yesPageNextSceneIndex, yesPageSaveOnClick, yesPageNextSceneDirection, yesPageArrowDirection)
  };
  
  // Create an instance of an array with the text used for the bullet points on the yes page
  String[] yesPageText = new String[]{
    "A microchip is only the size of a grain of rice", 
    "It leaves no scar or mark when implanted",
    "It only takes 5 – 10 minutes to implant, and can be removed just as quickly ",
    "One of the more common uses for the microchip implants is to be used as fitness cards to their fitness center, and train tickets for those who often travel by train. And it is for this reason also referred to as “An electronic handbag”. ",
    "Microchip implants is sometimes seen as something futuristic, however, there are already as many as 5000+ people who already use microchip implants in their hands in everyday life. ",
  };
  
  // Create an instance of an array with textboxes for the yes page
  TextBox[] yesPageTextboxes = new TextBox[] {
    new TextBox(yesPageText, infoScenesBigTextBoxPosition, infoScenesBigTextBoxSize),       
  };
  
  // Declare the yes page's image's position
  PVector yesPageImagePosition = new PVector (width-670, 290);
  
  // Declare the yes page's image's size
  PVector yesPageImageSize = new PVector (480, 540);
  
  // Load the yes page's image
  PImage yesPagePImage = loadImage ("reader.png");
  
  // Create an instance of an array with images for the yes page
  Image[] yesPageImages = new Image[] {
    new Image(yesPageImagePosition, yesPageImageSize, noPagePImage)
  };
  
  // Declare wether or not the yes page should save participant datum on leave
  boolean yesPageSaveOnSceneLeave = false;
  
  // Create an instance of a scene
  Scene yesPageScene = new Scene(yesPageTitle, infoScenesBackgroundcolor, yesPageButtons, yesPageTextboxes, yesPageImages, yesPageSaveOnSceneLeave);
  
  // Declare a position used for a title on info scenes with two buttons
  PVector infoScenesSmallTitlePosition = new PVector(200, 50);
  
  // Declare a size used for a title on info scenes with two buttons
  PVector infoScenesSmallTitleSize = new PVector(width-400, 60);
  
  // Declare a position used for a textbox on info scenes with two buttons
  PVector infoScenesSmallTextBoxPosition = new PVector(200, 160);
  
  // Declare a size used for a textbox on info scenes with two buttons
  PVector infoScenesSmallTextBoxSize = new PVector(width-400, height-200);
  
  // Declare a text used by the title on info page 1
  String infoPage1TitleText = "The technology behind it";  
  
  // Declare a text used by the title on info page 2
  String infoPage2TitleText = "Medical patients";
  
  // Create an instance of at title for info page 1
  Title infoPage1Title = new Title(infoPage1TitleText, infoScenesSmallTitlePosition, infoScenesSmallTitleSize, infoScenesTitleAlignment, titleFontSize);
  
  // Create an instance of a title for info page 2
  Title infoPage2Title = new Title(infoPage2TitleText, infoScenesSmallTitlePosition, infoScenesSmallTitleSize, infoScenesTitleAlignment, titleFontSize);
  
  // Declare an array of text used for the bullet points on info page 1
  String[] infoPage1Text = new String[]{
    "The microchip implant itself doesn’t contain any data. It contains a code that can be scanned by specific scanners, just like a credit card can’t be scanned anywhere, but only at authorized terminals. ", 
    "The microchip implant, in terms of how it works, uses radio identification frequency, which is a frequency that is right now used to identify products, animals, or access cards to limited areas.",
    "The technology only works together with its intended receiver, which means that the info from the microchip can’t be accessed by someone from the outside."
  };
  
  // Declare an array of text used for the bullet points on info page 2
  String[] infoPage2Text = new String[]{
    "Microchip implants, as of now, are most often seen in medical patients, and are used by doctors and nurses to quickly check the patients' medical history, so that action can be taken more swiftly. ", 
    "This is extremely useful in dire situations where a patient has either passed out, or in other conditions where time is of the essence.",
    "If everyone had a microchip implant, hospitals could check and take action much faster than today",
    "It would become second nature for doctors to check for implants as soon as they get a new patient "
  };
  
  // Declare the textboxes used for info page 1
  TextBox[] infoPage1Textboxes = new TextBox[] {
      new TextBox(infoPage1Text, infoScenesSmallTextBoxPosition, infoScenesSmallTextBoxSize),  
  };
  
  // Declare the textboxes used for info page 1
  TextBox[] infoPage2Textboxes = new TextBox[] {
      new TextBox(infoPage2Text, infoScenesSmallTextBoxPosition, infoScenesSmallTextBoxSize),  
  };
  
  // Declare the index number of previous scene
  int infoPage1PrevSceneIndex = 3;
  // Declare the index number of next the scene
  int infoPage1NextSceneIndex = 5;
  
  // Declare the direction the scene should move to
  int infoPage1PrevNextSceneDirection = RIGHT;
  int infoPage1NextNextSceneDirection = LEFT;
  
  // Declare the direction of the arrow inside the scene's buttons
  int infoPage1PrevArrowDirection = LEFT;
  int infoPage1NextArrowDirection = RIGHT;
  
  // Declare if the scene's buttons should save participant data on click
  boolean infoPage1SaveOnClick = false;
  
  // Declare the buttons for info page 1
  Button[] infoPage1Buttons = new Button[] {
    new Button(buttonLeftPos, buttonSize, infoPage1PrevSceneIndex, infoPage1SaveOnClick, infoPage1PrevNextSceneDirection, infoPage1PrevArrowDirection), 
    new Button(buttonRightPos, buttonSize, infoPage1NextSceneIndex, infoPage1SaveOnClick, infoPage1NextNextSceneDirection, infoPage1NextArrowDirection)
  };
  
  // Declare a position used for the image on info page 1
  PVector infoPage1ImagePosition = new PVector (width-750, 220);
  
  // Declare a size used for the image on info page 1
  PVector infoPage1ImageSize = new PVector (680, 800);
  
  // Loads the image used for info page 1
  PImage infoPage1ImagePImage = loadImage("chip-green.png");
  
  // Declare an array of an image used for info page 1
  Image[] infoPage1Images = new Image[] { new Image(infoPage1ImagePosition, infoPage1ImageSize, infoPage1ImagePImage) };
  
  // Determines if the participant data should be saved on leave
  boolean infoPage1SaveParticipantOnLeave = false;
  
  // Create an instance of a scene
  Scene infoPage1 = new Scene(infoPage1Title, infoScenesBackgroundcolor, infoPage1Buttons, infoPage1Textboxes, infoPage1Images, infoPage1SaveParticipantOnLeave);
  
  // Declare the index number of previous scene
  int infoPage2PrevSceneIndex = 4;
  // Declare the index number of next the scene
  int infoPage2NextSceneIndex = 6;
  
  // Declare the direction the scene should move to
  int infoPage2PrevNextSceneDirection = RIGHT;
  int infoPage2NextNextSceneDirection = LEFT;
  
  // Declare the direction of the arrow inside the scene's buttons
  int infoPage2PrevArrowDirection = LEFT;
  int infoPage2NextArrowDirection = RIGHT;
  
  // Declare if the scene's buttons should save participant data on click
  boolean infoPage2SaveOnClick = false;
  
  // Declare the buttons for info page 2
  Button[] infoPage2Buttons = new Button[] {
    new Button(buttonLeftPos, buttonSize, infoPage2PrevSceneIndex, infoPage2SaveOnClick, infoPage2PrevNextSceneDirection, infoPage2PrevArrowDirection), 
    new Button(buttonRightPos, buttonSize, infoPage2NextSceneIndex, infoPage2SaveOnClick, infoPage2NextNextSceneDirection, infoPage2NextArrowDirection)
  };
  
  // Declare a position used for the image on info page 2
  PVector infoPage2ImagePosition = new PVector (width-640, 340);
  
  // Declare a size used for the image on info page 2
  PVector infoPage2ImageSize = new PVector (480, 600);
  
  // Loads the image used for info page 2
  PImage infoPage2ImagePImage = loadImage("chip-red.png");
  
  // Declare an array of an image used for info page 2
  Image[] infoPage2Images = new Image[] { new Image(infoPage2ImagePosition, infoPage2ImageSize, infoPage2ImagePImage) };
  
  // Determines if the participant data should be saved on leave
  boolean infoPage2SaveParticipantOnLeave = false;
  
  // Create an instance of a scene
  Scene infoPage2 = new Scene(infoPage2Title, infoScenesBackgroundcolor, infoPage2Buttons, infoPage2Textboxes, infoPage2Images, infoPage2SaveParticipantOnLeave);
  
  // Declare a text used for the title on the thank you page
  String thankYouPageTxt = "Thank you for your participation";
  
  // Create an instance of a title for the thank you page
  Title thankYouPageTitle = new Title(thankYouPageTxt, questionPosition, questionSize, infoScenesTitleAlignment, titleFontSize);
  
  // Declare the position of the thank you page's scene loader
  PVector sceneLoaderPosition = new PVector (200, height/2);
  
  // Declare the size of the thank you page's scene loader
  PVector sceneLoaderSize = new PVector (width-400, 50);  
  
  // Create an instance of a scene loader for the thank you page
  SceneLoader sceneLoader = new SceneLoader(sceneLoaderPosition, sceneLoaderSize);
  
  // Set the next scene index that the sceneloader should loader on the thank you page
  int thankYouSceneNextSceneIndex = 0;
  
  // Create an instance of a scene
  Scene thankYouScene = new Scene(thankYouPageTitle, infoScenesBackgroundcolor, sceneLoader, thankYouSceneNextSceneIndex);
  
  // Create an instance of an array
  scenes = new Scene[] {
    frontscene,
    questionOneScene, 
    noPageScene, 
    yesPageScene, 
    infoPage1, 
    infoPage2, 
    questionTwoScene, 
    thankYouScene
  };

  // set the default scene to the first scene object of the scene array
  currentScene = scenes[0];
}

// Processing draw function
// Called once every frame until stopped
void draw() {
  // Set the background color of Processing display window
  background(#33daf8);
  // if we the value of currentScene is NOT equal to 'null'
  // call the display function on the current scene object
  if (currentScene != null) currentScene.display();

  // if both the value of currentScene and nextScene is NOT null
  if (currentScene != null && nextScene != null) {
    
    // display the next scene
    nextScene.display();
    
    // check if the scenes are slided in or out
    boolean currentIsOut = currentScene.slideOut();
    boolean newIsIn = nextScene.slideIn();
    
    // if both have slided in or out
    if (currentIsOut && newIsIn) {
      
      // if the current scene is set to save and add a new participant on leave
      // run "addParticipantDatum"
      if (currentScene.saveParticipantOnLeave) addParticipantDatum();
      
      // set the current scene to the next scene
      currentScene = nextScene;   
      
      // run before display on that scene to reset it to its initial state
      currentScene.beforeDisplay();
      
      // ensure the scene have the correct position
      currentScene.position.x = 0;
      
      // set the value of nextScene to null
      nextScene = null;
    }
  }
}

// Processing mousePressed function
// Called whenever the user touch the display or clicks with a mouse
void mousePressed() {
  
  // if the current scene is NOT null
  // call its on mouse pressed function whenever Processing mousePressed function is triggered
  if (currentScene != null) currentScene.onMousePressed();
}

// Processing mouseReleased function
// Called whenever the user remove the finger from the display or release the button clicked on the mouse
void mouseReleased() {
  
  // if the current scene is NOT null
  // call its on mouse released function whenever Processing mouseReleased function is triggered
  if (currentScene != null) currentScene.onMouseReleased();
}

// The application's navigate function
// Used to start the navigation process between scenes
void navigate(Scene scene, boolean resetPosition) {
  
  // Calls 'beforedisplay' on the next scene
  scene.beforeDisplay();   
  
  // if the navigate function is meant to reset the next scenes position
  if (resetPosition) {
    
    // if the the scene should slide in from the left side of the display
    if (scene.slideInDirection == LEFT) {
      
      // set the position of the next scene to the right for the display
      scene.position = new PVector(width, 0);
      
    // else if it was meant to slide in from the right side of the display
    } else {
      
      // set the position of the next scene to the left for the display
      scene.position = new PVector(-width, 0);
    }
  }
  
  // store the next scene to use in draw to show the slide transition
  nextScene = scene;
}

// The application's add participant datum function
// Used to add the current participant to the data object's participant data array list
// and write the updated array list to the JSON file
// and create a new instance of a ParticipantDatum object to track the answers of the next participant 
public void addParticipantDatum() {
  data.participantdata.add(participantDatum);
  data.save();
  participantDatum = new ParticipantDatum();
}
