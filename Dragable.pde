public class DragableImageTrigger {
  PVector position;
  PVector size;
  boolean didTrigger;
  
  private color pulseStrokeColor = color(0, 252, 166);
  private float pulseStrokeWeight = 1.5;
  private int numberOfPulse = 5; 
  private float[] currentPulseRadius = new float[numberOfPulse];  
  private float pulseRadiusSpeed = .8;
  private float maxPulseRadius = 120;
  private float pulseSpacing = 25;
  
  DragableImageTrigger(PVector _position, PVector _size) {
    position = _position;
    size = _size;
    resetPulse();
  }
  
  public void resetPulse() {
    for (int i = 0; i < numberOfPulse; i++) {
      currentPulseRadius[i] = (i*pulseSpacing);
    }
  }
  
  public void reset() {
     didTrigger = false;
  }
  
  public void display(Scene scene) {
    fill(color(0,0,0,1));
    stroke(pulseStrokeColor);
    strokeWeight(pulseStrokeWeight);
    for (int i = 0; i < numberOfPulse; i++) {
      currentPulseRadius[i] = (currentPulseRadius[i]+pulseRadiusSpeed) % maxPulseRadius;
      circle(scene.position.x+position.x+(size.x/2), scene.position.y+position.y+(size.y/2), currentPulseRadius[i]); 
    }
  }
  
  public boolean collidesWith(DragableImage _img) {
    float dist = PVector.dist(center(), _img.center());
    return (dist <= (size.x/2)+(_img.size.x/2)/2 || dist <= (size.y/2)+(_img.size.y/2)/2);
  }
  
  PVector center() {
    return new PVector(position.x+(size.x/2), position.y+(size.y/2)); 
  }
}

public class DragableImage {
  private PVector startPosition;
  private PVector position;
  private PVector size;
  private Gif gifImage;
  private boolean isDragging;
  
  private color pulseStrokeColor = #03aa77;
  private float pulseStrokeWeight = 1.5; 
  private int numberOfPulse = 5; 
  private float[] currentPulseRadius = new float[numberOfPulse];  
  private float pulseRadiusSpeed = .8;
  private float maxPulseRadius = 200;
  private float pulseSpacing = 15;
  
  DragableImage(PVector _position, PVector _size, Gif _gifImage) {
    startPosition = new PVector(_position.x, _position.y);
    position = _position;
    size = _size;
    gifImage = _gifImage;    
    gifImage.play();
    resetPulse();
  }
  
  public void resetPulse() {
    for (int i = 0; i < numberOfPulse; i++) {
      currentPulseRadius[i] = (i*pulseSpacing);
    }
  }
  
  public void reset() {
     position = new PVector(startPosition.x, startPosition.y);
     isDragging = false;
  }
  
  public void display(Scene scene) {
    if (isDragging) {
      position = new PVector(mouseX-(size.x/2), mouseY-(size.y/2)); 
    } else {
      fill(color(0,0,0,1));
      stroke(pulseStrokeColor);
      strokeWeight(pulseStrokeWeight);
      for (int i = 0; i < numberOfPulse; i++) {
        currentPulseRadius[i] = (currentPulseRadius[i]+pulseRadiusSpeed) % maxPulseRadius;
        circle(position.x+(size.x/2), position.y+(size.y/2), currentPulseRadius[i]); 
      }
    }
    
    image(gifImage, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
  
  public boolean mouseWithin() {
    return (mouseX >= position.x && mouseX <= position.x+size.x &&
        mouseY >= position.y && mouseY <= position.y+size.y);
  }
  
  public void boundariesCheck(Scene scene) {
    if (position.x < scene.position.x) position.x = scene.position.x;
    else if (position.x+size.x > scene.position.x+width) position.x = scene.position.x+width-size.x;
    
    if (position.y < scene.position.y) position.y = scene.position.y;
    else if (position.y+size.y > scene.position.y+height) position.y = scene.position.y+height-size.y;
  }
  
  public void onMousePressed() {
    if (mouseWithin() && !isDragging) {
      isDragging = true;
      resetPulse();
    }
  }
  
  public void onMouseReleased() {
    if (isDragging) {
      isDragging = false; 
    }
  }
  
  public PVector center() {
    return new PVector(position.x+(size.x/2), position.y+(size.y/2)); 
  }
}
