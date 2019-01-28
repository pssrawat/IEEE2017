#include "../common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void j3d7pt(double*, int, int, int, double*);

extern "C" void j3d7pt_gold(double*, int, int, int, double*);

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

  j3d7pt((double*)input, height, width_y, width_x, (double*)output);

  j3d7pt_gold((double*)input, height, width_y, width_x, (double*)output_gold);

#ifdef PRINT_OUTPUT
  printf("Output :\n");
  print3DArray<double>
    (width_y, width_x, (double*)output, 4, height-4, 4, width_y-4, 4,
     width_x-4);
  printf("\nOutput Gold:\n");
  print3DArray<double>
    (width_y, width_x, (double*)output_gold, 4, height-4, 4, width_y-4, 4,
     width_x-4);
#endif

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
