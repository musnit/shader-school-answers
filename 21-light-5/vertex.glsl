precision mediump float;

#pragma glslify: PointLight = require(./light.glsl)

attribute vec3 position;
attribute vec3 normal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 ambient;

uniform PointLight lights[4];

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
  vec3 viewPosition,
  vec3 viewNormal,
  vec3 eyeDirection
) {
  vec3 light = vec3(0);
  for(int i=0; i<4;i++){
    vec3 viewLightPosition = vec3(view * vec4(lights[i].position, 1));
    vec3 lightDirection = lightDirection(viewLightPosition, viewPosition);
    float lambert = lambertWeight(viewNormal, lightDirection);
    float phong = phongWeight(lightDirection, viewNormal, eyeDirection, lights[i].shininess);
    light += lights[i].diffuse * lambert + lights[i].specular * phong;
  }
  return ambient + light;
}

vec3 toViewSpace(vec3 normal) {
  return vec3(vec4(normal, 0)*inverseModel*inverseView);
}

void main() {
  vec3 viewPosition = vec3(view * model * vec4(position, 1));
  vec3 viewNormal = toViewSpace(normal);
  vec3 eyeDirection = normalize(viewPosition);

  fragColor = reflectedLight(viewPosition, viewNormal, eyeDirection);
  gl_Position = projection*vec4(viewPosition, 1);
}
