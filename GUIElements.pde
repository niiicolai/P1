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
  private color textColor = color(0);  
  
  private int align;
  
  // The title's constructor
  Title(String _text, PVector _position, PVector _size, int _align) {
    txt = _text;
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
  }
  
  public void display(Scene scene) {
    fill(textColor);
    textFont(font);
    textAlign(align);
    text(txt, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}

public class Button {
 
  PVector position;
  PVector size;
  color fillColor = color(0);
  color textFillColor = color(255);
  String txt;
  
  boolean saveClick;
  
  int nextSceneIndex;
  
  Button(PVector _position, PVector _size, String _text, int _nextSceneIndex, boolean _saveClick) {
    position = _position;
    size = _size;
    txt = _text;
    nextSceneIndex = _nextSceneIndex;
    saveClick = _saveClick;
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
      
      navigate(scenes[nextSceneIndex]);
    }
  }
  
  boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
}
