precision mediump float;

attribute vec3 position, normal;
uniform mat4 model, view, projection;
uniform mat4 inverseModel, inverseView, inverseProjection;
uniform vec3 ambient, diffuse, specular, lightDirection;
uniform float shininess;
varying vec3 fragColor;

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
  vec3 eyeDirection = normalize(vec3(view*model*vec4(position, 1)));
  fragColor = reflectedLight(viewNormal, lightDirection, ambient, diffuse, eyeDirection, shininess);
  gl_Position = projection*view*model*vec4(position, 1);
}
