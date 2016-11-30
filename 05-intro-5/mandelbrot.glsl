highp vec2 mandelbrot(vec2 z, vec2 c) {
  return vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
}

bool mandelbrotConverges(vec2 z) {
  return length(z) < 2.0;
}

bool mandelbrot(highp vec2 c) {

  //Test if the point c is inside the mandelbrot set after 100 iterations
  vec2 z0 = vec2(0.0,0.0);        //No iterations
  vec2 z1 = mandelbrot(z0, c);    // 1 iteration
  vec2 z2 = mandelbrot(z1, c);    // 2 iterations

  for(int i=0; i<=100; ++i) {
    z0 = mandelbrot(z0, c);    // 1 iteration
  }

  return mandelbrotConverges(z0);
}

//Do not change this line or the name of the above function
#pragma glslify: export(mandelbrot)
