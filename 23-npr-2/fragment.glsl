precision mediump float;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 warm;
uniform vec3 cool;
uniform vec3 lightDirection;

varying vec3 worldNormal;

float goochWeight(vec3 normal, vec3 lightDirection) {
  return 0.5 * (1.0 + dot(normal, lightDirection));
}

vec3 goochColor(vec3 cool, vec3 warm, float weight) {
  return (1.0 - weight) * cool + weight * warm;
}

vec3 reflectedLight(
  vec3 normal,
  vec3 lightDirection,
) {
  float goochWeight = goochWeight(normal, lightDirection);
  vec3 goochColor = goochColor(cool, warm, goochWeight);
  return goochColor;
}

void main() {
  vec3 fragColor = reflectedLight(worldNormal, lightDirection);
  gl_FragColor = vec4(fragColor,1);
}
