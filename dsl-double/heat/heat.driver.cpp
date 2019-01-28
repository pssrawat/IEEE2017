#include "../common/common.hpp"
#include "../common/timer.hpp"
#include <cassert>
#include <cstdio>

extern "C" void host_code (double*, double*, int, int, int);
extern "C" void heat_gold (double*, double*, int, int, int);

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

  double (*input)[width_y][width_x] = (double (*)[width_y][width_x])
    getRandom3DArray<double>(height, width_y, width_x);
  double (*output)[width_y][width_x] = (double (*)[width_y][width_x])
    getZero3DArray<double>(height, width_y, width_x);
  double (*output_gold)[width_y][width_x] = (double (*)[width_y][width_x])
    getZero3DArray<double>(height, width_y, width_x);

  host_code ((double*)input, (double*)output, height, width_y, width_x);
  heat_gold((double*)input, (double*)output_gold, height, width_y, width_x);

  double error =
    checkError3D<double>
    (width_y, width_x, (double*)output, (double*) output_gold, 4, height-4, 4,
     width_y-4, 4, width_x-4);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] input;
  delete[] output;
  delete[] output_gold;
}
