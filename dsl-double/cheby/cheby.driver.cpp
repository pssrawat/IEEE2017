#include "../common/common.hpp"
#include "../common/timer.hpp"
#include <cassert>
#include <cstdio>
#define EIGENVALUE 2.175

extern "C" void host_code(double*, double*, double*, double*, double*, double*, double*, double, int, int, int);
extern "C" void cheby3d_gold(double*, double*, double*, double*, double*, double*, double*, int, double);

void randomArrayFill (int length, double *array, double max) {
  for (int j=0; j<length; j++) {
    array[j] = -max + 2 * max * ( (double)rand() / (double)RAND_MAX);
  }
}

int main(int argc, char** argv) {
  int N = 322;
  double h2inv = 0.0025; 
  double beta  = 1.0*EIGENVALUE;
  double alpha = 0.125*beta;
  double theta = 0.5*(beta+alpha);
  double delta = 0.5*(beta-alpha);
  double sigma = theta/delta;
  double rho_n = 1/sigma;
  double chebyshev_c1[4], chebyshev_c2[4];
  chebyshev_c1[0] = 0.0;
  chebyshev_c2[0] = 1/theta;
  for(int t=1; t<4; t++) {
    rho_n = 1.0/(2.0*sigma - rho_n);
    chebyshev_c1[t] = rho_n*rho_n;
    chebyshev_c2[t] = rho_n*2.0/delta;
  }
  double (*output)[N][N] = (double (*)[N][N]) getZero3DArray<double>(N, N, N);
  double (*output_gold)[N][N] = (double (*)[N][N]) getZero3DArray<double>(N, N, N);
  double (*Ac)[N][N] = (double (*)[N][N]) getRandom3DArray<double>(N, N, N);
  double (*Ap)[N][N] = (double (*)[N][N]) getRandom3DArray<double>(N, N, N);
  double (*RHS)[N][N] = (double (*)[N][N]) getRandom3DArray<double>(N, N, N);
  double (*Dinv)[N][N] = (double (*)[N][N]) getRandom3DArray<double>(N, N, N);

  cheby3d_gold ((double*)Ac, (double*)Ap, (double*)output_gold, (double*)RHS, (double*)Dinv, chebyshev_c1, chebyshev_c2, N, h2inv);
  host_code    ((double*)Ac, (double*)Ap, (double*)Dinv, (double*)RHS, (double*)output, chebyshev_c1, chebyshev_c2, h2inv, N, N, N);
  double error = checkError3D<double> (N, N, (double*)output, (double*) output_gold, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
     return -1;
}
