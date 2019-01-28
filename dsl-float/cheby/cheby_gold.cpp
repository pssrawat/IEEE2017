#include "../common/common.hpp"

static void cheby3d_step (float* Ac_def, float* Ap_def, float* l_output, float* RHS_def, float* Dinv_def, float c1, float c2, int N, float h2inv) {
  float (*Ap)[N][N] = (float (*)[N][N])Ap_def;
  float (*Ac)[N][N] = (float (*)[N][N])Ac_def;
  float (*output)[N][N] = (float (*)[N][N])l_output;
  float (*RHS)[N][N] = (float (*)[N][N])RHS_def;
  float (*Dinv)[N][N] = (float (*)[N][N])Dinv_def;
  int i, j, k;
  for (k = 1; k < N-1; k++) {
    for (j = 1; j < N-1; j++) {
      for (i = 1; i < N-1; i++) {
        float MA = Ac[k][j][i] - h2inv * (0.03f * (Ac[k-1][j-1][i-1] + Ac[k-1][j-1][i+1] + Ac[k-1][j+1][i-1] + Ac[k-1][j+1][i+1] + Ac[k+1][j-1][i-1] + Ac[k+1][j-1][i+1] + Ac[k+1][j+1][i-1] + Ac[k+1][j+1][i+1]) + 0.1f * (Ac[k-1][j-1][i] + Ac[k-1][j][i-1] + Ac[k-1][j][i+1] + Ac[k-1][j+1][i] + Ac[k][j-1][i-1] + Ac[k][j-1][i+1] + Ac[k][j+1][i-1] + Ac[k][j+1][i+1] + Ac[k+1][j-1][i] + Ac[k+1][j][i-1] + Ac[k+1][j][i+1] + Ac[k+1][j+1][i]) + 0.46f * (Ac[k-1][j][i] + Ac[k][j-1][i] + Ac[k][j][i-1] + Ac[k][j][i+1] + Ac[k][j+1][i] + Ac[k+1][j][i]) - 4.26f * Ac[k][j][i]);
	output[k][j][i] = Ac[k][j][i] + c1 * (Ac[k][j][i] - Ap[k][j][i]) + c2 * Dinv[k][j][i] * (RHS[k][j][i] - MA);
      }
    }
  }
}

extern "C" void cheby3d_gold (float* Ac_def, float* Ap_def, float* l_output, float* RHS_def, float* Dinv_def, float* c1, float* c2, int N, float h2inv) {
  float* temp1 = getZero3DArray<float>(N, N, N);
  float* temp2 = getZero3DArray<float>(N, N, N);
  float* temp3 = getZero3DArray<float>(N, N, N);
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
