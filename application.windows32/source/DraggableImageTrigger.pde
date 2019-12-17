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
  private color pulseStrokeColor = color(0, 252, 166);
  
  // The stroke size on the pulse effect
  private float pulseStrokeWeight = 1.5;
  
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
  PVector center() {
    return new PVector(position.x+(size.x/2), position.y+(size.y/2)); 
  }
}
