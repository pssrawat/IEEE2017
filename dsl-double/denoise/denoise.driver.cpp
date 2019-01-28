#include "../common/common.hpp"
#include "../common/timer.hpp"
#include <cassert>
#include <cstdio>

extern "C" void host_code (double *, double *, double, double, double, int, int, int);
extern "C" void denoise3d_gold (double *, double *, int);

int main(int argc, char** argv) {
  int N = 512;

  double (*u0)[N][N] = (double (*)[N][N]) getRandom3DArray<double>(N, N, N);
  double (*f)[N][N] = (double (*)[N][N]) getRandom3DArray<double>(N, N, N);
  double (*u1)[N][N] = (double (*)[N][N]) getZero3DArray<double>(N, N, N);
  memcpy (u1, u0, sizeof(double)*N*N*N);

  double sigma2, gamma, r;
  denoise3d_gold((double*)u0, (double*)f, N);
  sigma2 = 0.05f*0.05f;
  gamma = 0.065f/sigma2;
  host_code ((double*)u1, (double*)f, gamma, r, sigma2, N, N, N);

  double error = checkError3D<double> (N, N, (double*)u0, (double*)u1, 8, N-8, 8, N-8, 8, N-8);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] u0;
  delete[] u1;
  delete[] f;
}
