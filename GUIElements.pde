// Defines a custom class called 'Title'
// In cases where a scene needs a title should an instance of this object
// be passed to the scene constructor and a similar title will be drawed
// on each page
public class Title {
  
  // A refernce to a string object hold the title's text
  public String txt;
  
  // The position of the title
  private PVector position;
  
  // The position of the title
  private PVector size;
  
  // The color of the title's text
  private color textColor = #096192;  
  
  private int txtSize;
  
  private int align;
  
  // The title's constructor
  Title(String _text, PVector _position, PVector _size, int _align, int _txtSize) {
    txt = _text;
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
    txtSize = _txtSize;
  }
  
  public void display(Scene scene) {
    fill(textColor);
    textFont(font);
    textAlign(align);
    textSize(txtSize);
    text(txt, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}

public class Image {
  
  private PVector position;
  private PVector size;
  private PImage img;
  
  Image(PVector _position, PVector _size, PImage _img) {
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    img = _img;
  }
  
  public void display(Scene scene) {
    image(img, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}

public class SceneLoader {
  
  private PVector position;
  private PVector size;
  
  private float counter;
  private float counterMax = 250;

  private color pulseStrokeColor = color(0, 252, 166);
  private float pulseStrokeWeight = 1.5;
  private int numberOfPulse = 15; 
  private float[] currentPulseRadius = new float[numberOfPulse];  
  private float pulseRadiusSpeed = 1.5;
  private float maxPulseRadius = 420;
  private float pulseSpacing = 5;
  
  SceneLoader(PVector _position, PVector _size) {
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    reset();
  }
  
  public void reset() {
    for (int i = 0; i < numberOfPulse; i++) {
      currentPulseRadius[i] = (i*pulseSpacing);
    }
  }
  
  public void display(Scene scene) {
    if (counter < counterMax) counter++;
    if (counter >= counterMax) {
      counter = 0;
      navigate(scenes[scene.nextSceneIndex], true); 
    }
    
    fill(color(0,0,0,1));
    stroke(pulseStrokeColor);
    strokeWeight(pulseStrokeWeight);
    for (int i = 0; i < numberOfPulse; i++) {
      currentPulseRadius[i] = (currentPulseRadius[i]+pulseRadiusSpeed) % maxPulseRadius;
      circle(scene.position.x+position.x+(size.x/2), scene.position.y+position.y+(size.y/2), currentPulseRadius[i]); 
    }
  }
}

public class Button {
 
  PVector position;
  PVector size;
  color fillColor = #096192;
  color defFillColor = #096192;
  color clickFillColor = #24aae2;
  color textFillColor = color(255);
  
  int clickCounter;
  int clickCounterMax = 15;
  
  String txt;
  
  float mouseClickOffset;
  boolean canDragScene;
  boolean draggingScene;
  
  Arrow arrow;
    
  boolean saveClick;
  
  int nextSceneDirection = LEFT;
  int nextSceneIndex;
  
  Button(PVector _position, PVector _size, String _text, int _nextSceneIndex, boolean _saveClick, int _nextSceneDirection) {
    position = _position;
    size = _size;
    txt = _text;
    nextSceneIndex = _nextSceneIndex;
    saveClick = _saveClick;
    nextSceneDirection = _nextSceneDirection;
  }
  
  Button(PVector _position, PVector _size, int _nextSceneIndex, boolean _saveClick, int _nextSceneDirection, int arrowDirection) {
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
  
  public void reset() {
    draggingScene = false;
    fillColor = defFillColor;
  }
  
  public void display(Scene scene) {
    noStroke();
    fill(fillColor);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
    fill(textFillColor);
    textAlign(CENTER);    
    text(txt, scene.position.x+position.x, scene.position.y+position.y+(size.y/2), size.x, size.y);
    if (arrow != null) arrow.display(scene);
    
    if (!draggingScene && fillColor == clickFillColor) {
      clickCounter++;
      if (clickCounter >= clickCounterMax) {
        fillColor = defFillColor; 
      }
    }
    
    if (draggingScene) {
      scenes[nextSceneIndex].display();
      
      
      if (nextSceneDirection == LEFT) {         
        currentScene.position.x = mouseX-width+(size.x/2)-mouseClickOffset;
        scenes[nextSceneIndex].position.x = mouseX+(size.x/2)-mouseClickOffset;
      } else {
        currentScene.position.x = mouseX-(size.x/2)-mouseClickOffset;
        scenes[nextSceneIndex].position.x = mouseX-width-(size.x/2)-mouseClickOffset;
      }
    }
  }
  
  public void onMousePressed() {
    if (mouseWithin() && !draggingScene) {
      if (scenes[nextSceneIndex].slideInDirection == LEFT) {
        scenes[nextSceneIndex].position = new PVector(width, 0);
      } else {
        scenes[nextSceneIndex].position = new PVector(-width, 0);
      }
      
      fillColor = clickFillColor;
      clickCounter = 0;
      
      if (!canDragScene) {
        onclick();   
        return;
      }
      
      draggingScene = true;      
      mouseClickOffset = dist(position.x+(size.x/2), position.y+(size.y/2), mouseX, position.y+(size.y/2));
      if (mouseX < position.x+(size.x/2)) mouseClickOffset = -mouseClickOffset; 
    }
  }
  
  public void onMouseReleased() {
    if (mouseWithin() || draggingScene) {
      if (canDragScene) onclick();
    }
  }
  
  public void onclick() {
    draggingScene = false;
      
    if (saveClick) {
      ParticipantAnswer participantAnswer = new ParticipantAnswer();
      participantAnswer.dateTime = data.dateTime();
      participantAnswer.question = currentScene.title.txt;
      participantAnswer.answer = txt;
      participantDatum.answers.add(participantAnswer);
    }
      
    currentScene.slideOutDirection = nextSceneDirection;
    scenes[nextSceneIndex].slideInDirection = nextSceneDirection;
    navigate(scenes[nextSceneIndex], (canDragScene ? false : true));
  }
  
  boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
}

public class TextBox {
  public TextPoint[] textPoints;
  
  private PVector position;
  private PVector size;

  private float txtSize = 40;
  private color boxFillColor = #096192;
  private color boxStrokeColor = #096192; 
  
  private int align;
  
  //private float textPadding = 30;
  private float textIndent = 50;
  private float topPadding = 50;
  private float lineHeight = 50;
  private float spaceBetween = 60;
  private float cornerRadius = 5;
  
  // The title's constructor
  TextBox(String[] _text, PVector _position, PVector _size, int _align) {
    textPoints = new TextPoint[_text.length];
    for (int i = 0; i < _text.length; i++) {
      textPoints[i] = new TextPoint(_text[i]);
    }
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
  }
  
  public void display(Scene scene) {
    fill(boxFillColor);
    stroke(boxStrokeColor);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y, cornerRadius);

    textSize(txtSize);
    textFont(font2);
    textAlign(align);     
    
    float lastY = scene.position.y+position.y+topPadding;
    float xPos = scene.position.x+position.x+textIndent;
    for (int i = 0; i < textPoints.length; i++) {    
      if (i > 0) lastY += lineHeight*textPoints[i-1].lines;
      if (i > 0) lastY += spaceBetween;

      textPoints[i].display(xPos, lastY, size); 
    }
        
    //text(txt, scene.position.x+position.x+(textPadding/2), scene.position.y+position.y+(textPadding/2), size.x-textPadding, size.y);
  }
}

public class TextPoint {
  
  color txtColor = color (255);
  String txt;
  
  float pointRadius = 13;
  PVector pointOffset = new PVector(25, 18);
  
  int lines = 1;
  
  TextPoint(String _txt) {
    txt = _txt;
    
    float textLength = txt.length();
    if (textLength > 140 && textLength < 260) lines = 2;
    else if (textLength > 260) lines = 3;
    
  }
  
  public void display(float x, float y, PVector size) {

    fill(txtColor);
    text(txt, x, y-pointOffset.y, size.x-40, size.y);
    
    noStroke();
    circle(x-pointOffset.x, y, pointRadius);    
  }
}

public class Arrow {
  PVector position;
  float _length;
  float _strokeWeight = 3;  
  PVector fillColor = new PVector(0, 252, 166);
  float fillColorAlpha;
  float fillColorAlphaMin = 50;
  float fillColorAlphaSpeed = 3;
  float maxFillColorAlpha = 255;
  boolean disableFade;
  int direction = LEFT;
  
  Arrow(PVector _position, float l, float alphaStart, int _direction) {
    position = _position;
    _length = l;
    fillColorAlpha = alphaStart;
    direction = _direction;
  }
  
  Arrow(PVector _position, float l, float strkWeight, int _direction, PVector _fillColor) {
    position = _position;
    _length = l;
    _strokeWeight = strkWeight;
    fillColorAlpha = maxFillColorAlpha;
    fillColor = _fillColor;
    direction = _direction;
    disableFade = true;
  }
  
  public void display(Scene scene) {
    float l = (direction == LEFT ? -(_length/2) : (_length/2));
    PVector midPosition = new PVector (scene.position.x+position.x+(l), scene.position.y+position.y+(_length/2));
    if (!disableFade) {
      fillColorAlpha = (fillColorAlpha+fillColorAlphaSpeed) % maxFillColorAlpha;
      if (fillColorAlpha < fillColorAlphaMin) fillColorAlpha = fillColorAlphaMin;
    }
    stroke(color(fillColor.x, fillColor.y, fillColor.z, fillColorAlpha));
    strokeWeight(_strokeWeight);
    line(scene.position.x+position.x, scene.position.y+position.y, midPosition.x, midPosition.y); 
    line(scene.position.x+position.x, scene.position.y+position.y+_length, midPosition.x, midPosition.y); 
  }
}
