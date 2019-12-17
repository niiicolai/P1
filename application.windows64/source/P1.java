import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class P1 extends PApplet {

// import gifAnimation library in order to use the GIF objects


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
public void setup () {
  // Set Processing display window to fullscreen
  

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
  int frontsceneBggColor =  color(255);
  
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
  int questionSceneColor = color (255);
  
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
  int infoScenesBackgroundcolor = color(255);
  
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
  
  // Declare the number of scene indicators
  int numberOfSceneIndicator = 3;
  
  // Declare each scenes' indicator number
  int yesPageIndicatorNumber = 0;
  int infoPage1IndicatorNumber = 1;
  int infoPage2IndicatorNumber = 2;
  
  // Declare the position of the scene indicator
  PVector yesSceneIndicatorPosition = new PVector (width/2-130, height-100);
  
  // Declare the position of the scene indicator
  PVector infoSceneIndicatorPosition = new PVector (width/2-50, height-100);
  
  // Create an instance of an indicator for each scene where it's neccesary
  SceneIndicator yesPageSceneIndicator = new SceneIndicator(yesSceneIndicatorPosition, numberOfSceneIndicator, yesPageIndicatorNumber);   
  SceneIndicator infoPage1SceneIndicator = new SceneIndicator(infoSceneIndicatorPosition, numberOfSceneIndicator, infoPage1IndicatorNumber);   
  SceneIndicator infoPage2SceneIndicator = new SceneIndicator(infoSceneIndicatorPosition, numberOfSceneIndicator, infoPage2IndicatorNumber); 
  
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
  Scene yesPageScene = new Scene(yesPageTitle, infoScenesBackgroundcolor, yesPageButtons, yesPageTextboxes, yesPageImages, yesPageSceneIndicator, yesPageSaveOnSceneLeave);
  
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
  Scene infoPage1 = new Scene(infoPage1Title, infoScenesBackgroundcolor, infoPage1Buttons, infoPage1Textboxes, infoPage1Images, infoPage1SceneIndicator, infoPage1SaveParticipantOnLeave);
  
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
  Scene infoPage2 = new Scene(infoPage2Title, infoScenesBackgroundcolor, infoPage2Buttons, infoPage2Textboxes, infoPage2Images, infoPage2SceneIndicator, infoPage2SaveParticipantOnLeave);
  
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
public void draw() {
  // Set the background color of Processing display window
  background(0xff33daf8);
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
public void mousePressed() {
  
  // if the current scene is NOT null
  // call its on mouse pressed function whenever Processing mousePressed function is triggered
  if (currentScene != null) currentScene.onMousePressed();
}

// Processing mouseReleased function
// Called whenever the user remove the finger from the display or release the button clicked on the mouse
public void mouseReleased() {
  
  // if the current scene is NOT null
  // call its on mouse released function whenever Processing mouseReleased function is triggered
  if (currentScene != null) currentScene.onMouseReleased();
}

// The application's navigate function
// Used to start the navigation process between scenes
public void navigate(Scene scene, boolean resetPosition) {
  
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
// Defines an arrow at a position relative to a scene
public class Arrow {
  
  // The position of the arrow within the scene
  PVector position;
  
  // The length of the arrow
  float _length;
  
  // The arrows stroke size
  float _strokeWeight = 3; 
  
  // The arrows color stored in a PVector to easy get the colors values
  // to use with fading functionality
  PVector fillColor = new PVector(0, 252, 166);
  
  // The current amount of alpha applied to the arrow's stroke
  float fillColorAlpha;
  
  // The minimum amount of alpha the stroke can be
  float fillColorAlphaMin = 50;
  
  // The maximum amount of alpha the stroke can be
  float maxFillColorAlpha = 255;
  
  // The amount of speed the alpha will increase with
  float fillColorAlphaSpeed = 3;
  
  // Set to true if the arrow should be displayed without fade
  boolean disableFade;
  
  // The direction of the arrow on the x axis. Example (< vs >)
  int direction = LEFT;
  
  // The first constructor of the arrow, used in situations where fading is needed
  Arrow(PVector _position, float l, float alphaStart, int _direction) {
    
    // store the values passed to the constructor in a suitable variable
    position = _position;
    _length = l;
    fillColorAlpha = alphaStart;
    direction = _direction;
  }
    
  // The second constructor of the arrow, used in situations where fading is NOT needed
  Arrow(PVector _position, float l, float strkWeight, int _direction, PVector _fillColor) {
    
    // store the values passed to the constructor in a suitable variable
    position = _position;
    _length = l;
    _strokeWeight = strkWeight;
    fillColorAlpha = maxFillColorAlpha;
    fillColor = _fillColor;
    direction = _direction;
    disableFade = true;
  }
  
  // call to draw the arrow relative to a scene
  public void display(Scene scene) {
    
    // The arrow is build with two lines, therefore should we have 3 positions to draw it.
    // First, we need to calculate the mid position of the arrow
    // This is done by finding the length that needs to be applied before reach the mid position on x axis
    // As this is a two scenario situation where we either need to know the length to the left or right side
    // we can use a ternary operator (statement ? if true : if false);
    float lengthBetweenMidAndStart = (direction == LEFT ? -(_length/2) : (_length/2));
    
    // we find the mid position by applying 'lengthBetweenMidAndStart' to the start position on the x axis and
    // and we add halft the length to the arrow.
    PVector midPosition = new PVector (scene.position.x+position.x+(lengthBetweenMidAndStart), 
                                       scene.position.y+position.y+(_length/2));
    
    // Before drawing the two lines using the found mid position
    // we check if the arrow needs fading or it is disabled
    if (!disableFade) {
      
      // We set the alpha to its current value + the increasment speed and use the modulo operator
      // to ensure that the value doesn't exceed our wanted max alpha
      fillColorAlpha = (fillColorAlpha+fillColorAlphaSpeed) % maxFillColorAlpha;
      
      // in scenarios where the value reached the max alpha, would the alpha be set to zero
      // but because we want a minimum alpha do we check if it less than the value of or wanted minimum alpha
      // and if it is, we set the value to the minimum
      if (fillColorAlpha < fillColorAlphaMin) fillColorAlpha = fillColorAlphaMin;
    }
    
    // We then apply an RGB color (red, green, blue, alpha)
    // to the stroke color of the arrow
    stroke(color(fillColor.x, fillColor.y, fillColor.z, fillColorAlpha));
    
    // We set the size of the arrow's stroke   
    strokeWeight(_strokeWeight);
    
    // We draw a line relative to the scene from the given start position to the mid position
    line(scene.position.x+position.x, scene.position.y+position.y, midPosition.x, midPosition.y); 
    
    // We draw a line relative to the scene from the given start position + the length on the y axis
    // to the found mid position
    line(scene.position.x+position.x, scene.position.y+position.y+_length, midPosition.x, midPosition.y); 
  }
}
// Used to define a bullet point object which is a text with a cicle drawed next to it
public class BulletPoint {
  
  // The text's size
  private float txtSize = 40;
  
  // the text's alignment
  private int align = LEFT;
  
  // The text's color
  private int txtColor = color (255);
  
  // The actual text
  private String txt;
  
  // The circle's radius
  private float pointRadius = 13;
  
  // The circle's position relative to the text
  private PVector pointOffset = new PVector(25, 18);
  
  // The default amount of lines
  private int lines = 1;
  
  private int char1 = 80;
  private int char2 = 150;
  
  // The bullet point's constructor
  BulletPoint(String _txt) {
    
    // store the values passed to the constructor in a suitable variable
    txt = _txt;
    
    // Get the number of chars within the string
    float textLength = txt.length();
    // if the number of chars is greater than char1 but less than char2
    // set the line number to '2'
    if (textLength > char1 && textLength < char2) lines = 2;
    // if the number of chars is greater than char2 
    else if (textLength > char2) lines = 3;
    // Keep in mind that this only support 3 lines    
  }
  
  // Call to display the bullet point at a given position and size
  public void display(float x, float y, PVector size) {
    
    // set the text color
    fill(txtColor);
    
    // set the text size
    textSize(txtSize);
    
    // set the text font
    textFont(font2);
    
    // set the text alignment
    textAlign(align);   
    
    // draw the text
    text(txt, x, y-pointOffset.y, size.x/1.4f, size.y);
    
    // remove stroke on the next processing shape
    noStroke();
    
    // draw a cicle to the screen
    circle(x-pointOffset.x, y, pointRadius);    
  }
}
// Defines a button with a position, size, and the ability to slide between scenes on click or 'click AND drag'
public class Button {
 
  // The button's position
  PVector position;
  
  // The button's size
  PVector size;
  
  // The button's current fill color
  int fillColor = 0xff096192;
  
  // The button's default fill color
  int defFillColor = 0xff096192;
  
  // The button's fill color when clicked
  int clickFillColor = 0xff24aae2;
  
  // The button's text's fill color
  int textFillColor = color(255);
  
  // A simple frame counter used to reset the click color
  // after the user remove the mouse or finger from the button
  int clickCounter;
  
  // The amount of frames that should count before the button reset its color on click
  int clickCounterMax = 15;
  
  // The text that should be displayed within the button
  String txt;
  
  // The distance between where the button was clicked and the middle of the button
  // Used to ensure you can click a button and drag it from any position within the button
  // without moving the whole scene so that the mouse is at the middle of the button
  float mouseClickOffset;
  
  // Used to determine wether or not a button can click and drag to a new scene
  boolean canDragScene;
  
  // Used to check if the user clicked the button and the scene should be dragged
  boolean draggingScene;
  
  // Used to show an arrow in the middle of the button
  Arrow arrow;
  
  // Used to determine wether or not a button should call the save 'data' functionality 
  boolean saveClick;
  
  // Used to determine wether or not the next scene is left or right for the current scene
  int nextSceneDirection = LEFT;
  
  // Used to find the next scene from the 'scenes' array
  int nextSceneIndex;
  
  // The button's first constructor
  // Used in cases where a button without the 'drag-scene-functionality' is needed and 
  // the button should show a text
  Button(PVector _position, PVector _size, String _text, int _nextSceneIndex, boolean _saveClick, int _nextSceneDirection) {
    
    // store the values passed to the constructor in a suitable variable
    position = _position;
    size = _size;
    txt = _text;
    nextSceneIndex = _nextSceneIndex;
    saveClick = _saveClick;
    nextSceneDirection = _nextSceneDirection;
  }
  
  // The button's seconds constructor
  // Used in cases where a button need 'drag-scene-functionality' and it should show an arrow inside
  Button(PVector _position, PVector _size, int _nextSceneIndex, boolean _saveClick, int _nextSceneDirection, int arrowDirection) {
    
    // store the values passed to the constructor in a suitable variable
    position = _position;
    size = _size;
    txt = "";
    nextSceneIndex = _nextSceneIndex;
    saveClick = _saveClick;
    nextSceneDirection = _nextSceneDirection;
    float offset = (arrowDirection == LEFT ? 10 : -10);
    arrow = new Arrow(new PVector(position.x+(size.x/2)+offset, position.y+(size.y/2)), 50, 8, arrowDirection, new PVector(255, 255, 255));
    canDragScene = true;
  }
  
  // Call to reset the button to its initial state
  // Should be called from a scene's 'beforeDisplay' function
  public void reset() {
    
    // Ensure the button has deactivaed 'dragging'
    draggingScene = false;
    
    // Set the current fill color to the default color
    fillColor = defFillColor;
  }
  
  // Call to display the button relative to the current scene
  public void display(Scene scene) {
    
    // Disable stroke on next processing shape 
    noStroke();
    
    // Set the button's fill color
    fill(fillColor);
    
    // Draw a rect relative to the scene with the given size
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
    
    // Set the text's fill color
    fill(textFillColor);
    
    // Set the text's alignment
    textAlign(CENTER);    
    
    // Draw a text element to the scene relative to the scene at the middle of the button's position
    text(txt, scene.position.x+position.x, scene.position.y+position.y+(size.y/2), size.x, size.y);
    
    // If the arrow has an arrow,
    // call the arrow's 'display' function
    if (arrow != null) arrow.display(scene);
    
    // if no one is dragging the button and it doesn't have
    // the default fill color
    if (!draggingScene && fillColor == clickFillColor) {
      
      // Increment the click counter each frame
      clickCounter++;
      
      // If the click counter is greater or equal to the given click counter max
      if (clickCounter >= clickCounterMax) {
        
        // reset the fill color to the default fill color
        fillColor = defFillColor; 
      }
    }
    
    // if the user is current 'holding' the button down
    if (draggingScene) {
      
      // draw the next scene to the screen
      scenes[nextSceneIndex].display();
      
      // if the next scene is left for the current scene
      if (nextSceneDirection == LEFT) {         
        
        // draw the current scene and the next scene side by side
        // and move the relative to where the user clicked the button and the current mouse position
        currentScene.position.x = mouseX-width+(size.x/2)-mouseClickOffset;
        scenes[nextSceneIndex].position.x = mouseX+(size.x/2)-mouseClickOffset;
      } else {
        
         // draw the current scene and the next scene side by side
        // and move the relative to where the user clicked the button and the current mouse position
        currentScene.position.x = mouseX-(size.x/2)-mouseClickOffset;
        scenes[nextSceneIndex].position.x = mouseX-width-(size.x/2)-mouseClickOffset;
      }
    }
  }
  
  // Call to run the button's on click press functionality
  // should be called from within its scene's 'onMousePressed' function 
  public void onMousePressed() {
    
    // if the mouse is within the button and we currently isn't dragging the scene
    if (mouseWithin() && !draggingScene) {
      
      // Move the next scene either to the right or left
      // for the current scene
      if (scenes[nextSceneIndex].slideInDirection == LEFT) {
        scenes[nextSceneIndex].position = new PVector(width, 0);
      } else {
        scenes[nextSceneIndex].position = new PVector(-width, 0);
      }
      
      // Set the button's current color to the fill color
      fillColor = clickFillColor;
      
      // Set the click counter to zero
      clickCounter = 0;
      
      // if the button isn't mean to have the 'drag-scene-functionality'      
      if (!canDragScene) {
        
        // trigger the onclick function
        onclick();   
        
        // return the function here to avoid running the rest of the code
        return;
      }
      
      // if it doesn't return
      // activate the button's dragging scene functionality
      draggingScene = true;      
      
      // calculate the distance between where the user clicked the button and the middle of the button's position
      mouseClickOffset = dist(position.x+(size.x/2), position.y+(size.y/2), mouseX, position.y+(size.y/2));
      
      // if the user clicked the button left for the middle of the button
      // invert the distance to having a negative value
      if (mouseX < position.x+(size.x/2)) mouseClickOffset = -mouseClickOffset; 
    }
  }
  
  // Call to trigger the on click function when the user remove the finger from the screen
  // should be called from within its scene's 'onMouseReleased' function 
  public void onMouseReleased() {
    
    // if the mouse actual is within the button AND
    // is dragging the scene, move to the next scene
    if (mouseWithin() || draggingScene) {      
      if (canDragScene) onclick();
    }
  }
  
  // Call to trigger the button's onclick functionality
  public void onclick() {

    // disable the 'drag-scene-functionality'
    draggingScene = false;
      
    // if the button should save data from the current scene
    if (saveClick) {
      // create a new participant answer
      ParticipantAnswer participantAnswer = new ParticipantAnswer();
      // add the current date time
      participantAnswer.dateTime = data.dateTime();
      // add the current scene's title
      participantAnswer.question = currentScene.title.txt;
      // add the text of the button the user clicked on
      participantAnswer.answer = txt;
      // add the answer to the current participant datum object
      participantDatum.answers.add(participantAnswer);
    }
    
    // set the direction of which side the current scene should slide out
    currentScene.slideOutDirection = nextSceneDirection;
    
    // set the direction of which side the next scene should slide in
    scenes[nextSceneIndex].slideInDirection = nextSceneDirection;
    
    // call the navigate function and tell wether or not it should reset the positions 
    // of the scenes before starting the slide transition.
    // We only want the scenes' positions to reset when a button CANNOT drag a scene
    // because it cases of dragging have the two scene already a wanted position
    navigate(scenes[nextSceneIndex], (canDragScene ? false : true));
  }
  
  // return true or false based on wether or not the mouse position is within the button
  public boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
}
// Defines an object used to handle saving and loading participant data
class Data {
  
  // The final path to the json file
  final String dataPath = "data.json";
  
  // An array list of the partcipant data
  public ArrayList<ParticipantDatum> participantdata = new ArrayList<ParticipantDatum>();
  
  // The JSON keys in which the data are saved
  private String dateTimeKey = "dateTime";
  private String answersKey = "answers";
  private String questionKey = "question";
  private String answerkey = "answer";
  
  // Call whenenver the saved participant data should be loaded again
  // This is done so that new participant data only is applied
  // instead of overwriting the data for each restart
  public void load() {
    
    // Load the json file at the given path
    // and create an instance of a JSONArray
    JSONArray _participantdata = loadJSONArray(dataPath); 
    
    // Loop through all participant data
    for (int i = 0; i < _participantdata.size(); i++) {
      
      // Declare a reference to the current JSON object 
      JSONObject participantJSONObj = _participantdata.getJSONObject(i); 
      
      // Create an instance of a new participant datum
      ParticipantDatum _participantdatum = new ParticipantDatum();
      
      // Set the date time of the participant datum to the value of 'dateTime' saved in the JSON object
      _participantdatum.dateTime = participantJSONObj.getString(dateTimeKey);
      
      // Declare a reference of a JSONArray
      JSONArray _participantAnswers = participantJSONObj.getJSONArray(answersKey);
      
      // Loop through all the saved answers
      for (int x = 0; x < _participantAnswers.size(); x++) {
        
        // Declare a reference to a JSONObject
        JSONObject _participantAnswer = _participantAnswers.getJSONObject(x); 
        
        // Create an instance of a new participant answer
        ParticipantAnswer participantAnswer = new ParticipantAnswer();
        
        // Set the datetime of the paticipant answer
        participantAnswer.dateTime = _participantAnswer.getString(dateTimeKey);
        
        // Set the question value of the paticipant answer
        participantAnswer.question = _participantAnswer.getString(questionKey);
        
        // Set the answer value of the paticipant answer
        participantAnswer.answer = _participantAnswer.getString(answerkey);
        
        // Add the current created answer to the participantdatum's answers array list
        _participantdatum.answers.add(participantAnswer);
      }     

      // add the current created participant datum to the paticipant datum array list
      participantdata.add(_participantdatum);
    }
  }
  
  // Call to write the current participant datum array list to the JSON file
  public void save() {
    
    // Create an instance of a new JSON array
    JSONArray _participantdata = new JSONArray();
    
    // loop through all the participant data
    for (int i = 0; i < participantdata.size(); i++) {
      
      // Create an instance of a new JSON object
      JSONObject participantJSONObj = new JSONObject();
      
      // Add a key called "dateTime" and the value of the current date time
      participantJSONObj.setString(dateTimeKey, dateTime());
      
      // Create an instance of a new JSON array
      JSONArray participantJSONAnswers = new JSONArray();
      
      // Loop through all answers within the current participant datum
      for (int x = 0; x < participantdata.get(i).answers.size(); x++) {
        
        // Create an instance of a new JSON object
        JSONObject _answerJSONObj = new JSONObject();        
        
         // Add a key called "dateTime" and the value of the answer's date time
        _answerJSONObj.setString(dateTimeKey, participantdata.get(i).answers.get(x).dateTime);
        
        // Add a key called "question" and the value of the answer's question
        _answerJSONObj.setString(questionKey, participantdata.get(i).answers.get(x).question);
        
        // Add a key called "answer" and the value of the answer's answer
        _answerJSONObj.setString(answerkey, participantdata.get(i).answers.get(x).answer);
        
        // Add current created JSON object to the reference of an JSON array
        participantJSONAnswers.setJSONObject(x, _answerJSONObj);
      }
      
      // Add that JSON array to the first created JSON object with a key called "answers" and the value of that JSON array
      participantJSONObj.setJSONArray(answersKey, participantJSONAnswers);
      
      // Add the first JSON object to the first JSON array
      _participantdata.setJSONObject(i, participantJSONObj);
    }
    
    // Write the first JSON array to JSON file
    saveJSONArray(_participantdata, dataPath);
  }    
  
  // Returns a dateTime formatted as "y-m-d H:M:S"
  public String dateTime() {
    return year()+"-"+month()+"-"+day()+" "+hour()+":"+minute()+":"+second();
  }
}

// Defines an object that holds a date time and an arraylist of participant answers
class ParticipantDatum {
  public String dateTime;
  public ArrayList<ParticipantAnswer> answers = new ArrayList<ParticipantAnswer>();
}

// Defines an object that holds the answers provided by a participant
class ParticipantAnswer {
  public String dateTime;
  public String question;
  public String answer;
}
// Defines an object that draws an image and follow the mouse position if it is pressed within its position and size 
public class DraggableImage {
  
  // The start position of the object
  private PVector startPosition;
  
  // The position of the object
  private PVector position;
  
  // The size of the object
  private PVector size;
  
  // A reference to a GIF object
  private Gif gifImage;
  
  // Used to check if the user is currently dragging the object
  private boolean isDragging;
  
  // The DraggableImage's constructor
  DraggableImage(PVector _position, PVector _size, Gif _gifImage) {
    
    // store the values passed to the constructor in a suitable variable
    startPosition = new PVector(_position.x, _position.y);
    position = _position;
    size = _size;
    gifImage = _gifImage;    
    
    // call the GIF object's play function 
    gifImage.play();
  }
  
  // Call to reset the position of the object to the start position
  // and ensure dragging is disabled
  public void reset() {
     position = new PVector(startPosition.x, startPosition.y);
     isDragging = false;
  }
  
  // Call to draw the object relative to the scene
  public void display(Scene scene) {
    
    // If the user is currently dragging the object
    if (isDragging) {
      
      // Follow the position of the mouse
      position = new PVector(mouseX-(size.x/2), mouseY-(size.y/2)); 
    }
    
    // Draw the gift relative to the scene with a size
    image(gifImage, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
  
  // returns true if the mouse is within the objects position and size
  public boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
  
  // Call to move the object inside the scene in cases where it is dragged outside proccesing display window
  public void boundariesCheck(Scene scene) {
    
    // if the object's x position is less than the scene's x position
    // move the object's x position to the scene's x position
    if (position.x < scene.position.x) position.x = scene.position.x;
    
    // else if the object's x position is greater than the scene's x position plus the display windows width
    // move the object's x position to the scene's x position plus the display windows width
    else if (position.x+size.x > scene.position.x+width) position.x = scene.position.x+width-size.x;
    
    // if the object's y position is less than the scene's y position
    // move the object's y position to the scene's y position
    if (position.y < scene.position.y) position.y = scene.position.y;
    
    // else if the object's y position is greater than the scene's y position plus the display windows height
    // move the object's y position to the scene's y position plus the display windows height
    else if (position.y+size.y > scene.position.y+height) position.y = scene.position.y+height-size.y;
  }
  
  // called when the user clicks the screen
  public void onMousePressed() {
    
    // if the user clicked within and the object isn't dragging already    
    if (mouseWithin() && !isDragging) {
      
      // activate the dragging functionality
      isDragging = true;
    }
  }
  
  // called when the user removes the finger from the screen
  public void onMouseReleased() {
    
    // if the object is dragging
    if (isDragging) {
      
      // disable the dragging functionality
      isDragging = false; 
    }
  }
  
  // Returns a PVector object with the center position of the draggable image
  public PVector center() {
    return new PVector(position.x+(size.x/2), position.y+(size.y/2)); 
  }
}
// Defines an object with a position and size used to trigger a navigation function
// when a draggable image object overlaps with it
public class DraggableImageTrigger {
  
  // The position of the trigger
  private PVector position;
  
  // The size of the trigger
  private PVector size;
  
  // Used to check if the object already have been triggered once
  public boolean didTrigger;
  
  // The color of the pulse effect
  private int pulseStrokeColor = color(0, 252, 166);
  
  // The stroke size on the pulse effect
  private float pulseStrokeWeight = 1.5f;
  
  // The number of circle's the pulse effect should show
  private int numberOfPulse = 5; 
  
  // The current radius of each pulse
  private float[] currentPulseRadius = new float[numberOfPulse];  
  
  // The speed of the pulse effect
  private float pulseRadiusSpeed = 1;
  
  // The maximum radius of each cicle in the pulse effect
  private float maxPulseRadius = 130;
  
  // The amount of space that should be between the pulse effect
  // when it starts
  private float pulseSpacing = 25;
  
  // The draggableImageTrigger's constructor
  DraggableImageTrigger(PVector _position, PVector _size) {
    
    // store the values passed to the constructor in a suitable variable
    position = _position;
    size = _size;
    
    // reset the pulse to ensure the space between each circle is applied
    resetPulse();
  }
  
  // Call to ensure the space between each circle is applied
  public void resetPulse() {
    
    // loop through all stored radius of the pulse effect
    for (int i = 0; i < numberOfPulse; i++) {
      
      // apply a different radius to each pulse, so they don't start from the same point
      currentPulseRadius[i] = (i*pulseSpacing);
    }
  }
  
  // Call to start detecting overlaps in cases where it already have been triggered
  public void reset() {
     didTrigger = false;
  }
  
  // Call to display the trigger to the scene
  public void display(Scene scene) {
    
    // draw the next processing shapes without a fill color
    fill(color(0,0,0,1));
    
    // set the stroke color of the next processing object
    stroke(pulseStrokeColor);
    
    // set the stroke size of the next processing object
    strokeWeight(pulseStrokeWeight);
    
    // loop through all circles in the pulse effect
    for (int i = 0; i < numberOfPulse; i++) {
      
      // increase the pulse radius of the current pulse until it reach the max radius
      currentPulseRadius[i] = (currentPulseRadius[i]+pulseRadiusSpeed) % maxPulseRadius;
      
      // draw a circle to the screen with the new calculated radius
      circle(scene.position.x+position.x+(size.x/2), scene.position.y+position.y+(size.y/2), currentPulseRadius[i]); 
    }
  }
 
  // Returns true or false if the given draggableImage is overlapping this trigger
  public boolean collidesWith(DraggableImage _img) {
    
    // calculated the distance between the trigger's center position and the images center position
    float dist = PVector.dist(center(), _img.center());
    
    // return true if the distance between is NOT greater than the trigger size plus the images size
    return (dist <= (size.x/2)+(_img.size.x/2)/2 || dist <= (size.y/2)+(_img.size.y/2)/2);
  }
  
  // Returns a PVector object with the center position of the trigger
  public PVector center() {
    return new PVector(position.x+(size.x/2), position.y+(size.y/2)); 
  }
}
// Defines an image with a position and a size, that needs to be drawn relative to a scene.
// The image class is used by the Scene class to show simpel images, which doesn't need other
// functionality than being displayed at a scene
public class Image {
  
  // the position of the image
  private PVector position;
  // the size of the image
  private PVector size;
  // a reference to the PImage object
  private PImage img;
  
  // Image Constructor
  Image(PVector tempPosition, PVector tempSize, PImage tempImg) {
    
    // store the values passed to the constructor in a suitable variable
    position = new PVector(tempPosition.x, tempPosition.y);
    size = new PVector(tempSize.x, tempSize.y);
    img = tempImg;
  }
  
  // Call to draw an image relative to a scene
  public void display(Scene scene) {
    
    // draw an image at a position relative to the scenes position
    image(img, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}
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
  int backgroundColor;
  
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
  
  // A reference to a scene indicator object
  SceneIndicator sceneIndicator;
  
  // A reference to a scene loader object
  SceneLoader sceneLoader;
  
  // Determines wether or not the current participant should be saved when leaving the scene
  // and create a new participant
  boolean saveParticipantOnLeave;
  
  // The scene class' first constructor
  // Used in cases when a draggable image, trigger, arrows and images are neccesary
  Scene (Title _title, int _backgroundColor, DraggableImage image, DraggableImageTrigger trigger, Arrow[] _arrows, Image[] _images, int _nextSceneIndex) {
    
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
  Scene (Title _title, int _backgroundColor, Button[] _buttons, boolean _saveParticipantOnLeave) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    saveParticipantOnLeave = _saveParticipantOnLeave;
  }
  
  // The scene class' third constructor
  // Used in cases when a title and a scene loader are neccesary
  Scene (Title _title, int _backgroundColor, SceneLoader _sceneLoader, int _nextSceneIndex) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    sceneLoader = _sceneLoader;
    nextSceneIndex = _nextSceneIndex;
  }
  
  // The scene class' fourth constructor
  // Used in cases when buttons, textboxes, images and saving are neccesary
  Scene (Title _title, int _backgroundColor, Button[] _buttons, TextBox[] _textBoxes, Image[] tempImages, boolean _saveParticipantOnLeave) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    textBoxes = _textBoxes;
    saveParticipantOnLeave = _saveParticipantOnLeave;
    images = tempImages;
  }
  
  // The scene class' 5. constructor
  // Used in cases when buttons, textboxes, images, saving and scene indications are neccesary
  // This constructor is added after the implementation of the report was written
  // and is therefore not mentioned
  Scene (Title _title, int _backgroundColor, Button[] _buttons, TextBox[] _textBoxes, Image[] tempImages, SceneIndicator tempSceneIndicator, boolean _saveParticipantOnLeave) {
    
    // store the values passed to the constructor in a suitable variable
    title = _title;
    backgroundColor = _backgroundColor;
    buttons = _buttons;
    textBoxes = _textBoxes;
    saveParticipantOnLeave = _saveParticipantOnLeave;
    images = tempImages;
    sceneIndicator = tempSceneIndicator;
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
    
    // if the scene have a scene indicator
    // call the scene indicator's display function
    if (sceneIndicator != null) sceneIndicator.display(this);
    
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
// Used to define an object that indicate the scene the current user is watching
class SceneIndicator {
  
  // The position of the scene indicators
  private PVector position;    
  
  // The number of indicators shown
  // This should be equal to the number of scenes that can be switched between
  // where this indicator is shown
  private int numberOfIndicators;
  
  // The scene number where the indicator is shown
  private int indicatorNumber;
  
  // The radius of the circles used for the indication
  private float indicatorRadius = 30;
  
  // The space between each cicle used for indication
  private float spaceBetweenIndicators = 45;
  
  private int inactiveIndicatorColor = 0xffB2B2B2;
  
  private int activeIndicatorColor = 0xff33daf8;
    
  // The SceneIndicator's constructor
  SceneIndicator(PVector tempPos, int tempNumberOfIndicators, int tempIndicatorNumber) {
    
    // store the values passed to the constructor in a suitable variable
    position = new PVector (tempPos.x, tempPos.y);
    numberOfIndicators = tempNumberOfIndicators;
    indicatorNumber = tempIndicatorNumber;
  }
  
  // Call to draw indicators relative to a scene
  public void display(Scene scene) {
    
    // loop until zero reach the number of indicators
    for (int i = 0; i < numberOfIndicators; i++) {
      
      // Set the fill color of the radius to be either active or inactive
      fill((i == indicatorNumber ? activeIndicatorColor : inactiveIndicatorColor));
      
      float indicatorXPos = scene.position.x+position.x+(i*spaceBetweenIndicators);
      
      // Draw each indicator as a circle
      circle(indicatorXPos, scene.position.y+position.y, indicatorRadius);
    }
  }
}
// We define an abstract object with a position and size, which will be used to 
// automatically load a scene while display a pulse around the given position
public class SceneLoader {
  
  // The mid position of the pulse
  private PVector position;
  
  // The size used to apply a position from where the pulse
  // should start relative to the position
  private PVector size;
  
  // A counter which increase each time the display function is called
  private float counter;
  
  // The max value the counter needs to reach before being reset
  private float counterMax = 250;

  // The color of the pulse ring's stroke
  private int pulseStrokeColor = color(0, 252, 166);
  
  // The size of the pulse ring's stroke
  private float pulseStrokeWeight = 1.5f;
  
  // The number of pulse rings
  private int numberOfPulse = 15; 
  
  // The current radius of each circle being drawn in order to show a ring
  private float[] currentPulseRadius = new float[numberOfPulse];  
  
  // The speed in which the radius of the circle used to draw the rings will increase with.
  private float pulseRadiusSpeed = 1.5f;
  
  // The max radius of the circle before being reset
  private float maxPulseRadius = 420;
  
  // The space there should be between each pulse ring
  private float pulseSpacing = 5;
  
  // The scene loaders constructor
  SceneLoader(PVector _position, PVector _size) {
    
    // store the values passed to the constructor in a suitable variable
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    reset();
  }
  
  // call to reset the position of the pulse rings  
  public void reset() {
    
    // loop from zero to numberOfPulse-1
    for (int i = 0; i < numberOfPulse; i++) {
      
      // set the current index to the value of i multiplid with spacing
      // this is done so each ring has a different radius upon start
      // in order to reach space between them
      currentPulseRadius[i] = (i*pulseSpacing);
    }
  }
  
  // call to draw the pulse relative to the scene
  // and run the counter which navigate the sceen,
  // where this is being shown to a new scene
  public void display(Scene scene) {
    
    // if the value of the counter is less than max, increase the counter
    if (counter < counterMax) counter++;
    // if the counter is greater or equal to max
    if (counter >= counterMax) {
      
      // reset the counter
      counter = 0;
      
      // navigate to a new page
      navigate(scenes[scene.nextSceneIndex], true); 
    }
    
    // set the fill color of the pulse ring's circle to being invisible
    fill(color(0,0,0,1));
    
    // set the stroke color of the pulse ring's circle
    stroke(pulseStrokeColor);
    
    // set the size of the pulse ring's circle
    strokeWeight(pulseStrokeWeight);
    
    // loop from zero to numberOfPulse-1
    for (int i = 0; i < numberOfPulse; i++) {
      
      // increase the radius of the current index with speed, and reset it if it exceeded max
      currentPulseRadius[i] = (currentPulseRadius[i]+pulseRadiusSpeed) % maxPulseRadius;
      // draw a circle relative to the scene using the increasing radius
      circle(scene.position.x+position.x+(size.x/2), scene.position.y+position.y+(size.y/2), currentPulseRadius[i]); 
    }
  }
}
// Used to define a textbox that can should x amount of bullet points
public class TextBox {
  
  // The textbox's bulletpoints
  public BulletPoint[] bulletPoints;
  
  // The position of the textbox
  private PVector position;
  
  // The size of the textbox
  private PVector size;

  // The textbox's fill color
  private int boxFillColor = 0xff096192;
  
  // The textbox's stroke's fill color
  private int boxStrokeColor = 0xff096192; 
  
  // The amount of space between the left side of the text box
  // and the bullet points
  private float textIndent = 50;
  
  // The amount of space between the top and the first bullet point
  private float topPadding = 50;
  
  // The amount of space between each line with text
  private float lineHeight = 50;
  
  // The amount of space between each bullet pint
  private float spaceBetween = 60;
  
  // The amount the corner of the textbox should be 'rounded'
  private float cornerRadius = 5;
  
  // The textbox's constructor
  TextBox(String[] _text, PVector _position, PVector _size) {
    
    // create a new instance of an array of bullet points with the length of the given string array
    bulletPoints = new BulletPoint[_text.length];
    
    // loop through all the text objects and create a bullet point object for each
    for (int i = 0; i < _text.length; i++) {
      bulletPoints[i] = new BulletPoint(_text[i]);
    }
    
    // store the values passed to the constructor in a suitable variable
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
  }
  
  // Call to display the text box and the bulletpoints within
  public void display(Scene scene) {
    
    // Set the textbox's fill color
    fill(boxFillColor);
    
    // set the textbox's stroke color
    stroke(boxStrokeColor);
    
    // draw a rect relative to scene with a size and rounded corners
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y, cornerRadius);  
    
    // Find the first y position of the first bullet point
    float lastY = scene.position.y+position.y+topPadding;
    // Find the x position of the all the bullet points
    float xPos = scene.position.x+position.x+textIndent;
    // loop through all bullet points
    for (int i = 0; i < bulletPoints.length; i++) {    
      // if the current bullet point isn't the first bullet point
      if (i > 0) {
        // calculate a new y position based on the amount of lines the last bullet point had
        lastY += lineHeight*bulletPoints[i-1].lines;
        // and add the standard space between bulelt points
        lastY += spaceBetween;
      }
      
      // draw the bullet point to the screen
      bulletPoints[i].display(xPos, lastY, size); 
    }
  }
}
// Defines a custom class called 'Title'
// In cases where a scene needs a title should an instance of this object
// be passed to the scene constructor and a title will be drawed at that scene
public class Title {
  
  // A reference to a string object hold the title's text
  public String txt;
  
  // The position of the title
  private PVector position;
  
  // The position of the title
  private PVector size;
  
  // The color of the title's text
  private int textColor = 0xff096192;  
  
  // The size of the title's text
  private int txtSize;
  
  // The position of the text alignment within the text elements size
  private int align;
  
  // The title's constructor
  Title(String _text, PVector _position, PVector _size, int _align, int _txtSize) {
    
    // store the values passed to the constructor in a suitable variable
    txt = _text;
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
    txtSize = _txtSize;
  }
  
  // Call to draw a title relative to a scene
  public void display(Scene scene) {
    
    // Set text color
    fill(textColor);
    
    // Set text font
    textFont(font);    
    
    // Set text alignment
    textAlign(align);
    
    // Set text size
    textSize(txtSize);
    
    // draw a text relative to the scene's position
    text(txt, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "P1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
