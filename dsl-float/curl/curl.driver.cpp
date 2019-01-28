#include "../common/common.hpp"
#include <cassert>
#include <cstdio>

extern "C" void curl(float4*, float, float, float, int, int, int, float4*);

extern "C" void curl_gold(float4*, float, float, float, int, int, int, float4*);

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

  float4 (*inp1)[width_y][width_x] = (float4 (*)[width_y][width_x])
    getRandom3DArray<float4>(height, width_y, width_x);
  float4 (*outp)[width_y][width_x] = (float4 (*)[width_y][width_x])
    getZero3DArray<float4>(height, width_y, width_x);
  float4 (*outp_gold)[width_y][width_x] = (float4 (*)[width_y][width_x])
    getZero3DArray<float4>(height, width_y, width_x);

  float dx = get_random<float>();
  float dy = get_random<float>();
  float dz = get_random<float>();

  curl((float4*)inp1, dx, dy, dz, height, width_y, width_x, (float4*)outp);

  curl_gold
    ((float4*)inp1, dx, dy, dz, height, width_y, width_x, (float4*)outp_gold);

#ifdef PRINT_OUTPUT
  printf("Output :\n");
  print3DArray<float4>
    (width_y, width_x, (float4*)outp, 1, height-1, 1, width_y-1, 1, width_x-1);
  printf("\nOutput Gold:\n");
  print3DArray<float4>
    (width_y, width_x, (float4*)outp_gold, 1, height-1, 1, width_y-1, 1,
     width_x-1);
#endif

  double error =
    checkError3D<float4>
    (width_y, width_x, (float4*)outp, (float4*) outp_gold, 1, height-1, 1,
     width_y-1, 1, width_x-1);
  printf("[Test] RMS Error : %e\n",error);
  if (error > TOLERANCE)
    return -1;

  delete[] inp1;
  delete[] outp;
  delete[] outp_gold;
}
