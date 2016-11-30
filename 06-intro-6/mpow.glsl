mat2 matrixPower(highp mat2 m, int n) {

  //Raise the matrix m to nth power

  // For example:
  //
  //  matrixPower(m, 2) = m * m
  //

  mat2 I = mat2(1.0);
  for(int i = 0; i < 16; ++i) {
    if(n == i){
      break;
    }
    I = I * m;    // 1 iteration
  }
  return I;
}

//Do not change this line or the name of the above function
#pragma glslify: export(matrixPower)
