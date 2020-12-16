# ArduinoVisualizerSerial
Audio Visualizer using serial data as audio input

Audio Visualizer:
Takes values over serial port between 0.0f and 1.0f
Creates a number of circles. Amplitude grows or shrinks circles.
Amplitude controls monochrome color, alternating circles white-to-black,
or black-to-white. Amplitude moves circle centers during shrink phase.

Does not use sound card for audio. Needs digital input over serial connection.
I'm using Max4466 Analog Mic & Amp, into an ADS1115 Analog to Digital Converter,
into an Arduino Nano 33 IoT, over USB cable for the serial connection
  
Robert Fullum. August, 2020

Video of sketch in action:
https://youtu.be/kvn5ixX2CAo
