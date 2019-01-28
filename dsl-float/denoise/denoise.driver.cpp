#include "../common/common.hpp"
#include "../common/timer.hpp"
#include <cassert>
#include <cstdio>

extern "C" void host_code (float *, float *, float, float, float, int, int, int);
extern "C" void denoise3d_gold (float *, float *, int);

int main(int argc, char** argv) {
  int N = 512;

  float (*u0)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*f)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*u1)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  memcpy (u1, u0, sizeof(float)*N*N*N);

  float sigma2, gamma, r;
  denoise3d_gold((float*)u0, (float*)f, N);
  sigma2 = 0.05f*0.05f;
  gamma = 0.065f/sigma2;
  host_code ((float*)u1, (float*)f, gamma, r, sigma2, N, N, N);

  double error = checkError3D<float> (N, N, (float*)u0, (float*)u1, 8, N-8, 8, N-8, 8, N-8);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] u0;
  delete[] u1;
  delete[] f;
}
