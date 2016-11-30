vec3 rotatePoint(vec3 p, vec3 n, float theta) {
  return (
    p * cos(theta) + cross(n, p) *
    sin(theta) + n * dot(p, n) *
    (1.0 - cos(theta))
  );
}

mat3 outerSquare(vec3 n) {
  float nxx = n.x * n.x;
  float nxy = n.x * n.y;
  float nxz = n.x * n.z;
  float nyy = n.y * n.y;
  float nyz = n.y * n.z;
  float nzz = n.z * n.z;

  return mat3(nxx, nxy, nxz,
              nxy, nyy, nyz,
              nxz, nyz, nzz);
}

highp mat4 rotation(highp vec3 n, highp float theta) {
  float c = cos(theta);
  float mc = (1.0 - cos(theta));
  mat3 cMatrix = c * mat3(1);

  float s = sin(theta);
  mat3 nMatrix = s*mat3(0, n.z, -n.y,
                      -n.z, 0, n.x,
                      n.y, -n.x, 0);

  return mat4(nMatrix + cMatrix + (outerSquare(n) * mc));
}

#pragma glslify: export(rotation)
