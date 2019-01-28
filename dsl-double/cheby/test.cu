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

__global__ void cheby (float h2inv, float a, float b, float c, float d, float * __restrict__ RHS, float * __restrict__ Ap, float * __restrict__ Dinv, float * __restrict__ Ac, float * __restrict__ out, int L, int M, int N, float * __restrict__ out1) {
  //Determing the block's indices
  int blockdim_i= (int)(blockDim.x);
  int i0 = (int)(blockIdx.x)*(blockdim_i-4);
  int i = max (i0, 0) + (int)(threadIdx.x);
  int blockdim_j= (int)(blockDim.y);
  int j0 = (int)(blockIdx.y)*(blockdim_j-4);
  int j = max (j0, 0) + (int)(threadIdx.y);

  //Declarations
  float reg_Ac_m2=0, reg_Ac_m1=0, __shared__ sh_Ac_c0[32][32];
  float reg_Ap_m1=0;
  float reg_Dinv_m2=0, reg_Dinv_m1=0;
  float reg_RHS_m2=0, reg_RHS_m1=0;
  float reg_out1_m2=0, __shared__ sh_out1_m1[32][32];
  float reg_temp1_m1=0, reg_temp1_c0=0, reg_temp1_p1=0;
  float reg_temp2_m2=0, reg_temp2_m1=0, reg_temp2_c0=0;

  //Value Initialization
  if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
    sh_Ac_c0[j-j0][i-i0] = 0;
    sh_out1_m1[j-j0][i-i0] = 0;
  }
  //Rest of the computation
  for (int k=0; k<=L-1; ++k) {
    //Fetch new plane
    sh_Ac_c0[j-j0][i-i0] = Ac[k*M*N + j*N + i];
    reg_Ap_m1 = Ap[max(k-1,0)*M*N + j*N + i];
    reg_Dinv_m1 = Dinv[max(k-1,0)*M*N + j*N + i];
    reg_RHS_m1 = RHS[max(k-1,0)*M*N + j*N + i];

    __syncthreads ();
    if (j >= max (j0+1, 1) & j <= min (j0+blockdim_j-2, M-2) & i >= max (i0+1, 1) & i <= min (i0+blockdim_i-2, N-2)) {
        reg_temp1_p1 -= (h2inv * (((0.03f * (((sh_Ac_c0[j-j0-1][i-i0-1] + sh_Ac_c0[j-j0-1][i-i0+1]) + sh_Ac_c0[j-j0+1][i-i0-1]) + sh_Ac_c0[j-j0+1][i-i0+1])) + (0.1f * (((sh_Ac_c0[j-j0-1][i-i0] + sh_Ac_c0[j-j0][i-i0-1]) + sh_Ac_c0[j-j0][i-i0+1]) + sh_Ac_c0[j-j0+1][i-i0]))) + (0.46f * sh_Ac_c0[j-j0][i-i0])));
        reg_temp1_c0 += (sh_Ac_c0[j-j0][i-i0] - (h2inv * (((0.1f * (((sh_Ac_c0[j-j0-1][i-i0-1] + sh_Ac_c0[j-j0-1][i-i0+1]) + sh_Ac_c0[j-j0+1][i-i0-1]) + sh_Ac_c0[j-j0+1][i-i0+1])) + (0.46f * (((sh_Ac_c0[j-j0-1][i-i0] + sh_Ac_c0[j-j0][i-i0-1]) + sh_Ac_c0[j-j0][i-i0+1]) + sh_Ac_c0[j-j0+1][i-i0]))) - (4.26f * sh_Ac_c0[j-j0][i-i0]))));
        reg_temp1_m1 -= (h2inv * (((0.03f * (((sh_Ac_c0[j-j0-1][i-i0-1] + sh_Ac_c0[j-j0-1][i-i0+1]) + sh_Ac_c0[j-j0+1][i-i0-1]) + sh_Ac_c0[j-j0+1][i-i0+1])) + (0.1f * (((sh_Ac_c0[j-j0-1][i-i0] + sh_Ac_c0[j-j0][i-i0-1]) + sh_Ac_c0[j-j0][i-i0+1]) + sh_Ac_c0[j-j0+1][i-i0]))) + (0.46f * sh_Ac_c0[j-j0][i-i0])));
        sh_out1_m1[j-j0][i-i0] = ((reg_Ac_m1 + (a * (reg_Ac_m1 - reg_Ap_m1))) + ((b * reg_Dinv_m1) * (reg_RHS_m1 - reg_temp1_m1)));
	out1[max(k-1,0)*M*N+j*N+i] = sh_out1_m1[j-j0][i-i0];
    }
    __syncthreads ();
    if (j >= max (j0+2, 1) & j <= min (j0+blockdim_j-3, M-2) & i >= max (i0+2, 1) & i <= min (i0+blockdim_i-3, N-2)) {
        reg_temp2_c0 -= (h2inv * (((0.03f * (((sh_out1_m1[j-j0-1][i-i0-1] + sh_out1_m1[j-j0-1][i-i0+1]) + sh_out1_m1[j-j0+1][i-i0-1]) + sh_out1_m1[j-j0+1][i-i0+1])) + (0.1f * (((sh_out1_m1[j-j0-1][i-i0] + sh_out1_m1[j-j0][i-i0-1]) + sh_out1_m1[j-j0][i-i0+1]) + sh_out1_m1[j-j0+1][i-i0]))) + (0.46f * sh_out1_m1[j-j0][i-i0])));
        reg_temp2_m1 += (sh_out1_m1[j-j0][i-i0] - (h2inv * (((0.1f * (((sh_out1_m1[j-j0-1][i-i0-1] + sh_out1_m1[j-j0-1][i-i0+1]) + sh_out1_m1[j-j0+1][i-i0-1]) + sh_out1_m1[j-j0+1][i-i0+1])) + (0.46f * (((sh_out1_m1[j-j0-1][i-i0] + sh_out1_m1[j-j0][i-i0-1]) + sh_out1_m1[j-j0][i-i0+1]) + sh_out1_m1[j-j0+1][i-i0]))) - (4.26f * sh_out1_m1[j-j0][i-i0]))));
        reg_temp2_m2 -= (h2inv * (((0.03f * (((sh_out1_m1[j-j0-1][i-i0-1] + sh_out1_m1[j-j0-1][i-i0+1]) + sh_out1_m1[j-j0+1][i-i0-1]) + sh_out1_m1[j-j0+1][i-i0+1])) + (0.1f * (((sh_out1_m1[j-j0-1][i-i0] + sh_out1_m1[j-j0][i-i0-1]) + sh_out1_m1[j-j0][i-i0+1]) + sh_out1_m1[j-j0+1][i-i0]))) + (0.46f * sh_out1_m1[j-j0][i-i0])));
        out[max(k-2,0)*M*N + j*N + i] = ((reg_out1_m2 + (c * (reg_out1_m2 - reg_Ac_m2))) + ((d * reg_Dinv_m2) * (reg_RHS_m2 - reg_temp2_m2)));
    }
    __syncthreads ();
    //Value rotation

    reg_Ac_m2 = reg_Ac_m1;
    reg_Ac_m1 = sh_Ac_c0[j-j0][i-i0];
    sh_Ac_c0[j-j0][i-i0] = 0;
    reg_Dinv_m2 = reg_Dinv_m1;
    reg_Dinv_m1 = 0;
    reg_RHS_m2 = reg_RHS_m1;
    reg_RHS_m1 = 0;
    reg_out1_m2 = sh_out1_m1[j-j0][i-i0];
    sh_out1_m1[j-j0][i-i0] = 0;
    reg_temp1_m1 = reg_temp1_c0;
    reg_temp1_c0 = reg_temp1_p1;
    reg_temp1_p1 = 0;
    reg_temp2_m2 = reg_temp2_m1;
    reg_temp2_m1 = reg_temp2_c0;
    reg_temp2_c0 = 0;
    __syncthreads ();
  }
}

