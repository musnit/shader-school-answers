precision mediump float;

uniform sampler2D prevState[2];
uniform vec2 stateSize;
uniform float kdiffuse;
uniform float kdamping;

float state0(vec2 v) {
  return texture2D(prevState[0], fract(v / stateSize)).r;
}

float state0(float x, float y) {
  vec2 v = vec2(x, y);
  return texture2D(prevState[0], fract(v / stateSize)).r;
}

float state1(vec2 v) {
  return texture2D(prevState[1], fract(v / stateSize)).r;
}

float state1(float x, float y) {
  vec2 v = vec2(x, y);
  return texture2D(prevState[1], fract(v / stateSize)).r;
}

float laplace0(float x, float y) {
  return (
    state0(x-1.0,y) +
    state0(x+1.0,y) +
    state0(x,y-1.0) +
    state0(x,y+1.0)
  ) - 4.0 * state0(x,y);
}


float nextState(float x, float y) {
  return (1.0 - kdamping) * (
    kdiffuse * laplace0(x, y) +
    2.0 * state0(x,y)
  ) - state1(x,y);
}

void main() {
  vec2 coord = gl_FragCoord.xy;

  float nextState = nextState(coord.x, coord.y);

  gl_FragColor = vec4(nextState, nextState, nextState,1);
}
