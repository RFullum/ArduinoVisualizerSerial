/*
*  Audio Visualizer:
*  Takes values over serial port between 0.0f and 1.0f
*  Creates a number of circles. Amplitude grows or shrinks circles.
*  Amplitude controls monochrome color, alternating circles white-to-black,
*  or black-to-white. Amplitude moves circle centers during shrink phase.
*
*  Does not use sound card for audio. Needs digital input over serial connection.
*  I'm using Max4466 Analog Mic & Amp, into an ADS1115 Analog to Digital Converter,
*  into an Arduino Nano 33 IoT, over USB cable for the serial connection
*  
*  Robert Fullum. August, 2020
*/

import processing.serial.*;

// Serial variables
Serial myPort;
String inString = "";

// Circle Variables
CircleGrow[] circles;
int numCircles = 8;    // Change to desired number of circles (init = 8)

// Control Values
int beatCounter = 0;
int beatModulo = 16;           // Change to control how often new circles are added (initial = 16)
float beatThreshold = 0.5f;    // Change to desired sensitivity of amplitude 0.0f to 1.0f (initial = 0.5f)
int elapsed = 0;

// Mic amplitude from arduino (0.0f to 1.0f)
float arduinoVal = 0.0f;



void setup()
{
  fullScreen();
  
  // Show serial ports
  printArray(Serial.list());
  
  // Set up Serial ports
  String portName = Serial.list()[4];  // Change the index to the Arduino's port
  myPort = new Serial(this, portName, 9600);
  
  // Show selected port names
  println("");
  println(portName);
  println(myPort);
  
  
  // Circles Setup
  circles = new CircleGrow[numCircles];
  
  for (int i=0; i<numCircles; i++)
  {
    circles[i] = new CircleGrow();
  }
    
}


void draw()
{
  // Calls to Arduino
  myPort.write('1');
  myPort.write('0');
  
  // Get from Arduino
  int lf = 10;                    // ASCII end-of-line from Arduino Serial.println is 10
  
  // While serial port is available, read serial data until end-of-line
  while (myPort.available() > 0)
  {
    inString = myPort.readStringUntil(lf);
  }
  
  // Amplitude
  arduinoVal = float(inString);
  
  // Set color values
  float blackUp = arduinoVal * 255;
  float whiteDown = 255 - (arduinoVal * 255);
  
  background(blackUp);
  
  // Track beats and update elapsed, adding circles per elapsed, maxed to numCircles
  if (arduinoVal > beatThreshold)
  {
    beatCounter++;
    if (beatCounter % beatModulo == 0)
    {
      if (elapsed < numCircles)
      {
        elapsed++;
        if (elapsed > numCircles)
        {
          elapsed = numCircles;
        }
      }
    }
  }
  
  // Draw num circles up to elapsed
  for (int i=0; i<elapsed; i++)
  {
    if (i % 2 == 0)
    {
      circles[i].circleUpdate( whiteDown, arduinoVal * (float(numCircles - i) * 4) );
    }
    else
    {
      circles[i].circleUpdate( blackUp, arduinoVal * (float(numCircles - i) * 4) );
    }
  }
}
