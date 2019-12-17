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
  
  private color inactiveIndicatorColor = #B2B2B2;
  
  private color activeIndicatorColor = #33daf8;
    
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
