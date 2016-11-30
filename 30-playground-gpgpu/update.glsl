precision mediump float;

uniform sampler2D state;       //State buffer
uniform vec2 screenSize;          //Size of screen buffer
uniform vec2 mousePosition;       //Position of mouse
uniform bvec3 mouseDown;        //Test if mouse left, right, middle is down

void main() {
  vec3 paintColor = vec3(0,0,0);

  //Paint colors depending on mouse state
  float w = exp2(-0.1 * (mousePosition.x/screenSize.x) * distance(gl_FragCoord.xy, mousePosition.xy));
  if(mouseDown.x) {
    paintColor.r = w;
  }
  if(mouseDown.y) {
    paintColor.g = w;
  }
  if(mouseDown.z) {
    paintColor.b = w;
  }

  //Write out texture
  vec2 texCoord = gl_FragCoord.xy / screenSize;
  float clampMin = 0.0;
  float fadeSpeed = 0.01;
  if(gl_FragCoord.x / screenSize.x > 0.5) {
    clampMin = 0.01;
  }
  else {
    clampMin = 0.1;
  }
  vec4 col =  -clampMin + clamp(texture2D(state, texCoord) - (texture2D(state, texCoord)*fadeSpeed), clampMin, 100.0) + vec4(paintColor, 0.0);
  if(!mouseDown.x){
    col = vec4(0);
  }
  gl_FragColor = col;
}
