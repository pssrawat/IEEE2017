#include <stdio.h>
#include "cuda.h"
#define max(x,y)  ((x) > (y)? (x) : (y))
#define min(x,y)  ((x) < (y)? (x) : (y))
#define ceil(a,b) ((a) % (b) == 0 ? (a) / (b) : ((a) / (b)) + 1)
#define epsilon (1.0E-20f)

void check_error (const char* message) {
  cudaError_t error = cudaGetLastError ();
  if (error != cudaSuccess) {
    printf ("CUDA error : %s, %s\n", message, cudaGetErrorString (error));
    exit(-1);
  }
}

__global__ void denoise (float * __restrict__ u, float * __restrict__ f, float * __restrict__ out, float gamma, float r, float sigma2, int L, int M, int N) {
  //Determing the block's indices
  int blockdim_i= (int)(blockDim.x);
  int i0 = (int)(blockIdx.x)*(blockdim_i-4);
  int i = max (i0, 0) + (int)(threadIdx.x);
  int blockdim_j= (int)(blockDim.y);
  int j0 = (int)(blockIdx.y)*(blockdim_j-4);
  int j = max (j0, 0) + (int)(threadIdx.y);

  //Declarations
  float reg_f_m1=0;
  float reg_g_m2=0, __shared__ sh_g_m1[32][32];
  float reg_g_c0=0;
  float reg_u_m2=0, __shared__ sh_u_m1[32][32], __shared__ sh_u_c0[32][32];
  float reg_u_p1=0;

  //Value Initialization
  if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
    reg_u_m2 = u[0 + j*N + i];
    sh_u_m1[j-j0][i-i0] = u[0 + j*N + i];
    sh_u_c0[j-j0][i-i0] = u[1*M*N + j*N + i];
  }

  //Rest of the computation
  for (int k=1; k<=L-2; ++k) {
    //Fetch new plane
    if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
        reg_f_m1 = f[max(k-1,0)*M*N + j*N + i];
        reg_u_p1 = u[(k+1)*M*N + j*N + i];
    }
    __syncthreads ();
    if (j >= max (j0+1, 1) & j <= min (j0+blockdim_j-2, M-2) & i >= max (i0+1, 1) & i <= min (i0+blockdim_i-2, N-2)) {
        reg_g_c0 = (1.0f / sqrt (((((((epsilon + ((sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0+1][i-i0]) * (sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0+1][i-i0]))) + ((sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0-1][i-i0]) * (sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0-1][i-i0]))) + ((sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0][i-i0+1]) * (sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0][i-i0+1]))) + ((sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0][i-i0-1]) * (sh_u_c0[j-j0][i-i0] - sh_u_c0[j-j0][i-i0-1]))) + ((sh_u_c0[j-j0][i-i0] - reg_u_p1) * (sh_u_c0[j-j0][i-i0] - reg_u_p1))) + ((sh_u_c0[j-j0][i-i0] - sh_u_m1[j-j0][i-i0]) * (sh_u_c0[j-j0][i-i0] - sh_u_m1[j-j0][i-i0])))));
        r = ((sh_u_m1[j-j0][i-i0] * reg_f_m1) / sigma2);
        r = ((r * (2.38944f + (r * (0.950037f + r)))) / (4.65314f + (r * (2.57541f + (r * (1.48937f + r))))));
    }
    __syncthreads ();
    if (j >= max (j0+2, 1) & j <= min (j0+blockdim_j-3, M-2) & i >= max (i0+2, 1) & i <= min (i0+blockdim_i-3, N-2)) {
        out[max(k-1,0)*M*N + j*N + i] = ((sh_u_m1[j-j0][i-i0] + (5.0f * (((((((sh_u_m1[j-j0+1][i-i0] * sh_g_m1[j-j0+1][i-i0]) + (sh_u_m1[j-j0-1][i-i0] * sh_g_m1[j-j0-1][i-i0])) + (sh_u_m1[j-j0][i-i0+1] * sh_g_m1[j-j0][i-i0+1])) + (sh_u_m1[j-j0][i-i0-1] * sh_g_m1[j-j0][i-i0-1])) + (sh_u_c0[j-j0][i-i0] * reg_g_c0)) + (reg_u_m2 * reg_g_m2)) + ((gamma * reg_f_m1) * r)))) / (1.0f + (5.0f * ((((((sh_g_m1[j-j0+1][i-i0] + sh_g_m1[j-j0-1][i-i0]) + sh_g_m1[j-j0][i-i0+1]) + sh_g_m1[j-j0][i-i0-1]) + reg_g_c0) + reg_g_m2) + gamma))));
    }
    __syncthreads ();
    //Value rotation
    if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
        reg_g_m2 = sh_g_m1[j-j0][i-i0];
        sh_g_m1[j-j0][i-i0] = reg_g_c0;
        reg_u_m2 = sh_u_m1[j-j0][i-i0];
        sh_u_m1[j-j0][i-i0] = sh_u_c0[j-j0][i-i0];
        sh_u_c0[j-j0][i-i0] = reg_u_p1;
    }
  }
}

extern "C" void host_code (float *h_u, float *h_f, float gamma, float r, float sigma2, int L, int M, int N) {
  float *u;
  cudaMalloc (&u, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for u\n");
  cudaMemcpy (u, h_u, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *f;
  cudaMalloc (&f, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for f\n");
  cudaMemcpy (f, h_f, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *out;
  cudaMalloc (&out, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out\n");

  dim3 blockconfig_1 (32, 32, 1);
  dim3 gridconfig_1 (ceil(N, blockconfig_1.x-4), ceil(M, blockconfig_1.y-4), 1);
  denoise <<<gridconfig_1, blockconfig_1>>> (u, f, out, gamma, r, sigma2, L, M, N);
  denoise <<<gridconfig_1, blockconfig_1>>> (out, f, u, gamma, r, sigma2, L, M, N);
  denoise <<<gridconfig_1, blockconfig_1>>> (u, f, out, gamma, r, sigma2, L, M, N);
  denoise <<<gridconfig_1, blockconfig_1>>> (out, f, u, gamma, r, sigma2, L, M, N);
  cudaMemcpy (h_u, u, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
}
