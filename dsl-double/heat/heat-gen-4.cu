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

__global__ void heat (double * __restrict__ in, double * __restrict__ out1, double * __restrict__ out2, double * __restrict__ out3, double * __restrict__ out, int L, int M, int N) {
  //Determining the block's indices
  int blockdim_i= (int)(blockDim.x);
  int i0 = (int)(blockIdx.x)*(blockdim_i-8);
  int i = i0 + (int)(threadIdx.x);
  int blockdim_j= (int)(blockDim.y);
  int j0 = (int)(blockIdx.y)*(blockdim_j-8);
  int j = j0 + (int)(threadIdx.y);

  //Declarations
  double reg_in_m1=0, __shared__ sh_in_c0[32][32], reg_in_p1=0;
  double reg_out1_m2=0, __shared__ sh_out1_m1[32][32], reg_out1_c0=0;
  double reg_out2_m3=0, __shared__ sh_out2_m2[32][32], reg_out2_m1=0;
  double reg_out3_m4=0, __shared__ sh_out3_m3[32][32], reg_out3_m2=0;

  //Value Initialization
  if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
    reg_in_m1 = in[0 + j*N + i];
    sh_in_c0[j-j0][i-i0] = in[1*M*N + j*N + i];
  }

  //Rest of the computation
  #pragma unroll 2
  for (int k=1; k<=L-2; ++k) {
    //Fetch new plane
    if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
        reg_in_p1 = in[(k+1)*M*N + j*N + i];
    }
    __syncthreads ();
    if (j >= j0+1 & j <= min (j0+blockdim_j-2, M-2) & i >= i0+1 & i <= min (i0+blockdim_i-2, N-2)) {
        reg_out1_c0 = ((((0.125f * ((reg_in_p1 - (2.0f * sh_in_c0[j-j0][i-i0])) + reg_in_m1)) + (0.125f * ((sh_in_c0[j-j0+1][i-i0] - (2.0f * sh_in_c0[j-j0][i-i0])) + sh_in_c0[j-j0-1][i-i0]))) + (0.125f * ((sh_in_c0[j-j0][i-i0+1] - (2.0f * sh_in_c0[j-j0][i-i0])) + sh_in_c0[j-j0][i-i0-1]))) + sh_in_c0[j-j0][i-i0]);
    }
    __syncthreads ();
    if (j >= j0+2 & j <= min (j0+blockdim_j-3, M-2) & i >= i0+2 & i <= min (i0+blockdim_i-3, N-2)) {
        reg_out2_m1 = ((((0.125f * ((reg_out1_c0 - (2.0f * sh_out1_m1[j-j0][i-i0])) + reg_out1_m2)) + (0.125f * ((sh_out1_m1[j-j0+1][i-i0] - (2.0f * sh_out1_m1[j-j0][i-i0])) + sh_out1_m1[j-j0-1][i-i0]))) + (0.125f * ((sh_out1_m1[j-j0][i-i0+1] - (2.0f * sh_out1_m1[j-j0][i-i0])) + sh_out1_m1[j-j0][i-i0-1]))) + sh_out1_m1[j-j0][i-i0]);
    }
    __syncthreads ();
    if (j >= j0+3 & j <= min (j0+blockdim_j-4, M-2) & i >= i0+3 & i <= min (i0+blockdim_i-4, N-2)) {
        reg_out3_m2 = ((((0.125f * ((reg_out2_m1 - (2.0f * sh_out2_m2[j-j0][i-i0])) + reg_out2_m3)) + (0.125f * ((sh_out2_m2[j-j0+1][i-i0] - (2.0f * sh_out2_m2[j-j0][i-i0])) + sh_out2_m2[j-j0-1][i-i0]))) + (0.125f * ((sh_out2_m2[j-j0][i-i0+1] - (2.0f * sh_out2_m2[j-j0][i-i0])) + sh_out2_m2[j-j0][i-i0-1]))) + sh_out2_m2[j-j0][i-i0]);
    }
    __syncthreads ();
    if (j >= j0+4 & j <= min (j0+blockdim_j-5, M-2) & i >= i0+4 & i <= min (i0+blockdim_i-5, N-2)) {
        out[max(k-3,0)*M*N + j*N + i] = ((((0.125f * ((reg_out3_m2 - (2.0f * sh_out3_m3[j-j0][i-i0])) + reg_out3_m4)) + (0.125f * ((sh_out3_m3[j-j0+1][i-i0] - (2.0f * sh_out3_m3[j-j0][i-i0])) + sh_out3_m3[j-j0-1][i-i0]))) + (0.125f * ((sh_out3_m3[j-j0][i-i0+1] - (2.0f * sh_out3_m3[j-j0][i-i0])) + sh_out3_m3[j-j0][i-i0-1]))) + sh_out3_m3[j-j0][i-i0]);
    }
    __syncthreads ();
    //Value rotation
    reg_in_m1 = sh_in_c0[j-j0][i-i0];
    sh_in_c0[j-j0][i-i0] = reg_in_p1;
    reg_out1_m2 = sh_out1_m1[j-j0][i-i0];
    sh_out1_m1[j-j0][i-i0] = reg_out1_c0;
    reg_out2_m3 = sh_out2_m2[j-j0][i-i0];
    sh_out2_m2[j-j0][i-i0] = reg_out2_m1;
    reg_out3_m4 = sh_out3_m3[j-j0][i-i0];
    sh_out3_m3[j-j0][i-i0] = reg_out3_m2;
  }
}

extern "C" void host_code (double *h_in, double *h_out, int L, int M, int N) {
  double *in;
  cudaMalloc (&in, sizeof(double)*L*M*N);
  check_error ("Failed to allocate device memory for in\n");
  cudaMemcpy (in, h_in, sizeof(double)*L*M*N, cudaMemcpyHostToDevice);
  double *out;
  cudaMalloc (&out, sizeof(double)*L*M*N);
  check_error ("Failed to allocate device memory for out\n");
  double *out1;
  cudaMalloc (&out1, sizeof(double)*L*M*N);
  check_error ("Failed to allocate device memory for out1\n");
  double *out2;
  cudaMalloc (&out2, sizeof(double)*L*M*N);
  check_error ("Failed to allocate device memory for out2\n");
  double *out3;
  cudaMalloc (&out3, sizeof(double)*L*M*N);
  check_error ("Failed to allocate device memory for out3\n");

  dim3 blockconfig_1 (32, 32, 1);
  dim3 gridconfig_1 (ceil(N, blockconfig_1.x-8), ceil(M, blockconfig_1.y-8), 1);
  heat <<<gridconfig_1, blockconfig_1>>> (in, out1, out2, out3, out, L, M, N);

  cudaMemcpy (h_out, out, sizeof(double)*L*M*N, cudaMemcpyDeviceToHost);

  //Free allocated memory
  cudaFree (in);
  cudaFree (out);
  cudaFree (out1);
  cudaFree (out2);
  cudaFree (out3);
}
