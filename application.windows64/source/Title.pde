// Defines a custom class called 'Title'
// In cases where a scene needs a title should an instance of this object
// be passed to the scene constructor and a title will be drawed at that scene
public class Title {
  
  // A reference to a string object hold the title's text
  public String txt;
  
  // The position of the title
  private PVector position;
  
  // The position of the title
  private PVector size;
  
  // The color of the title's text
  private color textColor = #096192;  
  
  // The size of the title's text
  private int txtSize;
  
  // The position of the text alignment within the text elements size
  private int align;
  
  // The title's constructor
  Title(String _text, PVector _position, PVector _size, int _align, int _txtSize) {
    
    // store the values passed to the constructor in a suitable variable
    txt = _text;
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
    txtSize = _txtSize;
  }
  
  // Call to draw a title relative to a scene
  public void display(Scene scene) {
    
    // Set text color
    fill(textColor);
    
    // Set text font
    textFont(font);    
    
    // Set text alignment
    textAlign(align);
    
    // Set text size
    textSize(txtSize);
    
    // draw a text relative to the scene's position
    text(txt, scene.position.x+position.x, scene.position.y+position.y, size.x, size.y);
  }
}
