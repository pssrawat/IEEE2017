#include "../common/common.hpp"

static void print_matrix 
(int width_y, int width_x, float* l_output)
{
  float (*output)[width_x] = (float (*)[width_x])l_output;
  for( int i = 2; i < width_y-2; i++ )
    for( int j = 2; j < width_x-2; j++ )
      printf ("Output[%d][%d] = %.6f\n", i, j, output[i][j]);
}

static void jacobi_step
(const float* l_input, int width_y, int width_x, float* l_output, int step)
{
  const float (*input)[width_x] = (const float (*)[width_x])l_input;
  float (*output)[width_x] = (float (*)[width_x])l_output;
  for( int i = 2; i < width_y-2; i++ )
    for( int j = 2 ; j < width_x-2; j++ )
      output[i][j] = (7*input[i-2][j] + 5*input[i-1][j] + 9*input[i][j-2] + 12*input[i][j-1] + 15*input[i][j] + 12*input[i][j+1] + 9*input[i][j+2] + 5*input[i+1][j] + 7*input[i+2][j]) / 118;
}

extern "C" void jacobi_gold
(float* l_input, int width_y, int width_x, float* l_output)
{
  float* temp = getZero2DArray<float>(width_y, width_x);
  jacobi_step(l_input, width_y, width_x, temp, 0);
  //print_matrix (width_y, width_x, temp);
  jacobi_step(temp, width_y, width_x, l_output, 1);
  memset(temp, 0, sizeof(float) * width_y * width_x);
  jacobi_step(l_output, width_y, width_x, temp, 2);
  memset(l_output, 0, sizeof(float) * width_y * width_x);
  jacobi_step(temp, width_y, width_x, l_output, 3);
}
