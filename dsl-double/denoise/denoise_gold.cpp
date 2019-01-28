#include "../common/common.hpp"
#define epsilon (1.0E-20f)


static void denoise3d_step (double* h_u0, double *h_u, double *h_f, double *h_g, int N) {
  double (*u)[N][N] = (double (*)[N][N])h_u;
  double (*u0)[N][N] = (double (*)[N][N])h_u0;
  double (*f)[N][N] = (double (*)[N][N])h_f;
  double (*g)[N][N] = (double (*)[N][N])h_g;
  double sigma2 = 0.05f*0.05f;
  double gamma = 0.065f/sigma2;

  for (int i = 1; i < N-1; i++)
    for (int j = 1; j < N-1; j++)
      for (int k = 1; k < N-1; k++) {
          g[i][j][k] = 1.0f/sqrt (epsilon + (u0[i][j][k] - u0[i][j+1][k])*(u0[i][j][k] - u0[i][j+1][k]) + (u0[i][j][k] - u0[i][j-1][k])*(u0[i][j][k] - u0[i][j-1][k]) + (u0[i][j][k] - u0[i][j][k+1])*(u0[i][j][k] - u0[i][j][k+1]) + (u0[i][j][k] - u0[i][j][k-1])*(u0[i][j][k] - u0[i][j][k-1]) + (u0[i][j][k] - u0[i+1][j][k])*(u0[i][j][k] - u0[i+1][j][k]) + (u0[i][j][k] - u0[i-1][j][k])*(u0[i][j][k] - u0[i-1][j][k]));
      }

  for (int i = 1; i < N-1; i++) 
    for (int j = 1; j < N-1; j++)
      for (int k = 1; k < N-1; k++) {
          double r = u0[i][j][k]*f[i][j][k]/sigma2;
          r = (r*(2.38944f + r*(0.950037f + r))) / (4.65314f + r*(2.57541f + r*(1.48937f + r)));
          /* Update U */
          u[i][j][k] = (u0[i][j][k] + 5.0f*(u0[i][j+1][k]*g[i][j+1][k] + u0[i][j-1][k]*g[i][j-1][k] + u0[i][j][k+1]*g[i][j][k+1] + u0[i][j][k-1]*g[i][j][k-1] + u0[i+1][j][k]*g[i+1][j][k] + u0[i-1][j][k]*g[i-1][j][k] + gamma*f[i][j][k]*r)) / (1.0f + 5.0f*(g[i][j+1][k] + g[i][j-1][k] + g[i][j][k+1] + g[i][j][k-1] + g[i+1][j][k] + g[i-1][j][k] + gamma));
     }
}


extern "C" void denoise3d_gold (double *u0, double *f, int N) {
  double* g = getZero3DArray<double>(N, N, N);
  double* u = getZero3DArray<double>(N, N, N);
  memcpy (u, u0, sizeof(double)*N*N*N);
  denoise3d_step(u0, u, f, g, N);
  memset (g, 0, sizeof(double)*N*N*N);
  denoise3d_step(u, u0, f, g, N);
  memset (g, 0, sizeof(double)*N*N*N);
  denoise3d_step(u0, u, f, g, N);
  memset (g, 0, sizeof(double)*N*N*N);
  denoise3d_step(u, u0, f, g, N);
  delete[] u;
  delete[] g;
}
