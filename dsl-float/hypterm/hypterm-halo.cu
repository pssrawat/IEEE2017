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

__global__ void hypterm (float * flux_0, float * flux_1, float * flux_2, float * flux_3, float * flux_4, float * cons_1, float * cons_2, float * cons_3, float * cons_4, float * q_1, float * q_2, float * q_3, float * q_4, float dxinv0, float dxinv1, float dxinv2, int L, int M, int N) {
  //Determining the block's indices
  int blockdim_i= (int)(blockDim.x);
  int i0 = (int)(blockIdx.x)*(blockdim_i-8);
  int i = i0 + (int)(threadIdx.x);
  int blockdim_j= (int)(blockDim.y);
  int j0 = (int)(blockIdx.y)*(blockdim_j)+4;
  int j = j0 + (int)(threadIdx.y);

  //Declarations
  float reg_cons_1_m4=0, reg_cons_1_m3=0, reg_cons_1_m2=0, reg_cons_1_m1=0, __shared__ sh_cons_1_c0[24][32], reg_cons_1_p1=0, reg_cons_1_p2=0, reg_cons_1_p3=0, reg_cons_1_p4=0;
  float reg_cons_2_m4=0, reg_cons_2_m3=0, reg_cons_2_m2=0, reg_cons_2_m1=0, __shared__ sh_cons_2_c0[24][32], reg_cons_2_p1=0, reg_cons_2_p2=0, reg_cons_2_p3=0, reg_cons_2_p4=0;
  float reg_cons_3_m4=0, reg_cons_3_m3=0, reg_cons_3_m2=0, reg_cons_3_m1=0, __shared__ sh_cons_3_c0[24][32], reg_cons_3_p1=0, reg_cons_3_p2=0, reg_cons_3_p3=0, reg_cons_3_p4=0;
  float reg_cons_4_m4=0, reg_cons_4_m3=0, reg_cons_4_m2=0, reg_cons_4_m1=0, __shared__ sh_cons_4_c0[24][32], reg_cons_4_p1=0, reg_cons_4_p2=0, reg_cons_4_p3=0, reg_cons_4_p4=0;
  float __shared__ sh_q_1_c0[24][32];
  float __shared__ sh_q_2_c0[24][32];
  float reg_q_3_m4=0, reg_q_3_m3=0, reg_q_3_m2=0, reg_q_3_m1=0, reg_q_3_c0=0, reg_q_3_p1=0, reg_q_3_p2=0, reg_q_3_p3=0, reg_q_3_p4=0;
  float reg_q_4_m4=0, reg_q_4_m3=0, reg_q_4_m2=0, reg_q_4_m1=0, __shared__ sh_q_4_c0[24][32], reg_q_4_p1=0, reg_q_4_p2=0, reg_q_4_p3=0, reg_q_4_p4=0;

  //Value Initialization
  if (j <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
    reg_cons_1_m4 = cons_1[0 + j*N + i];
    reg_cons_1_m3 = cons_1[1*M*N + j*N + i];
    reg_cons_1_m2 = cons_1[2*M*N + j*N + i];
    reg_cons_1_m1 = cons_1[3*M*N + j*N + i];
    sh_cons_1_c0[j-j0+4][i-i0] = cons_1[4*M*N + j*N + i];
    reg_cons_1_p1 = cons_1[5*M*N + j*N + i];
    reg_cons_1_p2 = cons_1[6*M*N + j*N + i];
    reg_cons_1_p3 = cons_1[7*M*N + j*N + i];
    reg_cons_2_m4 = cons_2[0 + j*N + i];
    reg_cons_2_m3 = cons_2[1*M*N + j*N + i];
    reg_cons_2_m2 = cons_2[2*M*N + j*N + i];
    reg_cons_2_m1 = cons_2[3*M*N + j*N + i];
    sh_cons_2_c0[j-j0+4][i-i0] = cons_2[4*M*N + j*N + i];
    reg_cons_2_p1 = cons_2[5*M*N + j*N + i];
    reg_cons_2_p2 = cons_2[6*M*N + j*N + i];
    reg_cons_2_p3 = cons_2[7*M*N + j*N + i];
    reg_cons_3_m4 = cons_3[0 + j*N + i];
    reg_cons_3_m3 = cons_3[1*M*N + j*N + i];
    reg_cons_3_m2 = cons_3[2*M*N + j*N + i];
    reg_cons_3_m1 = cons_3[3*M*N + j*N + i];
    sh_cons_3_c0[j-j0+4][i-i0] = cons_3[4*M*N + j*N + i];
    reg_cons_3_p1 = cons_3[5*M*N + j*N + i];
    reg_cons_3_p2 = cons_3[6*M*N + j*N + i];
    reg_cons_3_p3 = cons_3[7*M*N + j*N + i];
    reg_cons_4_m4 = cons_4[0 + j*N + i];
    reg_cons_4_m3 = cons_4[1*M*N + j*N + i];
    reg_cons_4_m2 = cons_4[2*M*N + j*N + i];
    reg_cons_4_m1 = cons_4[3*M*N + j*N + i];
    sh_cons_4_c0[j-j0+4][i-i0] = cons_4[4*M*N + j*N + i];
    reg_cons_4_p1 = cons_4[5*M*N + j*N + i];
    reg_cons_4_p2 = cons_4[6*M*N + j*N + i];
    reg_cons_4_p3 = cons_4[7*M*N + j*N + i];
    reg_q_3_m4 = q_3[0 + j*N + i];
    reg_q_3_m3 = q_3[1*M*N + j*N + i];
    reg_q_3_m2 = q_3[2*M*N + j*N + i];
    reg_q_3_m1 = q_3[3*M*N + j*N + i];
    reg_q_3_c0 = q_3[4*M*N + j*N + i];
    reg_q_3_p1 = q_3[5*M*N + j*N + i];
    reg_q_3_p2 = q_3[6*M*N + j*N + i];
    reg_q_3_p3 = q_3[7*M*N + j*N + i];
    reg_q_4_m4 = q_4[0 + j*N + i];
    reg_q_4_m3 = q_4[1*M*N + j*N + i];
    reg_q_4_m2 = q_4[2*M*N + j*N + i];
    reg_q_4_m1 = q_4[3*M*N + j*N + i];
    sh_q_4_c0[j-j0+4][i-i0] = q_4[4*M*N + j*N + i];
    reg_q_4_p1 = q_4[5*M*N + j*N + i];
    reg_q_4_p2 = q_4[6*M*N + j*N + i];
    reg_q_4_p3 = q_4[7*M*N + j*N + i];
  }
  if(threadIdx.y < 4) {
   int jj = (j-4);
   if (jj <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
    sh_cons_1_c0[jj-j0+4][i-i0] = cons_1[4*M*N + jj*N + i];
    sh_cons_2_c0[jj-j0+4][i-i0] = cons_2[4*M*N + jj*N + i];
    sh_cons_3_c0[jj-j0+4][i-i0] = cons_3[4*M*N + jj*N + i];
    sh_cons_4_c0[jj-j0+4][i-i0] = cons_4[4*M*N + jj*N + i];
    sh_q_4_c0[jj-j0+4][i-i0] = q_4[4*M*N + jj*N + i];
   }
  } else if(threadIdx.y < 8) {
   int jj = (j-4)+16;
   if (jj <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
    sh_cons_1_c0[jj-j0+4][i-i0] = cons_1[4*M*N + jj*N + i];
    sh_cons_2_c0[jj-j0+4][i-i0] = cons_2[4*M*N + jj*N + i];
    sh_cons_3_c0[jj-j0+4][i-i0] = cons_3[4*M*N + jj*N + i];
    sh_cons_4_c0[jj-j0+4][i-i0] = cons_4[4*M*N + jj*N + i];
    sh_q_4_c0[jj-j0+4][i-i0] = q_4[4*M*N + jj*N + i];
   }
  }

  //Rest of the computation
  for (int k=4; k<=L-5; ++k) {
    //Fetch new plane
    if (j <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
        reg_cons_1_p4 = cons_1[(k+4)*M*N + j*N + i];
        reg_cons_2_p4 = cons_2[(k+4)*M*N + j*N + i];
        reg_cons_3_p4 = cons_3[(k+4)*M*N + j*N + i];
        reg_cons_4_p4 = cons_4[(k+4)*M*N + j*N + i];
        sh_q_1_c0[j-j0+4][i-i0] = q_1[k*M*N + j*N + i];
        sh_q_2_c0[j-j0+4][i-i0] = q_2[k*M*N + j*N + i];
        reg_q_3_p4 = q_3[(k+4)*M*N + j*N + i];
        reg_q_4_p4 = q_4[(k+4)*M*N + j*N + i];
    }
    if(threadIdx.y < 4) {
     int jj = (j-4);
     if (jj <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
        sh_cons_1_c0[jj-j0+4][i-i0] = cons_1[k*M*N + jj*N + i];
        sh_cons_2_c0[jj-j0+4][i-i0] = cons_2[k*M*N + jj*N + i];
        sh_cons_3_c0[jj-j0+4][i-i0] = cons_3[k*M*N + jj*N + i];
        sh_cons_4_c0[jj-j0+4][i-i0] = cons_4[k*M*N + jj*N + i];
     }
    } else if(threadIdx.y < 8) {
     int jj = (j-4)+16;
     if (jj <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
        sh_cons_1_c0[jj-j0+4][i-i0] = cons_1[k*M*N + jj*N + i];
        sh_cons_2_c0[jj-j0+4][i-i0] = cons_2[k*M*N + jj*N + i];
        sh_cons_3_c0[jj-j0+4][i-i0] = cons_3[k*M*N + jj*N + i];
        sh_cons_4_c0[jj-j0+4][i-i0] = cons_4[k*M*N + jj*N + i];
     }
    } else if(threadIdx.y < 12) {
     int jj = (j-12);
     if (jj <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
        sh_q_1_c0[jj-j0+4][i-i0] = q_1[k*M*N + jj*N + i];
        sh_q_2_c0[jj-j0+4][i-i0] = q_2[k*M*N + jj*N + i];
        sh_q_4_c0[jj-j0+4][i-i0] = q_4[k*M*N + jj*N + i];
     }
    } else {
     int jj = (j-12)+16;
     if (jj <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {
        sh_q_1_c0[jj-j0+4][i-i0] = q_1[k*M*N + jj*N + i];
        sh_q_2_c0[jj-j0+4][i-i0] = q_2[k*M*N + jj*N + i];
        sh_q_4_c0[jj-j0+4][i-i0] = q_4[k*M*N + jj*N + i];
     }
    }
    __syncthreads ();
	float r0,r1,r2,r3,r4;
    if ((j <= M-5) & i >= max (i0+4, 4) & i <= min (i0+blockdim_i-5, N-5)) {
	r0=flux_0[k*M*N + j*N + i], r1=flux_1[k*M*N + j*N + i], r2=flux_2[k*M*N + j*N + i], r3=flux_3[k*M*N + j*N + i], r4 = flux_4[k*M*N + j*N + i];
//	float r0=0.0f,r1=0.0f,r2=0.0f,r3=0.0f,r4=0.0f;
        r0 -= (((((0.8f * (sh_cons_1_c0[j-j0+4][i-i0+1] - sh_cons_1_c0[j-j0+4][i-i0-1])) - (0.2f * (sh_cons_1_c0[j-j0+4][i-i0+2] - sh_cons_1_c0[j-j0+4][i-i0-2]))) + (0.038f * (sh_cons_1_c0[j-j0+4][i-i0+3] - sh_cons_1_c0[j-j0+4][i-i0-3]))) - (0.0035f * (sh_cons_1_c0[j-j0+4][i-i0+4] - sh_cons_1_c0[j-j0+4][i-i0-4]))) * dxinv0);
        r0 -= (((((0.8f * (sh_cons_2_c0[j-j0+4+1][i-i0] - sh_cons_2_c0[j-j0+4-1][i-i0])) - (0.2f * (sh_cons_2_c0[j-j0+4+2][i-i0] - sh_cons_2_c0[j-j0+4-2][i-i0]))) + (0.038f * (sh_cons_2_c0[j-j0+4+3][i-i0] - sh_cons_2_c0[j-j0+4-3][i-i0]))) - (0.0035f * (sh_cons_2_c0[j-j0+4+4][i-i0] - sh_cons_2_c0[j-j0+4-4][i-i0]))) * dxinv1);
        r0 -= (((((0.8f * (reg_cons_3_p1 - reg_cons_3_m1)) - (0.2f * (reg_cons_3_p2 - reg_cons_3_m2))) + (0.038f * (reg_cons_3_p3 - reg_cons_3_m3))) - (0.0035f * (reg_cons_3_p4 - reg_cons_3_m4))) * dxinv2);
	flux_0[k*M*N + j*N + i] = r0;
        r1 -= (((((0.8f * (((sh_cons_1_c0[j-j0+4][i-i0+1] * sh_q_1_c0[j-j0+4][i-i0+1]) - (sh_cons_1_c0[j-j0+4][i-i0-1] * sh_q_1_c0[j-j0+4][i-i0-1])) + (sh_q_4_c0[j-j0+4][i-i0+1] - sh_q_4_c0[j-j0+4][i-i0-1]))) - (0.2f * (((sh_cons_1_c0[j-j0+4][i-i0+2] * sh_q_1_c0[j-j0+4][i-i0+2]) - (sh_cons_1_c0[j-j0+4][i-i0-2] * sh_q_1_c0[j-j0+4][i-i0-2])) + (sh_q_4_c0[j-j0+4][i-i0+2] - sh_q_4_c0[j-j0+4][i-i0-2])))) + (0.038f * (((sh_cons_1_c0[j-j0+4][i-i0+3] * sh_q_1_c0[j-j0+4][i-i0+3]) - (sh_cons_1_c0[j-j0+4][i-i0-3] * sh_q_1_c0[j-j0+4][i-i0-3])) + (sh_q_4_c0[j-j0+4][i-i0+3] - sh_q_4_c0[j-j0+4][i-i0-3])))) - (0.0035f * (((sh_cons_1_c0[j-j0+4][i-i0+4] * sh_q_1_c0[j-j0+4][i-i0+4]) - (sh_cons_1_c0[j-j0+4][i-i0-4] * sh_q_1_c0[j-j0+4][i-i0-4])) + (sh_q_4_c0[j-j0+4][i-i0+4] - sh_q_4_c0[j-j0+4][i-i0-4])))) * dxinv0);
        r1 -= (((((0.8f * ((sh_cons_1_c0[j-j0+4+1][i-i0] * sh_q_2_c0[j-j0+4+1][i-i0]) - (sh_cons_1_c0[j-j0+4-1][i-i0] * sh_q_2_c0[j-j0+4-1][i-i0]))) - (0.2f * ((sh_cons_1_c0[j-j0+4+2][i-i0] * sh_q_2_c0[j-j0+4+2][i-i0]) - (sh_cons_1_c0[j-j0+4-2][i-i0] * sh_q_2_c0[j-j0+4-2][i-i0])))) + (0.038f * ((sh_cons_1_c0[j-j0+4+3][i-i0] * sh_q_2_c0[j-j0+4+3][i-i0]) - (sh_cons_1_c0[j-j0+4-3][i-i0] * sh_q_2_c0[j-j0+4-3][i-i0])))) - (0.0035f * ((sh_cons_1_c0[j-j0+4+4][i-i0] * sh_q_2_c0[j-j0+4+4][i-i0]) - (sh_cons_1_c0[j-j0+4-4][i-i0] * sh_q_2_c0[j-j0+4-4][i-i0])))) * dxinv1);
        r1 -= (((((0.8f * ((reg_cons_1_p1 * reg_q_3_p1) - (reg_cons_1_m1 * reg_q_3_m1))) - (0.2f * ((reg_cons_1_p2 * reg_q_3_p2) - (reg_cons_1_m2 * reg_q_3_m2)))) + (0.038f * ((reg_cons_1_p3 * reg_q_3_p3) - (reg_cons_1_m3 * reg_q_3_m3)))) - (0.0035f * ((reg_cons_1_p4 * reg_q_3_p4) - (reg_cons_1_m4 * reg_q_3_m4)))) * dxinv2);
	flux_1[k*M*N + j*N + i] = r1;
        r2 -= (((((0.8f * ((sh_cons_2_c0[j-j0+4][i-i0+1] * sh_q_1_c0[j-j0+4][i-i0+1]) - (sh_cons_2_c0[j-j0+4][i-i0-1] * sh_q_1_c0[j-j0+4][i-i0-1]))) - (0.2f * ((sh_cons_2_c0[j-j0+4][i-i0+2] * sh_q_1_c0[j-j0+4][i-i0+2]) - (sh_cons_2_c0[j-j0+4][i-i0-2] * sh_q_1_c0[j-j0+4][i-i0-2])))) + (0.038f * ((sh_cons_2_c0[j-j0+4][i-i0+3] * sh_q_1_c0[j-j0+4][i-i0+3]) - (sh_cons_2_c0[j-j0+4][i-i0-3] * sh_q_1_c0[j-j0+4][i-i0-3])))) - (0.0035f * ((sh_cons_2_c0[j-j0+4][i-i0+4] * sh_q_1_c0[j-j0+4][i-i0+4]) - (sh_cons_2_c0[j-j0+4][i-i0-4] * sh_q_1_c0[j-j0+4][i-i0-4])))) * dxinv0);
        r2 -= (((((0.8f * (((sh_cons_2_c0[j-j0+4+1][i-i0] * sh_q_2_c0[j-j0+4+1][i-i0]) - (sh_cons_2_c0[j-j0+4-1][i-i0] * sh_q_2_c0[j-j0+4-1][i-i0])) + (sh_q_4_c0[j-j0+4+1][i-i0] - sh_q_4_c0[j-j0+4-1][i-i0]))) - (0.2f * (((sh_cons_2_c0[j-j0+4+2][i-i0] * sh_q_2_c0[j-j0+4+2][i-i0]) - (sh_cons_2_c0[j-j0+4-2][i-i0] * sh_q_2_c0[j-j0+4-2][i-i0])) + (sh_q_4_c0[j-j0+4+2][i-i0] - sh_q_4_c0[j-j0+4-2][i-i0])))) + (0.038f * (((sh_cons_2_c0[j-j0+4+3][i-i0] * sh_q_2_c0[j-j0+4+3][i-i0]) - (sh_cons_2_c0[j-j0+4-3][i-i0] * sh_q_2_c0[j-j0+4-3][i-i0])) + (sh_q_4_c0[j-j0+4+3][i-i0] - sh_q_4_c0[j-j0+4-3][i-i0])))) - (0.0035f * (((sh_cons_2_c0[j-j0+4+4][i-i0] * sh_q_2_c0[j-j0+4+4][i-i0]) - (sh_cons_2_c0[j-j0+4-4][i-i0] * sh_q_2_c0[j-j0+4-4][i-i0])) + (sh_q_4_c0[j-j0+4+4][i-i0] - sh_q_4_c0[j-j0+4-4][i-i0])))) * dxinv1);
        r2 -= (((((0.8f * ((reg_cons_2_p1 * reg_q_3_p1) - (reg_cons_2_m1 * reg_q_3_m1))) - (0.2f * ((reg_cons_2_p2 * reg_q_3_p2) - (reg_cons_2_m2 * reg_q_3_m2)))) + (0.038f * ((reg_cons_2_p3 * reg_q_3_p3) - (reg_cons_2_m3 * reg_q_3_m3)))) - (0.0035f * ((reg_cons_2_p4 * reg_q_3_p4) - (reg_cons_2_m4 * reg_q_3_m4)))) * dxinv2);
	flux_2[k*M*N + j*N + i] = r2;
        r3 -= (((((0.8f * ((sh_cons_3_c0[j-j0+4][i-i0+1] * sh_q_1_c0[j-j0+4][i-i0+1]) - (sh_cons_3_c0[j-j0+4][i-i0-1] * sh_q_1_c0[j-j0+4][i-i0-1]))) - (0.2f * ((sh_cons_3_c0[j-j0+4][i-i0+2] * sh_q_1_c0[j-j0+4][i-i0+2]) - (sh_cons_3_c0[j-j0+4][i-i0-2] * sh_q_1_c0[j-j0+4][i-i0-2])))) + (0.038f * ((sh_cons_3_c0[j-j0+4][i-i0+3] * sh_q_1_c0[j-j0+4][i-i0+3]) - (sh_cons_3_c0[j-j0+4][i-i0-3] * sh_q_1_c0[j-j0+4][i-i0-3])))) - (0.0035f * ((sh_cons_3_c0[j-j0+4][i-i0+4] * sh_q_1_c0[j-j0+4][i-i0+4]) - (sh_cons_3_c0[j-j0+4][i-i0-4] * sh_q_1_c0[j-j0+4][i-i0-4])))) * dxinv0);
        r3 -= (((((0.8f * ((sh_cons_3_c0[j-j0+4+1][i-i0] * sh_q_2_c0[j-j0+4+1][i-i0]) - (sh_cons_3_c0[j-j0+4-1][i-i0] * sh_q_2_c0[j-j0+4-1][i-i0]))) - (0.2f * ((sh_cons_3_c0[j-j0+4+2][i-i0] * sh_q_2_c0[j-j0+4+2][i-i0]) - (sh_cons_3_c0[j-j0+4-2][i-i0] * sh_q_2_c0[j-j0+4-2][i-i0])))) + (0.038f * ((sh_cons_3_c0[j-j0+4+3][i-i0] * sh_q_2_c0[j-j0+4+3][i-i0]) - (sh_cons_3_c0[j-j0+4-3][i-i0] * sh_q_2_c0[j-j0+4-3][i-i0])))) - (0.0035f * ((sh_cons_3_c0[j-j0+4+4][i-i0] * sh_q_2_c0[j-j0+4+4][i-i0]) - (sh_cons_3_c0[j-j0+4-4][i-i0] * sh_q_2_c0[j-j0+4-4][i-i0])))) * dxinv1);
        r3 -= (((((0.8f * (((reg_cons_3_p1 * reg_q_3_p1) - (reg_cons_3_m1 * reg_q_3_m1)) + (reg_q_4_p1 - reg_q_4_m1))) - (0.2f * (((reg_cons_3_p2 * reg_q_3_p2) - (reg_cons_3_m2 * reg_q_3_m2)) + (reg_q_4_p2 - reg_q_4_m2)))) + (0.038f * (((reg_cons_3_p3 * reg_q_3_p3) - (reg_cons_3_m3 * reg_q_3_m3)) + (reg_q_4_p3 - reg_q_4_m3)))) - (0.0035f * (((reg_cons_3_p4 * reg_q_3_p4) - (reg_cons_3_m4 * reg_q_3_m4)) + (reg_q_4_p4 - reg_q_4_m4)))) * dxinv2);
	flux_3[k*M*N + j*N + i] = r3;
        r4 -= (((((0.8f * (((sh_cons_4_c0[j-j0+4][i-i0+1] * sh_q_1_c0[j-j0+4][i-i0+1]) - (sh_cons_4_c0[j-j0+4][i-i0-1] * sh_q_1_c0[j-j0+4][i-i0-1])) + ((sh_q_4_c0[j-j0+4][i-i0+1] * sh_q_1_c0[j-j0+4][i-i0+1]) - (sh_q_4_c0[j-j0+4][i-i0-1] * sh_q_1_c0[j-j0+4][i-i0-1])))) - (0.2f * (((sh_cons_4_c0[j-j0+4][i-i0+2] * sh_q_1_c0[j-j0+4][i-i0+2]) - (sh_cons_4_c0[j-j0+4][i-i0-2] * sh_q_1_c0[j-j0+4][i-i0-2])) + ((sh_q_4_c0[j-j0+4][i-i0+2] * sh_q_1_c0[j-j0+4][i-i0+2]) - (sh_q_4_c0[j-j0+4][i-i0-2] * sh_q_1_c0[j-j0+4][i-i0-2]))))) + (0.038f * (((sh_cons_4_c0[j-j0+4][i-i0+3] * sh_q_1_c0[j-j0+4][i-i0+3]) - (sh_cons_4_c0[j-j0+4][i-i0-3] * sh_q_1_c0[j-j0+4][i-i0-3])) + ((sh_q_4_c0[j-j0+4][i-i0+3] * sh_q_1_c0[j-j0+4][i-i0+3]) - (sh_q_4_c0[j-j0+4][i-i0-3] * sh_q_1_c0[j-j0+4][i-i0-3]))))) - (0.0035f * (((sh_cons_4_c0[j-j0+4][i-i0+4] * sh_q_1_c0[j-j0+4][i-i0+4]) - (sh_cons_4_c0[j-j0+4][i-i0-4] * sh_q_1_c0[j-j0+4][i-i0-4])) + ((sh_q_4_c0[j-j0+4][i-i0+4] * sh_q_1_c0[j-j0+4][i-i0+4]) - (sh_q_4_c0[j-j0+4][i-i0-4] * sh_q_1_c0[j-j0+4][i-i0-4]))))) * dxinv0);
        r4 -= (((((0.8f * (((sh_cons_4_c0[j-j0+4+1][i-i0] * sh_q_2_c0[j-j0+4+1][i-i0]) - (sh_cons_4_c0[j-j0+4-1][i-i0] * sh_q_2_c0[j-j0+4-1][i-i0])) + ((sh_q_4_c0[j-j0+4+1][i-i0] * sh_q_2_c0[j-j0+4+1][i-i0]) - (sh_q_4_c0[j-j0+4-1][i-i0] * sh_q_2_c0[j-j0+4-1][i-i0])))) - (0.2f * (((sh_cons_4_c0[j-j0+4+2][i-i0] * sh_q_2_c0[j-j0+4+2][i-i0]) - (sh_cons_4_c0[j-j0+4-2][i-i0] * sh_q_2_c0[j-j0+4-2][i-i0])) + ((sh_q_4_c0[j-j0+4+2][i-i0] * sh_q_2_c0[j-j0+4+2][i-i0]) - (sh_q_4_c0[j-j0+4-2][i-i0] * sh_q_2_c0[j-j0+4-2][i-i0]))))) + (0.038f * (((sh_cons_4_c0[j-j0+4+3][i-i0] * sh_q_2_c0[j-j0+4+3][i-i0]) - (sh_cons_4_c0[j-j0+4-3][i-i0] * sh_q_2_c0[j-j0+4-3][i-i0])) + ((sh_q_4_c0[j-j0+4+3][i-i0] * sh_q_2_c0[j-j0+4+3][i-i0]) - (sh_q_4_c0[j-j0+4-3][i-i0] * sh_q_2_c0[j-j0+4-3][i-i0]))))) - (0.0035f * (((sh_cons_4_c0[j-j0+4+4][i-i0] * sh_q_2_c0[j-j0+4+4][i-i0]) - (sh_cons_4_c0[j-j0+4-4][i-i0] * sh_q_2_c0[j-j0+4-4][i-i0])) + ((sh_q_4_c0[j-j0+4+4][i-i0] * sh_q_2_c0[j-j0+4+4][i-i0]) - (sh_q_4_c0[j-j0+4-4][i-i0] * sh_q_2_c0[j-j0+4-4][i-i0]))))) * dxinv1);
        r4 -= (((((0.8f * (((reg_cons_4_p1 * reg_q_3_p1) - (reg_cons_4_m1 * reg_q_3_m1)) + ((reg_q_4_p1 * reg_q_3_p1) - (reg_q_4_m1 * reg_q_3_m1)))) - (0.2f * (((reg_cons_4_p2 * reg_q_3_p2) - (reg_cons_4_m2 * reg_q_3_m2)) + ((reg_q_4_p2 * reg_q_3_p2) - (reg_q_4_m2 * reg_q_3_m2))))) + (0.038f * (((reg_cons_4_p3 * reg_q_3_p3) - (reg_cons_4_m3 * reg_q_3_m3)) + ((reg_q_4_p3 * reg_q_3_p3) - (reg_q_4_m3 * reg_q_3_m3))))) - (0.0035f * (((reg_cons_4_p4 * reg_q_3_p4) - (reg_cons_4_m4 * reg_q_3_m4)) + ((reg_q_4_p4 * reg_q_3_p4) - (reg_q_4_m4 * reg_q_3_m4))))) * dxinv2);
	flux_4[k*M*N + j*N + i] = r4;
    }
    __syncthreads ();
    //Value rotation


  if (j <= M-1 & i <= min (i0+blockdim_i-1, N-1)) {

    reg_cons_1_m4 = reg_cons_1_m3;
    reg_cons_1_m3 = reg_cons_1_m2;
    reg_cons_1_m2 = reg_cons_1_m1;
    reg_cons_1_m1 = sh_cons_1_c0[j-j0+4][i-i0];
    sh_cons_1_c0[j-j0+4][i-i0] = reg_cons_1_p1;
    reg_cons_1_p1 = reg_cons_1_p2;
    reg_cons_1_p2 = reg_cons_1_p3;
    reg_cons_1_p3 = reg_cons_1_p4;
    reg_cons_2_m4 = reg_cons_2_m3;
    reg_cons_2_m3 = reg_cons_2_m2;
    reg_cons_2_m2 = reg_cons_2_m1;
    reg_cons_2_m1 = sh_cons_2_c0[j-j0+4][i-i0];
    sh_cons_2_c0[j-j0+4][i-i0] = reg_cons_2_p1;
    reg_cons_2_p1 = reg_cons_2_p2;
    reg_cons_2_p2 = reg_cons_2_p3;
    reg_cons_2_p3 = reg_cons_2_p4;
    reg_cons_3_m4 = reg_cons_3_m3;
    reg_cons_3_m3 = reg_cons_3_m2;
    reg_cons_3_m2 = reg_cons_3_m1;
    reg_cons_3_m1 = sh_cons_3_c0[j-j0+4][i-i0];
    sh_cons_3_c0[j-j0+4][i-i0] = reg_cons_3_p1;
    reg_cons_3_p1 = reg_cons_3_p2;
    reg_cons_3_p2 = reg_cons_3_p3;
    reg_cons_3_p3 = reg_cons_3_p4;
    reg_cons_4_m4 = reg_cons_4_m3;
    reg_cons_4_m3 = reg_cons_4_m2;
    reg_cons_4_m2 = reg_cons_4_m1;
    reg_cons_4_m1 = sh_cons_4_c0[j-j0+4][i-i0];
    sh_cons_4_c0[j-j0+4][i-i0] = reg_cons_4_p1;
    reg_cons_4_p1 = reg_cons_4_p2;
    reg_cons_4_p2 = reg_cons_4_p3;
    reg_cons_4_p3 = reg_cons_4_p4;
    reg_q_3_m4 = reg_q_3_m3;
    reg_q_3_m3 = reg_q_3_m2;
    reg_q_3_m2 = reg_q_3_m1;
    reg_q_3_m1 = reg_q_3_c0;
    reg_q_3_c0 = reg_q_3_p1;
    reg_q_3_p1 = reg_q_3_p2;
    reg_q_3_p2 = reg_q_3_p3;
    reg_q_3_p3 = reg_q_3_p4;
    reg_q_4_m4 = reg_q_4_m3;
    reg_q_4_m3 = reg_q_4_m2;
    reg_q_4_m2 = reg_q_4_m1;
    reg_q_4_m1 = sh_q_4_c0[j-j0+4][i-i0];
    sh_q_4_c0[j-j0+4][i-i0] = reg_q_4_p1;
    reg_q_4_p1 = reg_q_4_p2;
    reg_q_4_p2 = reg_q_4_p3;
    reg_q_4_p3 = reg_q_4_p4;
   }
  }
}

extern "C" void host_code (float *h_flux_0, float *h_flux_1, float *h_flux_2, float *h_flux_3, float *h_flux_4, float *h_cons_1, float *h_cons_2, float *h_cons_3, float *h_cons_4, float *h_q_1, float *h_q_2, float *h_q_3, float *h_q_4, float dxinv0, float dxinv1, float dxinv2, int L, int M, int N) {
  float *flux_0;
  cudaMalloc (&flux_0, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for flux_0\n");
  cudaMemcpy (flux_0, h_flux_0, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *flux_1;
  cudaMalloc (&flux_1, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for flux_1\n");
  cudaMemcpy (flux_1, h_flux_1, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *flux_2;
  cudaMalloc (&flux_2, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for flux_2\n");
  cudaMemcpy (flux_2, h_flux_2, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *flux_3;
  cudaMalloc (&flux_3, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for flux_3\n");
  cudaMemcpy (flux_3, h_flux_3, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *flux_4;
  cudaMalloc (&flux_4, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for flux_4\n");
  cudaMemcpy (flux_4, h_flux_4, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *cons_1;
  cudaMalloc (&cons_1, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for cons_1\n");
  cudaMemcpy (cons_1, h_cons_1, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *cons_2;
  cudaMalloc (&cons_2, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for cons_2\n");
  cudaMemcpy (cons_2, h_cons_2, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *cons_3;
  cudaMalloc (&cons_3, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for cons_3\n");
  cudaMemcpy (cons_3, h_cons_3, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *cons_4;
  cudaMalloc (&cons_4, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for cons_4\n");
  cudaMemcpy (cons_4, h_cons_4, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *q_1;
  cudaMalloc (&q_1, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for q_1\n");
  cudaMemcpy (q_1, h_q_1, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *q_2;
  cudaMalloc (&q_2, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for q_2\n");
  cudaMemcpy (q_2, h_q_2, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *q_3;
  cudaMalloc (&q_3, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for q_3\n");
  cudaMemcpy (q_3, h_q_3, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);
  float *q_4;
  cudaMalloc (&q_4, sizeof(float)*L*M*N);
  check_error ("Failed to allocate device memory for q_4\n");
  cudaMemcpy (q_4, h_q_4, sizeof(float)*L*M*N, cudaMemcpyHostToDevice);

  dim3 blockconfig_1 (32, 16, 1);
  dim3 gridconfig_1 (ceil(N, blockconfig_1.x-8), ceil(M-8, blockconfig_1.y), 1);
  hypterm <<<gridconfig_1, blockconfig_1>>> (flux_0, flux_1, flux_2, flux_3, flux_4, cons_1, cons_2, cons_3, cons_4, q_1, q_2, q_3, q_4, dxinv0, dxinv1, dxinv2, L, M, N);

  cudaMemcpy (h_flux_0, flux_0, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
  cudaMemcpy (h_flux_1, flux_1, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
  cudaMemcpy (h_flux_2, flux_2, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
  cudaMemcpy (h_flux_3, flux_3, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);
  cudaMemcpy (h_flux_4, flux_4, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);

  //Free allocated memory
  cudaFree (flux_0);
  cudaFree (flux_1);
  cudaFree (flux_2);
  cudaFree (flux_3);
  cudaFree (flux_4);
  cudaFree (cons_1);
  cudaFree (cons_2);
  cudaFree (cons_3);
  cudaFree (cons_4);
  cudaFree (q_1);
  cudaFree (q_2);
  cudaFree (q_3);
  cudaFree (q_4);
}
