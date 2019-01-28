#include "../common/common.hpp"

extern "C" void curl_gold
(double4* l_input, double dx, double dy, double dz, int height, int width_y,
 int width_x, double4* l_output)
{
  double4 (*curl1)[width_y][width_x] =
    (double4 (*)[width_y][width_x])new double4[height*width_y*width_x];
  memset(curl1, 0, sizeof(double4)*height*width_y*width_x);
  double4 (*input)[width_y][width_x] = (double4 (*)[width_y][width_x])l_input;
  double4 (*output)[width_y][width_x] = (double4 (*)[width_y][width_x])l_output;
  for (int k = 0; k < height - 1; k++)
    for (int i = 0; i < width_y - 1; i++)
      for (int j = 0; j < width_x - 1; j++){
        curl1[k][i][j].x =
          dz * (input[k+1][i][j].y - input[k][i][j].y) -
          dy * (input[k][i+1][j].z - input[k][i][j].z) + input[k][i][j].x;
        curl1[k][i][j].y =
          dz * (input[k+1][i][j].x - input[k][i][j].x) -
          dx * (input[k][i][j+1].z - input[k][i][j].z) + input[k][i][j].y;
        curl1[k][i][j].z =
          dy * (input[k][i+1][j].x - input[k][i][j].x) -
          dx * (input[k][i][j+1].y - input[k][i][j].y) + input[k][i][j].z;
        curl1[k][i][j].w = 0.0f;
      }
  for (int k = 1; k < height; k++)
    for (int i = 1; i < width_y; i++)
      for (int j = 1; j < width_x; j++) {
        output[k][i][j].x =
          dz * (curl1[k][i][j].y - curl1[k-1][i][j].y) -
          dy * (curl1[k][i][j].z - curl1[k][i-1][j].z) + curl1[k][i][j].x;
        output[k][i][j].y =
          dz * (curl1[k][i][j].x - curl1[k-1][i][j].x) -
          dx * (curl1[k][i][j].z - curl1[k][i][j-1].z) + curl1[k][i][j].y;
        output[k][i][j].z =
          dy * (curl1[k][i][j].x - curl1[k][i-1][j].x) -
          dx * (curl1[k][i][j].y - curl1[k][i][j-1].y) + curl1[k][i][j].z;
        output[k][i][j].w = 0.0f;
      }
  delete[] curl1;
}
