precision highp float;

varying vec3 fragColor;
varying float fragPointSize;

void main() {
  vec4 color = vec4(fragColor, 1);

  float x = gl_PointCoord.x - 0.5;
  float y = gl_PointCoord.y - 0.5;
  if (x * x + y * y < 0.25) {
    gl_FragColor = color;
  }
  else {
    discard;
  }
}
