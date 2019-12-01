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
  private color textColor = #33daf8;  
  
  private int txtSize = 30;
  
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

public class TextBox {
  
  public String titleTxt;
  public String txt;
  
  private PVector position;
  private PVector size;

  private float txtSize = 20;
  private color boxFillColor = #33daf8;
  private color boxStrokeColor = #33daf8; 
  
  private color textColor = color(255);  
  private int align;
  
  private float textPadding = 30;
  
  // The title's constructor
  TextBox(String _titleTxt, String _text, PVector _position, PVector _size, int _align) {
    titleTxt = _titleTxt;
    txt = _text;
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
  }
  
  public void display(Scene scene) {
    fill(boxFillColor);
    stroke(boxStrokeColor);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
    fill(textColor);
    textSize(txtSize);
    textFont(font2);
    textAlign(align);
    text(titleTxt, scene.position.x+position.x+(textPadding/2), scene.position.y+position.y+(textPadding/2), size.x-textPadding, size.y-textPadding);      
    text(txt, scene.position.x+position.x+(textPadding/2), scene.position.y+position.y+(textPadding/2)+(textPadding/1.2), size.x-textPadding, size.y);
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

public class Button {
 
  PVector position;
  PVector size;
  color fillColor = #33daf8;
  color defFillColor = #33daf8;
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
