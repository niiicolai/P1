public class TextBox {
  public TextPoint[] textPoints;
  
  private PVector position;
  private PVector size;

  private float txtSize = 40;
  private color boxFillColor = #096192;
  private color boxStrokeColor = #096192; 
  
  private int align;
  
  //private float textPadding = 30;
  private float textIndent = 50;
  private float topPadding = 50;
  private float lineHeight = 50;
  private float spaceBetween = 60;
  private float cornerRadius = 5;
  
  // The title's constructor
  TextBox(String[] _text, PVector _position, PVector _size, int _align) {
    textPoints = new TextPoint[_text.length];
    for (int i = 0; i < _text.length; i++) {
      textPoints[i] = new TextPoint(_text[i]);
    }
    position = new PVector(_position.x, _position.y);
    size = new PVector(_size.x, _size.y);
    align = _align;
  }
  
  public void display(Scene scene) {
    fill(boxFillColor);
    stroke(boxStrokeColor);
    rect(scene.position.x+position.x, scene.position.y+position.y, size.x, size.y, cornerRadius);

    textSize(txtSize);
    textFont(font2);
    textAlign(align);     
    
    float lastY = scene.position.y+position.y+topPadding;
    float xPos = scene.position.x+position.x+textIndent;
    for (int i = 0; i < textPoints.length; i++) {    
      if (i > 0) lastY += lineHeight*textPoints[i-1].lines;
      if (i > 0) lastY += spaceBetween;

      textPoints[i].display(xPos, lastY, size); 
    }
        
    //text(txt, scene.position.x+position.x+(textPadding/2), scene.position.y+position.y+(textPadding/2), size.x-textPadding, size.y);
  }
}

public class TextPoint {
  
  color txtColor = color (255);
  String txt;
  
  float pointRadius = 13;
  PVector pointOffset = new PVector(25, 18);
  
  int lines = 1;
  
  TextPoint(String _txt) {
    txt = _txt;
    
    float textLength = txt.length();
    if (textLength > 140 && textLength < 260) lines = 2;
    else if (textLength > 260) lines = 3;
    
  }
  
  public void display(float x, float y, PVector size) {

    fill(txtColor);
    text(txt, x, y-pointOffset.y, size.x/1.4, size.y);
    
    noStroke();
    circle(x-pointOffset.x, y, pointRadius);    
  }
}
