precision highp float;

#define CIRCLE_COLOR    vec4(1.0, 0.4313, 0.3411, 1.0)
#define OUTSIDE_COLOR   vec4(0.3804, 0.7647, 1.0, 1.0)

void main() {

  float x = gl_FragCoord.x - 256.0;
  float y = gl_FragCoord.y - 256.0;
  float mag = sqrt((x*x) + (y * y));

  if((mag) < 128.0) {
    gl_FragData[0] = CIRCLE_COLOR;
  } else {
    gl_FragData[0] = OUTSIDE_COLOR;
  }

}
