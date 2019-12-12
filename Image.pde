// Defines an image with a position and a size, that needs to be drawn relative to a scene.
// The image class is used by the Scene class to show simpel images, which doesn't need other
// functionality than being displayed at a scene
public class Image {
  
  // the position of the image
  private PVector position;
  // the size of the image
  private PVector size;
  // a reference to the PImage object
  private PImage img;
  
  // Image Constructor
  Image(PVector tempPosition, PVector tempSize, PImage tempImg) {
    
    // store the values passed to the constructor in a suitable variable
    position = new PVector(tempPosition.x, tempPosition.y);
    size = new PVector(tempSize.x, tempSize.y);
    img = tempImg;
  }
  
  // Call to draw an image relative to a scene
  public void display(Scene scene) {
    
    // draw an image at a position relative to the scenes position
    image(img, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}
