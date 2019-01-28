#include "../common/common.hpp"


static void j3d_step
(const double* l_input, int height, int width_y, int width_x, double* l_output, int step)
{
  const double (*input)[width_y][width_x] =
    (const double (*)[width_y][width_x])l_input;
  double (*output)[width_y][width_x] = (double (*)[width_y][width_x])l_output;

  for (int i = 1; i < height-1; i++)
    for (int j = 1; j < width_y-1; j++)
      for (int k = 1; k < width_x-1; k++) {
        output[i][j][k] = (0.50*(input[i-1][j-1][k-1] + input[i-1][j-1][k+1] + input[i-1][j+1][k-1] + input[i-1][j+1][k+1]) +
                           0.51*input[i][j-1][k-1] + 0.71*input[i][j-1][k] + 0.91*input[i][j-1][k+1] + 1.21*input[i][j][k-1] + 1.51*input[i][j][k] + 1.21*input[i][j][k+1] + 0.91*input[i][j+1][k-1] + 0.71*input[i][j+1][k] + 0.51*input[i][j+1][k+1] +
                           0.52*(input[i+1][j-1][k-1] + input[i+1][j-1][k+1] + input[i+1][j+1][k-1] + input[i+1][j+1][k+1])) / 159;
      }
}

extern "C" void j3d17pt_gold
(double *l_input, int height, int width_y, int width_x, double* l_output)
{
  double* temp = getZero3DArray<double>(height, width_y, width_x);
  j3d_step(l_input, height, width_y, width_x, temp, 0);
  j3d_step(temp, height, width_y, width_x, l_output, 1);
  memset(temp, 0, sizeof(double) * height * width_y * width_x);
  j3d_step(l_output, height, width_y, width_x, temp, 2);
  memset(l_output, 0, sizeof(double) * height * width_y * width_x);
  j3d_step(temp, height, width_y, width_x, l_output, 3);
  delete[] temp;
}
