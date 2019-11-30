public class DragableImageTrigger {
  PVector position;
  PVector size;
  boolean didTrigger;
  
  DragableImageTrigger(PVector _position, PVector _size) {
    position = _position;
    size = _size;
  }
  
  void display(Scene scene) {
    fill(155);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
  
  boolean collidesWith(DragableImage _img) {
    float dist = PVector.dist(position, _img.position);
    return (dist <= size.x || dist <= size.y);
  }
}

public class DragableImage {
 
  PVector position;
  PVector size;
  PImage _image;
  boolean isDragging;
  
  DragableImage(PVector _position, PVector _size, PImage __image) {
    position = _position;
    size = _size;
    _image = __image;
  }
  
  void display(Scene scene) {
    if (isDragging) {
      position = new PVector(mouseX, mouseY); 
    }
    
    image(_image, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
  
  boolean mouseWithin() {
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
