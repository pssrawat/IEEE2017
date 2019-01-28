#include "../common/common.hpp"
#define epsilon (1.0E-20f)


static void denoise3d_step (float* h_u0, float *h_u, float *h_f, float *h_g, int N) {
  float (*u)[N][N] = (float (*)[N][N])h_u;
  float (*u0)[N][N] = (float (*)[N][N])h_u0;
  float (*f)[N][N] = (float (*)[N][N])h_f;
  float (*g)[N][N] = (float (*)[N][N])h_g;
  float sigma2 = 0.05f*0.05f;
  float gamma = 0.065f/sigma2;

  for (int i = 1; i < N-1; i++)
    for (int j = 1; j < N-1; j++)
      for (int k = 1; k < N-1; k++) {
          g[i][j][k] = 1.0f/sqrt (epsilon + (u0[i][j][k] - u0[i][j+1][k])*(u0[i][j][k] - u0[i][j+1][k]) + (u0[i][j][k] - u0[i][j-1][k])*(u0[i][j][k] - u0[i][j-1][k]) + (u0[i][j][k] - u0[i][j][k+1])*(u0[i][j][k] - u0[i][j][k+1]) + (u0[i][j][k] - u0[i][j][k-1])*(u0[i][j][k] - u0[i][j][k-1]) + (u0[i][j][k] - u0[i+1][j][k])*(u0[i][j][k] - u0[i+1][j][k]) + (u0[i][j][k] - u0[i-1][j][k])*(u0[i][j][k] - u0[i-1][j][k]));
      }

  for (int i = 1; i < N-1; i++) 
    for (int j = 1; j < N-1; j++)
      for (int k = 1; k < N-1; k++) {
          float r = u0[i][j][k]*f[i][j][k]/sigma2;
          r = (r*(2.38944f + r*(0.950037f + r))) / (4.65314f + r*(2.57541f + r*(1.48937f + r)));
          /* Update U */
          u[i][j][k] = (u0[i][j][k] + 5.0f*(u0[i][j+1][k]*g[i][j+1][k] + u0[i][j-1][k]*g[i][j-1][k] + u0[i][j][k+1]*g[i][j][k+1] + u0[i][j][k-1]*g[i][j][k-1] + u0[i+1][j][k]*g[i+1][j][k] + u0[i-1][j][k]*g[i-1][j][k] + gamma*f[i][j][k]*r)) / (1.0f + 5.0f*(g[i][j+1][k] + g[i][j-1][k] + g[i][j][k+1] + g[i][j][k-1] + g[i+1][j][k] + g[i-1][j][k] + gamma));
     }
}


extern "C" void denoise3d_gold (float *u0, float *f, int N) {
  float* g = getZero3DArray<float>(N, N, N);
  float* u = getZero3DArray<float>(N, N, N);
  memcpy (u, u0, sizeof(float)*N*N*N);
  denoise3d_step(u0, u, f, g, N);
  memset (g, 0, sizeof(float)*N*N*N);
  denoise3d_step(u, u0, f, g, N);
  memset (g, 0, sizeof(float)*N*N*N);
  denoise3d_step(u0, u, f, g, N);
  memset (g, 0, sizeof(float)*N*N*N);
  denoise3d_step(u, u0, f, g, N);
  delete[] u;
  delete[] g;
}
