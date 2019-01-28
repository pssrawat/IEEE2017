#include "../common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void gaussian(float*, int, int, float*);

extern "C" void gaussian_gold(float*, int, int, float*);

int main(int argc, char** argv) {
  int width_y, width_x;
  if (argc == 3) {
    width_y = atoi(argv[1]);
    width_x = atoi(argv[2]);
  }
  else {
    width_y = 8192;
    width_x = 8192;
  }

  float (*input)[width_x] = (float (*)[width_x])
    getRandom2DArray<float>(width_y, width_x);
  float (*output)[width_x] = (float (*)[width_x])
    getZero2DArray<float>(width_y, width_x);
  float (*output_gold)[width_x] = (float (*)[width_x])
    getZero2DArray<float>(width_y, width_x);

  gaussian((float*)input, width_y, width_x, (float*)output);

  gaussian_gold((float*)input, width_y, width_x, (float*)output_gold);

#ifdef PRINT_OUTPUT
  printf("Output :\n");
  print2DArray<float>(width_x, (float*)output, 8, width_y-8, 8, width_x-8);
  printf("\nOutput Gold:\n");
  print2DArray<float>(width_x, (float*)output_gold, 8, width_y-8, 8, width_x-8);
#endif

  double error =
    checkError2D<float>
    (width_x, (float*)output, (float*) output_gold, 8, width_y-8, 8, width_x-8);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] input;
  delete[] output;
  delete[] output_gold;
}
