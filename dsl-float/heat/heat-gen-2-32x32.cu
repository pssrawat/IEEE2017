/* --------------------------------------------------------------------
        OPTIMIZED CODE MAKING USE OF REGISTERS + SHARED MEMORY
----------------------------------------------------------------------*/

#include <stdio.h>
#include "cuda.h"
#define max(x,y)  ((x) > (y)? (x) : (y))
#define min(x,y)  ((x) < (y)? (x) : (y))
#define ceil(a,b) ((a) % (b) == 0 ? (a) / (b) : ((a) / (b)) + 1)

void check_error (const char* message) {
  cudaError_t error = cudaGetLastError ();
  if (error != cudaSuccess) {
    printf ("CUDA error : %s, %s\n", message, cudaGetErrorString (error));
    exit(-1);
  }
}

__global__ void heat (float * __restrict__ in, float * __restrict__ out1, int L, int M, int N) {
  //Determing the block's indices
  int blockdim_i= (int)(blockDim.x);
  int i0 = (int)(blockIdx.x)*(blockdim_i-4);
  int i = max (i0, 0) + (int)(threadIdx.x);
  int blockdim_j= (int)(blockDim.y);
  int j0 = (int)(blockIdx.y)*(blockdim_j-4);
  int j = max (j0, 0) + (int)(threadIdx.y);

  //Declarations
  float reg_in_m1=0, __shared__ sh_in_c0[32][32], reg_in_p1=0;
  float reg_out_m2=0, __shared__ sh_out_m1[32][32], reg_out_c0=0;

  //Value Initialization
  if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
    reg_in_m1 = in[0 + j*N + i];
    sh_in_c0[j-j0][i-i0] = in[1*M*N + j*N + i];
  }

  //Rest of the computation
  for (int k=1; k<=L-2; ++k) {
    //Fetch new plane
    if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
        reg_in_p1 = in[(k+1)*M*N + j*N + i];
    }
    __syncthreads ();
    if (j >= max (j0+1, 1) & j <= min (j0+blockdim_j-2, M-2) & i >= max (i0+1, 1) & i <= min (i0+blockdim_i-2, N-2)) {
        reg_out_c0 = ((((0.125f * ((reg_in_p1 - (2.0f * sh_in_c0[j-j0][i-i0])) + reg_in_m1)) + (0.125f * ((sh_in_c0[j-j0+1][i-i0] - (2.0f * sh_in_c0[j-j0][i-i0])) + sh_in_c0[j-j0-1][i-i0]))) + (0.125f * ((sh_in_c0[j-j0][i-i0+1] - (2.0f * sh_in_c0[j-j0][i-i0])) + sh_in_c0[j-j0][i-i0-1]))) + sh_in_c0[j-j0][i-i0]);
    }
    if (j >= max (j0+2, 1) & j <= min (j0+blockdim_j-3, M-2) & i >= max (i0+2, 1) & i <= min (i0+blockdim_i-3, N-2)) {
        out1[max(k-1,0)*M*N + j*N + i] = ((((0.125f * ((reg_out_c0 - (2.0f * sh_out_m1[j-j0][i-i0])) + reg_out_m2)) + (0.125f * ((sh_out_m1[j-j0+1][i-i0] - (2.0f * sh_out_m1[j-j0][i-i0])) + sh_out_m1[j-j0-1][i-i0]))) + (0.125f * ((sh_out_m1[j-j0][i-i0+1] - (2.0f * sh_out_m1[j-j0][i-i0])) + sh_out_m1[j-j0][i-i0-1]))) + sh_out_m1[j-j0][i-i0]);
    }
    __syncthreads ();
    //Value rotation
    if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
        reg_in_m1 = sh_in_c0[j-j0][i-i0];
        sh_in_c0[j-j0][i-i0] = reg_in_p1;
        reg_out_m2 = sh_out_m1[j-j0][i-i0];
        sh_out_m1[j-j0][i-i0] = reg_out_c0;
    }
    __syncthreads ();
  }
}

extern "C" void host_code (float *h_in, float *h_out2, int L, int M, int N) {
  float *in;
  cudaMalloc (&in, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for in\n");
  cudaMemcpy (in, h_in, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *out1;
  cudaMalloc (&out1, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out1\n");
  float *out2;
  cudaMalloc (&out2, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out2\n");

  dim3 blockconfig_1 (32, 32, 1);
  dim3 gridconfig_1 (ceil(N, blockconfig_1.x-4), ceil(M, blockconfig_1.y-4), 1);
  heat <<<gridconfig_1, blockconfig_1>>> (in, out1, L, M, N);

  dim3 blockconfig_2 (32, 32, 1);
  dim3 gridconfig_2 (ceil(N, blockconfig_2.x-4), ceil(M, blockconfig_2.y-4), 1);
  heat <<<gridconfig_2, blockconfig_2>>> (out1, out2, L, M, N);

  cudaMemcpy (h_out2, out2, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
}
