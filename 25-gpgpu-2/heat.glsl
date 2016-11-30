precision mediump float;

uniform sampler2D prevState;
uniform vec2 stateSize;
uniform float kdiffuse;
uniform float kdamping;

float state(float x, float y) {
  vec2 v = vec2(x, y);
  return texture2D(prevState, fract(v / stateSize)).r;
}

float laplace(float x, float y) {
  return (
    state(x-1.0,y) +
    state(x+1.0,y) +
    state(x,y-1.0) +
    state(x,y+1.0)
  ) - 4.0 * state(x,y);
}

float nextState(vec2 coord){
  float x = coord.x;
  float y = coord.y;
  return (1.0 - kdamping) * (kdiffuse * laplace(x, y) + state(x, y));
}

void main() {
  vec2 coord = gl_FragCoord.xy;
  float newState = nextState(coord);
  gl_FragColor = vec4(newState, newState, newState,1);
}
