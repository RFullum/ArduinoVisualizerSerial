/*
*  Creates an object that grows, shrinks, moves, and colors
*  circles depending on incoming serial values from ArduinoVisualizerSerial
*  sketch.
*
*  Robert Fullum. August 2020
*/


public class CircleGrow
{
  // Starts circles at center of screen with no size
  float centerHeight = height / 2.0f;
  float centerWidth = width / 2.0f;
  float circleSize = 0.0f;
  
  // Distance of screen from top left to bottom right
  float crossScreenLength = int(sqrt((width * width) + (height * height)));
  
  // Variables to grow or shrink circles
  boolean grow = true;
  float growMult = 1.5f;      // Change grow speed
  float shrinkMult = 1.0f;    // Change shrink speed
  float randomRange = 20.0f;  // For moving circle center +/- range value
  
  // Constructor
  CircleGrow()
  {
    fill(0);
    circle(centerWidth, centerHeight, 0.0f);
  }
  
  
  /// Updates Circle: colorVal, growthVal
  void circleUpdate(float colorVal, float growthVal)
  {
    // Grows until circle's size reaches the screen's corners
    // Then shrinks until circle's size is less than 1.0f
    if (circleSize > crossScreenLength)
    {
      grow = false;
    }
    
    if (circleSize < 1.0f)
    {
      grow = true;
    }
    
    if (grow)
    {
      growCircle(colorVal, growthVal);
    }
    else
    {
      shrinkCircle(colorVal, growthVal);
    }
  }
  
  // Called when circle is growing. 
  // Grows by Arduino/Mic value times grow multiplier
  // Static circle center
  void growCircle(float fillColor, float growAmt)
  {
    circleSize += growAmt * growMult;
    fill(fillColor);
    circle(centerWidth, centerHeight, circleSize);
  }
  
  // Called when circle is shrinking
  // Shrinks by Arduino/Mic value times shrink multiplier
  // Moves center randomly, bound by edges
  void shrinkCircle(float fillColor, float growAmt)
  {
    circleSize -= growAmt * shrinkMult;
    
    centerWidth += random(-randomRange, randomRange);
    if (centerWidth < 0.0f)
    {
      centerWidth -= centerWidth;
    }
    if (centerWidth > width)
    {
      centerWidth = centerWidth - width;
    }
    
    centerHeight += random(-randomRange,randomRange);
    if (centerHeight < 0.0f)
    {
      centerHeight -= centerHeight;
    }
    if (centerHeight > height)
    {
      centerHeight = centerHeight - height;
    }
    
    fill(fillColor);
    circle(centerWidth, centerHeight, circleSize);
  }
}
