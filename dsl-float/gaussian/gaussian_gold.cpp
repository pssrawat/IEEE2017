#include "../common/common.hpp"

static void gaussian_step
(const float* l_input, int width_y, int width_x, float* l_output)
{
  const float (*input)[width_x] = (const float (*)[width_x])l_input;
  float (*output)[width_x] = (float (*)[width_x])l_output;
  for( int i = 2 ; i < width_y-2 ; i++ )
    for( int j = 2 ; j < width_x-2 ; j++ )
      output[i][j] =
        (2*input[i-2][j-2] + 4*input[i-2][j-1] + 5*input[i-2][j] + 4*input[i-2][j+1] + 2*input[i-2][j+2] + 
	 4*input[i-1][j-2] + 9*input[i-1][j-1] + 12*input[i-1][j] + 9*input[i-1][j+1] + 4*input[i-1][j+2] + 
	 5*input[i][j-2] + 12*input[i][j-1] + 15*input[i][j] + 12*input[i][j+1] + 5*input[i][j+2] + 
	 4*input[i+1][j-2] + 9*input[i+1][j-1] + 12*input[i+1][j] + 9*input[i+1][j+1] + 4*input[i+1][j+2] + 
	 2*input[i+2][j-2] + 4*input[i+2][j-1] + 5*input[i+2][j] + 4*input[i+2][j+1] + 2*input[i+2][j+2]) / 159;
}


extern "C" void gaussian_gold
(float* l_input, int width_y, int width_x, float* l_output)
{
  float* temp = getZero2DArray<float>(width_y, width_x);
  gaussian_step(l_input, width_y, width_x, temp);
  gaussian_step(temp, width_y, width_x, l_output);
  memset(temp, 0, sizeof(float) * width_y * width_x);
  gaussian_step(l_output, width_y, width_x, temp);
  memset(l_output, 0, sizeof(float) * width_y * width_x);
  gaussian_step(temp, width_y, width_x, l_output);
}