extern "C" void host_code (float *h_Ac, float *h_Ap, float *h_Dinv, float *h_RHS, float *h_out, float *c1, float *c2, float h2inv, int L, int M, int N) {
  float *Ac;
  cudaMalloc (&Ac, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for Ac\n");
  cudaMemcpy (Ac, h_Ac, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *Ap;
  cudaMalloc (&Ap, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for Ap\n");
  cudaMemcpy (Ap, h_Ap, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *Dinv;
  cudaMalloc (&Dinv, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for Dinv\n");
  cudaMemcpy (Dinv, h_Dinv, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *RHS;
  cudaMalloc (&RHS, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for RHS\n");
  cudaMemcpy (RHS, h_RHS, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *out;
  cudaMalloc (&out, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out\n");
  float *out1;
  cudaMalloc (&out1, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out1\n");
  float *out2;
  cudaMalloc (&out2, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out2\n");
  float *out3;
  cudaMalloc (&out3, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for out3\n");
  dim3 blockconfig_1 (32, 32, 1);
  dim3 gridconfig_1 (ceil(N, blockconfig_1.x-4), ceil(M, blockconfig_1.y-4), 1);
  cheby <<<gridconfig_1, blockconfig_1>>> (h2inv, c1[0], c2[0], c1[1], c2[1], RHS, Ap, Dinv, Ac, out2, L, M, N, out1);

  dim3 blockconfig_2 (32, 32, 1);
  dim3 gridconfig_2 (ceil(N, blockconfig_2.x-4), ceil(M, blockconfig_2.y-4), 1);
  cheby <<<gridconfig_2, blockconfig_2>>> (h2inv, c1[2], c2[2], c1[3], c2[3], RHS, out1, Dinv, out2, out, L, M, N, out3);
  cudaMemcpy (h_out, out, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
}
