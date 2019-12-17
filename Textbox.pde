// Used to define a textbox that can should x amount of bullet points
public class TextBox {
  
  // The textbox's bulletpoints
  public BulletPoint[] bulletPoints;
  
  // The position of the textbox
  private PVector position;
  
  // The size of the textbox
  private PVector size;

  // The textbox's fill color
  private color boxFillColor = #096192;
  
  // The textbox's stroke's fill color
  private color boxStrokeColor = #096192; 
  
  // The amount of space between the left side of the text box
  // and the bullet points
  private float textIndent = 50;
  
  // The amount of space between the top and the first bullet point
  private float topPadding = 50;
  
  // The amount of space between each line with text
  private float lineHeight = 50;
  
  // The amount of space between each bullet pint
  private float spaceBetween = 60;
  
  // The amount the corner of the textbox should be 'rounded'
  private float cornerRadius = 5;
  
  // The textbox's constructor
  TextBox(String[] _text, PVector _position, PVector _size) {
    
    // create a new instance of an array of bullet points with the length of the given string array
    bulletPoints = new BulletPoint[_text.length];
    
    // loop through all the text objects and create a bullet point object for each
    for (int i = 0; i < _text.length; i++) {
      bulletPoints[i] = new BulletPoint(_text[i]);
    }
    
    // store the values passed to the constructor in a suitable variable
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
  }
  
  // Call to display the text box and the bulletpoints within
  public void display(Scene scene) {
    
    // Set the textbox's fill color
    fill(boxFillColor);
    
    // set the textbox's stroke color
    stroke(boxStrokeColor);
    
    // draw a rect relative to scene with a size and rounded corners
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y, cornerRadius);  
    
    // Find the first y position of the first bullet point
    float lastY = scene.position.y+position.y+topPadding;
    // Find the x position of the all the bullet points
    float xPos = scene.position.x+position.x+textIndent;
    // loop through all bullet points
    for (int i = 0; i < bulletPoints.length; i++) {    
      // if the current bullet point isn't the first bullet point
      if (i > 0) {
        // calculate a new y position based on the amount of lines the last bullet point had
        lastY += lineHeight*bulletPoints[i-1].lines;
        // and add the standard space between bulelt points
        lastY += spaceBetween;
      }
      
      // draw the bullet point to the screen
      bulletPoints[i].display(xPos, lastY, size); 
    }
  }
}

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
