public class DragableImageTrigger {
  PVector position;
  PVector size;
  boolean didTrigger;
  
  DragableImageTrigger(PVector _position, PVector _size) {
    position = _position;
    size = _size;
  }
  
  public void reset() {
     didTrigger = false;
  }
  
  public void display(Scene scene) {
    fill(155);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
  
  public boolean collidesWith(DragableImage _img) {
    float dist = PVector.dist(position, _img.position);
    return (dist <= size.x || dist <= size.y);
  }
}

public class DragableImage {
  PVector startPosition;
  PVector position;
  PVector size;
  PImage img;
  boolean isDragging;
  
  DragableImage(PVector _position, PVector _size, PImage _image) {
    startPosition = new PVector(_position.x, _position.y);
    position = _position;
    size = _size;
    img = _image;
  }
  
  public void reset() {
     position = new PVector(startPosition.x, startPosition.y);
     isDragging = false;
  }
  
  public void display(Scene scene) {
    if (isDragging) {
      position = new PVector(mouseX, mouseY); 
    }
    
    image(img, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
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
    if (mouseWithin()) {
      isDragging = true;
    }
  }
  
  public void onMouseReleased() {
    if (isDragging) {
      isDragging = false; 
    }
  }
}
