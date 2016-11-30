precision mediump float;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 diffuse;
uniform vec3 lightDirection;
uniform float numBands;

varying vec3 worldNormal;

vec3 reflectedLight(
  vec3 normal,
  vec3 lightDirection,
  vec3 diffuse
) {
  float brightnessLevel = dot(normal, lightDirection);
  float brightness = max(brightnessLevel, 0.0);
  brightness = ceil(brightness * numBands) / numBands;
  return diffuse * brightness;
}

void main() {
  vec3 fragColor = reflectedLight(worldNormal, lightDirection, diffuse);
  gl_FragColor = vec4(fragColor,1);
}
