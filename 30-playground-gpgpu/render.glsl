precision mediump float;

uniform sampler2D state;        //State buffer
uniform vec2 screenSize;          //Size of screen buffer

void main() {
  gl_FragColor = vec4(texture2D(state, gl_FragCoord.xy / screenSize).rgb, 1.0);
}
