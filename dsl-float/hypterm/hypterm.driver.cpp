#include "../common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void hypterm_gold (float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, int);
extern "C" void host_code (float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float, float, float, int, int, int);

int main(int argc, char** argv) {
  int N = 300;

  float (*cons_1)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*cons_2)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*cons_3)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*cons_4)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*q_1)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*q_2)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*q_3)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*q_4)[N][N] = (float (*)[N][N]) getRandom3DArray<float>(N, N, N);
  float (*flux_0)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_1)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_2)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_3)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_4)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_gold_0)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_gold_1)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_gold_2)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_gold_3)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*flux_gold_4)[N][N] = (float (*)[N][N]) getZero3DArray<float>(N, N, N);
  float (*dxinv) = (float*) malloc (sizeof (float) * 3);
  dxinv[0] = 0.01f;
  dxinv[1] = 0.02f;
  dxinv[2] = 0.03f;

  hypterm_gold ((float*)flux_gold_0, (float*)flux_gold_1, (float*)flux_gold_2, (float*)flux_gold_3, (float*)flux_gold_4, (float*)cons_1, (float*)cons_2, (float*)cons_3, (float*)cons_4, (float*)q_1, (float*)q_2, (float*)q_3, (float*)q_4, dxinv, N);
  host_code ((float*)flux_0, (float*)flux_1, (float*)flux_2, (float*)flux_3, (float*)flux_4, (float*)cons_1, (float*)cons_2, (float*)cons_3, (float*)cons_4, (float*)q_1, (float*)q_2, (float*)q_3, (float*)q_4, dxinv[0], dxinv[1], dxinv[2], N, N, N);

  double error_0 = checkError3D<float> (N, N, (float*)flux_0, (float*)flux_gold_0, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error_0);
  if (error_0 > TOLERANCE)
    return -1;
  double error_1 = checkError3D<float> (N, N, (float*)flux_1, (float*)flux_gold_1, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error_1);
  if (error_1 > TOLERANCE)
    return -1;
  double error_2 = checkError3D<float> (N, N, (float*)flux_2, (float*)flux_gold_2, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error_2);
  if (error_2 > TOLERANCE)
    return -1;
  double error_3 = checkError3D<float> (N, N, (float*)flux_3, (float*)flux_gold_3, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error_3);
  if (error_3 > TOLERANCE)
    return -1;
  double error_4 = checkError3D<float> (N, N, (float*)flux_4, (float*)flux_gold_4, 4, N-4, 4, N-4, 4, N-4);
  printf("[Test] RMS Error : %e\n",error_4);
  if (error_4 > TOLERANCE)
    return -1;

  delete[] cons_1;
  delete[] cons_2;
  delete[] cons_3;
  delete[] cons_4;
  delete[] q_1;
  delete[] q_2;
  delete[] q_3;
  delete[] q_4;
  delete[] flux_0;
  delete[] flux_1;
  delete[] flux_2;
  delete[] flux_3;
  delete[] flux_4;
  delete[] flux_gold_0;
  delete[] flux_gold_1;
  delete[] flux_gold_2;
  delete[] flux_gold_3;
  delete[] flux_gold_4;
}
