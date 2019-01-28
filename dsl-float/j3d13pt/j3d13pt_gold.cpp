#include "../common/common.hpp"

static void print_matrix
(int height, int width_y, int width_x, float* l_output)
{
  float (*output)[width_y][width_x] = (float (*)[width_y][width_x])l_output;
  for( int i = 0 ; i < height; i++ )
    for( int j = 0 ; j < width_y; j++ )
      for (int k = 0 ; k < width_x; k++ ) 
	printf ("Input[%d][%d][%d] = %.6f\n", i, j, k, output[i][j][k]);
}

static void j3d_step
(const float* l_input, int height, int width_y, int width_x, float* l_output, int step)
{
  const float (*input)[width_y][width_x] =
    (const float (*)[width_y][width_x])l_input;
  float (*output)[width_y][width_x] = (float (*)[width_y][width_x])l_output;

  for (int i = 2; i < height-2; i++)
    for (int j = 2; j < width_y-2; j++)
      for (int k = 2; k < width_x-2; k++) {
        output[i][j][k] =
          0.083f * input[i][j][k+2] + 0.083f * input[i][j][k+1] +
          0.083f * input[i][j][k-1] + 0.083f * input[i][j][k-2] +
          0.083f * input[i][j+2][k] + 0.083f * input[i][j+1][k] +
          0.083f * input[i][j-1][k] + 0.083f * input[i][j-2][k] +
          0.083f * input[i+2][j][k] + 0.083f * input[i+1][j][k] +
          0.083f * input[i-1][j][k] + 0.083f * input[i-2][j][k] -
          0.996f * input[i][j][k];
	//if (step == 3) printf ("Output[%d][%d][%d] = %.6f (%6f, %6f, %6f, %6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f)\n", i, j, k, output[i][j][k], input[i+2][j][k], input[i+1][j][k], input[i-1][j][k], input[i-2][j][k], input[i][j][k], input[i][j][k-2], input[i][j][k-1], input[i][j][k+1], input[i][j][k+2], input[i][j-2][k], input[i][j-1][k], input[i][j+1][k], input[i][j+2][k]);
      }
}


extern "C" void j3d13pt_gold
(float *l_input, int height, int width_y, int width_x, float* l_output)
{
  //print_matrix(height, width_y, width_x, l_input); 
  float* temp = getZero3DArray<float>(height, width_y, width_x);
  j3d_step(l_input, height, width_y, width_x, temp, 0);
  j3d_step(temp, height, width_y, width_x, l_output, 1);
  memset(temp, 0, sizeof(float) * height * width_y * width_x);
  j3d_step(l_output, height, width_y, width_x, temp, 2);
  memset(l_output, 0, sizeof(float) * height * width_y * width_x);
  j3d_step(temp, height, width_y, width_x, l_output, 3);
  delete[] temp;
}
