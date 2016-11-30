vec3 reflectPoint(vec3 p, vec3 n) {
  return p - 2.0 * dot(n, p) * n / dot(n, n);
}

highp mat4 reflection(highp vec3 n) {

  //TODO: Return a matrix that reflects all points about the plane passing through the origin with normal n
  float nn = dot(n, n);
  float Q = -2.0/nn;

  float nxx = n.x * n.x;
  float nxy = n.x * n.y;
  float nxz = n.x * n.z;
  float nyx = n.y * n.x;
  float nyy = n.y * n.y;
  float nyz = n.y * n.z;
  float nzx = n.z * n.x;
  float nzy = n.z * n.y;
  float nzz = n.z * n.z;

  mat4 matrix = mat4(1.0 + Q*nxx, Q*nxy, Q*nxz, 0,
                     Q*nyx, 1.0 + Q*nyy, Q*nyz, 0,
                     Q*nzx, Q*nzy, 1.0 + Q*nzz, 0,
                     0, 0, 0, 1);

   mat4 colMatrix = mat4(1.0 + Q*nxx, Q*nyx, Q*nzx, 0,
                         Q*nxy, 1.0 + Q*nyy, Q*nzy, 0,
                         Q*nxz, Q*nyz, 1.0 + Q*nzz, 0,
                         0, 0, 0, 1);

  return colMatrix;
}

#pragma glslify: export(reflection)
