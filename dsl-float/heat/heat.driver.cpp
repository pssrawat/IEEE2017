#include "../common/common.hpp"
#include "../common/timer.hpp"
#include <cassert>
#include <cstdio>

extern "C" void host_code (float*, float*, int, int, int);
extern "C" void heat_gold (float*, float*, int, int, int);

int main(int argc, char** argv) {
  int height, width_y, width_x;
  if (argc == 4) {
    height = atoi(argv[1]);
    width_y = atoi(argv[2]);
    width_x = atoi(argv[3]);
  }
  else {
    height = 512;
    width_y = 512;
    width_x = 512;
  }

  float (*input)[width_y][width_x] = (float (*)[width_y][width_x])
    getRandom3DArray<float>(height, width_y, width_x);
  float (*output)[width_y][width_x] = (float (*)[width_y][width_x])
    getZero3DArray<float>(height, width_y, width_x);
  float (*output_gold)[width_y][width_x] = (float (*)[width_y][width_x])
    getZero3DArray<float>(height, width_y, width_x);

  host_code ((float*)input, (float*)output, height, width_y, width_x);
  heat_gold((float*)input, (float*)output_gold, height, width_y, width_x);

  double error =
    checkError3D<float>
    (width_y, width_x, (float*)output, (float*) output_gold, 4, height-4, 4,
     width_y-4, 4, width_x-4);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] input;
  delete[] output;
  delete[] output_gold;
}
