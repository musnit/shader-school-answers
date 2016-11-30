precision highp float;
varying vec3 fragColor;

void main() {

  float r = fragColor.r;
  float b = fragColor.b;
  float g = fragColor.g;//1.0 - (r*50.0);
  float a = 1.0;
  gl_FragColor = vec4(r, g, b, a);
}
