#include "../common/common.hpp"

static void cheby3d_step (double* Ac_def, double* Ap_def, double* l_output, double* RHS_def, double* Dinv_def, double c1, double c2, int N, double h2inv) {
  double (*Ap)[N][N] = (double (*)[N][N])Ap_def;
  double (*Ac)[N][N] = (double (*)[N][N])Ac_def;
  double (*output)[N][N] = (double (*)[N][N])l_output;
  double (*RHS)[N][N] = (double (*)[N][N])RHS_def;
  double (*Dinv)[N][N] = (double (*)[N][N])Dinv_def;
  int i, j, k;
  for (k = 1; k < N-1; k++) {
    for (j = 1; j < N-1; j++) {
      for (i = 1; i < N-1; i++) {
        double MA = Ac[k][j][i] - h2inv * (0.03f * (Ac[k-1][j-1][i-1] + Ac[k-1][j-1][i+1] + Ac[k-1][j+1][i-1] + Ac[k-1][j+1][i+1] + Ac[k+1][j-1][i-1] + Ac[k+1][j-1][i+1] + Ac[k+1][j+1][i-1] + Ac[k+1][j+1][i+1]) + 0.1f * (Ac[k-1][j-1][i] + Ac[k-1][j][i-1] + Ac[k-1][j][i+1] + Ac[k-1][j+1][i] + Ac[k][j-1][i-1] + Ac[k][j-1][i+1] + Ac[k][j+1][i-1] + Ac[k][j+1][i+1] + Ac[k+1][j-1][i] + Ac[k+1][j][i-1] + Ac[k+1][j][i+1] + Ac[k+1][j+1][i]) + 0.46f * (Ac[k-1][j][i] + Ac[k][j-1][i] + Ac[k][j][i-1] + Ac[k][j][i+1] + Ac[k][j+1][i] + Ac[k+1][j][i]) - 4.26f * Ac[k][j][i]);
	output[k][j][i] = Ac[k][j][i] + c1 * (Ac[k][j][i] - Ap[k][j][i]) + c2 * Dinv[k][j][i] * (RHS[k][j][i] - MA);
      }
    }
  }
}

extern "C" void cheby3d_gold (double* Ac_def, double* Ap_def, double* l_output, double* RHS_def, double* Dinv_def, double* c1, double* c2, int N, double h2inv) {
  double* temp1 = getZero3DArray<double>(N, N, N);
  double* temp2 = getZero3DArray<double>(N, N, N);
  double* temp3 = getZero3DArray<double>(N, N, N);
  for (int i=0; i<N*N*N; i++) {
    temp1[i] = temp2[i] = temp3[i] = Ac_def[i];
  }
  cheby3d_step(Ac_def, Ap_def, temp1, RHS_def, Dinv_def, c1[0], c2[0], N, h2inv);
  cheby3d_step(temp1, Ac_def, temp2, RHS_def, Dinv_def, c1[1], c2[1], N, h2inv);
  cheby3d_step(temp2, temp1, temp3, RHS_def, Dinv_def, c1[2], c2[2], N, h2inv);
  cheby3d_step(temp3, temp2, l_output, RHS_def, Dinv_def, c1[3], c2[3], N, h2inv); 
  delete[] temp1;
  delete[] temp2;
  delete[] temp3;
}
