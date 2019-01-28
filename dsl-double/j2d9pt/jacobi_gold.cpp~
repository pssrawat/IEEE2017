#include <sys/time.h>
#include "../common/common.hpp"

double rtclock () {
	struct timezone Tzp;
	struct timeval Tp;
	int stat = gettimeofday (&Tp, &Tzp);
	if (stat != 0) 
		printf ("Error return from gettimeofday: %d", stat);
	return (Tp.tv_sec + Tp.tv_usec*1.0e-6);
}  

static void print_matrix 
(int width_y, int width_x, float* l_output)
{
  float (*output)[width_x] = (float (*)[width_x])l_output;
  for( int i = 1 ; i < width_y-1 ; i++ )
    for( int j = 1 ; j < width_x-1 ; j++ )
      printf ("Output[%d][%d] = %.6f\n", i, j, output[i][j]);
}

static void jacobi_step
(const float* l_input, int width_y, int width_x, float* l_output, int step)
{
  const float (*input)[width_x] = (const float (*)[width_x])l_input;
  float (*output)[width_x] = (float (*)[width_x])l_output;
  for( int i = 1 ; i < width_y-1 ; i++ )
    for( int j = 1 ; j < width_x-1 ; j++ )
      output[i][j] = (7*input[i-1][j-1] + 5*input[i-1][j] + 9*input[i-1][j+1] + 12*input[i][j-1] + 15*input[i][j] + 12*input[i][j+1] + 9*input[i+1][j-1] + 5*input[i+1][j] + 7*input[i+1][j+1]) / 118;
  //if (step == 1) print_matrix(width_y, width_x, l_output);
}

extern "C" void jacobi_gold
(float* l_input, int width_y, int width_x, float* l_output)
{
  float* temp = getZero2DArray<float>(width_y, width_x);
  double start_time = rtclock ();
  jacobi_step(l_input, width_y, width_x, temp, 0);
  double end_time = rtclock ();
  printf ("Time taken by reference : %lf secs\n", end_time - start_time);
  //print_matrix (width_y, width_x, temp);
  jacobi_step(temp, width_y, width_x, l_output, 1);
  memset(temp, 0, sizeof(float) * width_y * width_x);
  jacobi_step(l_output, width_y, width_x, temp, 2);
  memset(l_output, 0, sizeof(float) * width_y * width_x);
  jacobi_step(temp, width_y, width_x, l_output, 3);
}
