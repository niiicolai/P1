// Used to define a bullet point object which is a text with a cicle drawed next to it
public class BulletPoint {
  
  // The text's size
  private float txtSize = 40;
  
  // the text's alignment
  private int align = LEFT;
  
  // The text's color
  private color txtColor = color (255);
  
  // The actual text
  private String txt;
  
  // The circle's radius
  private float pointRadius = 13;
  
  // The circle's position relative to the text
  private PVector pointOffset = new PVector(25, 18);
  
  // The default amount of lines
  private int lines = 1;
  
  private int char1 = 80;
  private int char2 = 150;
  
  // The bullet point's constructor
  BulletPoint(String _txt) {
    
    // store the values passed to the constructor in a suitable variable
    txt = _txt;
    
    // Get the number of chars within the string
    float textLength = txt.length();
    // if the number of chars is greater than char1 but less than char2
    // set the line number to '2'
    if (textLength > char1 && textLength < char2) lines = 2;
    // if the number of chars is greater than char2 
    else if (textLength > char2) lines = 3;
    // Keep in mind that this only support 3 lines    
  }
  
  // Call to display the bullet point at a given position and size
  public void display(float x, float y, PVector size) {
    
    // set the text color
    fill(txtColor);
    
    // set the text size
    textSize(txtSize);
    
    // set the text font
    textFont(font2);
    
    // set the text alignment
    textAlign(align);   
    
    // draw the text
    text(txt, x, y-pointOffset.y, size.x/1.4, size.y);
    
    // remove stroke on the next processing shape
    noStroke();
    
    // draw a cicle to the screen
    circle(x-pointOffset.x, y, pointRadius);    
  }
}
