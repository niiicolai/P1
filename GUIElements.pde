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
