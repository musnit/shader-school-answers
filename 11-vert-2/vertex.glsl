precision highp float;

attribute vec4 position;
attribute vec3 color;

//Declare a varying variable called fragPosition
varying vec3 fragColor;


void main() {
  gl_Position = position;

  //Set fragPosition variable for the
  //fragment shader output
  fragColor = color;
}
