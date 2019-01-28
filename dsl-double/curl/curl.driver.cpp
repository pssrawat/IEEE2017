#include "../common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void curl(double4*, double, double, double, int, int, int, double4*);

extern "C" void curl_gold(double4*, double, double, double, int, int, int, double4*);

int main(int argc, char** argv) {
  int height, width_y, width_x;
  if (argc == 4) {
    height = atoi(argv[1]);
    width_y = atoi(argv[2]);
    width_x = atoi(argv[3]);
  }
  else {
    height = 450;
    width_y = 450;
    width_x = 450;
  }

  double4 (*inp1)[width_y][width_x] = (double4 (*)[width_y][width_x])
    getRandom3DArray<double4>(height, width_y, width_x);
  double4 (*outp)[width_y][width_x] = (double4 (*)[width_y][width_x])
    getZero3DArray<double4>(height, width_y, width_x);
  double4 (*outp_gold)[width_y][width_x] = (double4 (*)[width_y][width_x])
    getZero3DArray<double4>(height, width_y, width_x);

  double dx = get_random<double>();
  double dy = get_random<double>();
  double dz = get_random<double>();

  curl((double4*)inp1, dx, dy, dz, height, width_y, width_x, (double4*)outp);

  curl_gold
    ((double4*)inp1, dx, dy, dz, height, width_y, width_x, (double4*)outp_gold);

#ifdef PRINT_OUTPUT
  printf("Output :\n");
  print3DArray<double4>
    (width_y, width_x, (double4*)outp, 1, height-1, 1, width_y-1, 1, width_x-1);
  printf("\nOutput Gold:\n");
  print3DArray<double4>
    (width_y, width_x, (double4*)outp_gold, 1, height-1, 1, width_y-1, 1,
     width_x-1);
#endif

  double error =
    checkError3D<double4>
    (width_y, width_x, (double4*)outp, (double4*) outp_gold, 1, height-1, 1,
     width_y-1, 1, width_x-1);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] inp1;
  delete[] outp;
  delete[] outp_gold;
}
