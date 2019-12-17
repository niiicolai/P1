// Defines a button with a position, size, and the ability to slide between scenes on click or 'click AND drag'
public class Button {
 
  // The button's position
  PVector position;
  
  // The button's size
  PVector size;
  
  // The button's current fill color
  color fillColor = #096192;
  
  // The button's default fill color
  color defFillColor = #096192;
  
  // The button's fill color when clicked
  color clickFillColor = #24aae2;
  
  // The button's text's fill color
  color textFillColor = color(255);
  
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
  boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
}
