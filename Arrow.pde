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
