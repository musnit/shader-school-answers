precision mediump float;

attribute vec3 position;
attribute vec3 normal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;
uniform vec3 ambient, diffuse, specular;
uniform float shininess;

uniform vec3 lightPosition;

varying vec3 fragColor;

vec3 lightDirection(vec3 lightPosition, vec3 surfacePosition){
  return normalize(lightPosition - surfacePosition);
}

float phongWeight(
  vec3 lightDirection,
  vec3 surfaceNormal,
  vec3 eyeDirection,
  float shininess
) {
  //First reflect light by surface normal
  vec3 rlight = reflect(lightDirection, surfaceNormal);

  //Next find the projected length of the reflected
  //light vector in the view direction
  float eyeLight = max(dot(rlight, eyeDirection), 0.0);

  //Finally exponentiate by the shininess factor
  return pow(eyeLight, shininess);
}

float lambertWeight(vec3 normal, vec3 lightDirection) {
  float brightness = dot(normal, lightDirection);
  return max(brightness, 0.0);
}

vec3 reflectedLight(
  vec3 normal,
  vec3 lightDirection,
  vec3 ambient,
  vec3 diffuse,
  vec3 eyeDirection,
  float shininess
) {
  float lambert = lambertWeight(normal, lightDirection);
  float phong = phongWeight(lightDirection, normal, eyeDirection, shininess);
  return ambient + diffuse * lambert + specular * phong;
}

vec3 toViewSpace(vec3 normal) {
  return vec3(vec4(normal, 0)*inverseModel*inverseView);
}

void main() {
  vec3 viewNormal = toViewSpace(normal);
  vec3 viewPosition = vec3(view * model * vec4(position, 1));
  vec3 eyeDirection = normalize(viewPosition);
  vec3 viewLightPosition = vec3(view * vec4(lightPosition, 1));

  vec3 lightDirection = lightDirection(viewLightPosition, viewPosition);
  fragColor = reflectedLight(viewNormal, lightDirection, ambient, diffuse, eyeDirection, shininess);
  gl_Position = projection*vec4(viewPosition, 1);
}
