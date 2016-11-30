precision highp float;

uniform sampler2D prevState;
uniform vec2 stateSize;

float state(vec2 coord) {
  return texture2D(prevState, fract(coord / stateSize)).r;
}

void main() {
  vec2 coord = gl_FragCoord.xy;

  float oldState = state(coord);

  float neighbors = -oldState;
  vec2 topLeft = vec2(coord.x-1.0, coord.y+1.0);
  for (float i = -1.0; i <= 1.0; i += 1.0 ) {
    for (float j = -1.0; j <= 1.0; j += 1.0 ) {
      float x = mod(coord.x + i, stateSize.x);
      float y = mod(coord.y + j, stateSize.y);
      neighbors += state(vec2(x, y));
    }
  }

  float newState = 0.0;
  if (oldState == 0.0 && neighbors == 3.0){
    newState = 1.0;
  }
  if (oldState == 1.0 && (neighbors == 2.0 || neighbors == 3.0)){
    newState = 1.0;
  }

  gl_FragColor = vec4(newState, newState, newState, 1.0);
}
