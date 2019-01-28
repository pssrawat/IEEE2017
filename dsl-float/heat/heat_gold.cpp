#include "../common/common.hpp"


static void heat_step
(const float* l_input, int height, int width_y, int width_x, float* l_output, int step)
{
  const float (*input)[width_y][width_x] =
    (const float (*)[width_y][width_x])l_input;
  float (*output)[width_y][width_x] = (float (*)[width_y][width_x])l_output;

  for (int i = 1; i < height-1; i++)
    for (int j = 1; j < width_y-1; j++)
      for (int k = 1; k < width_x-1; k++) {
          output[i][j][k] = 0.125f*(input[i+1][j][k] - 2.0f*input[i][j][k] + input[i-1][j][k])
		          + 0.125f*(input[i][j+1][k] - 2.0f*input[i][j][k] + input[i][j-1][k])
         		  + 0.125f*(input[i][j][k+1] - 2.0f*input[i][j][k] + input[i][j][k-1])
         		  + input[i][j][k];
      }
}


extern "C" void heat_gold
(float *l_input, float *l_output, int height, int width_y, int width_x)
{
  float* temp = getZero3DArray<float>(height, width_y, width_x);
  heat_step(l_input, height, width_y, width_x, temp, 0);
  heat_step(temp, height, width_y, width_x, l_output, 1);
  memset(temp, 0, sizeof(float) * height * width_y * width_x);
  heat_step(l_output, height, width_y, width_x, temp, 2);
  memset(l_output, 0, sizeof(float) * height * width_y * width_x);
  heat_step(temp, height, width_y, width_x, l_output, 3);
  delete[] temp;
}
