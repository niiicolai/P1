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
  
  public String txt;
  
  private PVector position;
  private PVector size;
  
  private color boxFillColor = #33daf8;
  private color boxStrokeColor = #33daf8; 
  
  private color textColor = color(255);  
  private int align;
  
  private float textPadding = 30;
  
  // The title's constructor
  TextBox(String _text, PVector _position, PVector _size, int _align) {
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
    textFont(font2);
    textAlign(align);
    text(txt, scene.position.x+position.x+(textPadding/2), scene.position.y+position.y+(textPadding/2), size.x-textPadding, size.y-textPadding);
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
  color textFillColor = color(255);
  String txt;
    
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
  
  public void display(Scene scene) {
    fill(fillColor);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
    fill(textFillColor);
    textAlign(CENTER);
    text(txt, scene.position.x+position.x, scene.position.y+position.y+(size.y/2), size.x, size.y);
  }
  
  public void onMousePressed() {
    if (mouseWithin()) {
      
      if (saveClick) {
        ParticipantAnswer participantAnswer = new ParticipantAnswer();
        participantAnswer.dateTime = data.dateTime();
        participantAnswer.question = currentScene.title.txt;
        participantAnswer.answer = txt;
        participantDatum.answers.add(participantAnswer);
      }
      
      currentScene.slideOutDirection = nextSceneDirection;
      scenes[nextSceneIndex].slideInDirection = nextSceneDirection;
      navigate(scenes[nextSceneIndex]);
    }
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
  
  Arrow(PVector _position, float l, float alphaStart) {
    position = _position;
    _length = l;
    fillColorAlpha = alphaStart;
  }
  
  public void display(Scene scene) {
    PVector midPosition = new PVector (scene.position.x+position.x+(_length/2), scene.position.y+position.y+(_length/2));
    fillColorAlpha = (fillColorAlpha+fillColorAlphaSpeed) % maxFillColorAlpha;
    if (fillColorAlpha < fillColorAlphaMin) fillColorAlpha = fillColorAlphaMin;
    stroke(color(fillColor.x, fillColor.y, fillColor.z, fillColorAlpha));
    strokeWeight(_strokeWeight);
    line(scene.position.x+position.x, scene.position.y+position.y, midPosition.x, midPosition.y); 
    line(scene.position.x+position.x, scene.position.y+position.y+_length, midPosition.x, midPosition.y); 
  }
}
