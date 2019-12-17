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
  private color pulseStrokeColor = color(0, 252, 166);
  
  // The size of the pulse ring's stroke
  private float pulseStrokeWeight = 1.5;
  
  // The number of pulse rings
  private int numberOfPulse = 15; 
  
  // The current radius of each circle being drawn in order to show a ring
  private float[] currentPulseRadius = new float[numberOfPulse];  
  
  // The speed in which the radius of the circle used to draw the rings will increase with.
  private float pulseRadiusSpeed = 1.5;
  
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
