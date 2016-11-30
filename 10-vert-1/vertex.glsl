precision highp float;

uniform float theta;

attribute vec2 position;

void main() {

  //TODO: rotate position by theta radians about the origin
  mat2 rotation = mat2(cos(-theta), sin(-theta), -sin(-theta), cos(-theta));

  vec2 newPosition = position * rotation;
  gl_Position = vec4(newPosition.xy, 0, 1.0);
}
