#include "../common/common.hpp"
#include "../common/timer.hpp"
#include <cassert>
#include <cstdio>
#define EIGENVALUE 2.175

extern "C" void host_code(float*, float*, float*, float*, float*, float*, float*, float, int, int, int);
extern "C" void cheby3d_gold(float*, float*, float*, float*, float*, float*, float*, int, float);

void randomArrayFill (int length, float *array, float max) {
  for (int j=0; j<length; j++) {
    array[j] = -max + 2 * max * ( (float)rand() / (float)RAND_MAX);
  }
}

int main(int argc, char** argv) {
  int N = 322;
  float h2inv = 0.0025; 
  float beta  = 1.0*EIGENVALUE;
  float alpha = 0.125*beta;
  float theta = 0.5*(beta+alpha);
  float delta = 0.5*(beta-alpha);
  float sigma = theta/delta;
  float rho_n = 1/sigma;
  float chebyshev_c1[4], chebyshev_c2[4];
  chebyshev_c1[0] = 0.0;
  chebyshev_c2[0] = 1/theta;
  for(int t=1; t<4; t++) {
    rho_n = 1.0/(2.0*sigma - rho_n);
    chebyshev_c1[t] = rho_n*rho_n;
    chebyshev_c2[t] = rho_n*2.0/delta;
  }
  float (*output)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*output_gold)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*Ac)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*Ap)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*RHS)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*Dinv)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);

  cheby3d_gold ((float*)Ac, (float*)Ap, (float*)output_gold, (float*)RHS, (float*)Dinv, chebyshev_c1, chebyshev_c2, N, h2inv);
  host_code    ((float*)Ac, (float*)Ap, (float*)Dinv, (float*)RHS, (float*)output, chebyshev_c1, chebyshev_c2, h2inv, N, N, N);
  double error = checkError3D<float> (N, N, (float*)output, (float*) output_gold, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
     return -1;
}
