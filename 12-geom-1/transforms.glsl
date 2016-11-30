precision highp float;

attribute vec3 position;

uniform mat4 model, view, projection;

vec4 transformPoint(mat4 transform, vec4 point) {
  return transform * point;
}

void main() {

  //TODO: Apply the model-view-projection matrix to `position`

  gl_Position = transformPoint(projection*view*model, vec4(position, 1));
}
