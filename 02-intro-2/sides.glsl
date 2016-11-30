precision highp float;

void sideLengths(
  float hypotenuse,
  float angleInDegrees,
  out float opposite,
  out float adjacent) {

  const float PI = 3.14159265359;

  //a = csin(theta)
  //b = ccos(theta)
  //TODO: Calculate side lengths here
  opposite = hypotenuse * sin(radians(angleInDegrees));
  adjacent = hypotenuse * cos(radians(angleInDegrees));
}

//Do not change this line
#pragma glslify: export(sideLengths)
