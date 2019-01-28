#include <stdio.h>
#include "cuda.h"
#include <nvml.h>
#include <assert.h>


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

__global__ void possion (float * __restrict__ in, float * __restrict__ out, float * __restrict__ out1, float * __restrict__ out2, float * __restrict__ out3, int L, int M, int N) {
	//Determining the block's indices
	int blockdim_i= (int)(blockDim.x);
	int i0 = (int)(blockIdx.x)*(blockdim_i-8);
	int i = i0 + (int)(threadIdx.x);
	int blockdim_j= (int)(blockDim.y);
	int j0 = (int)(blockIdx.y)*(blockdim_j-8);
	int j = j0 + (int)(threadIdx.y);

	//Declarations
	float __shared__ sh_in_c0[32][32];
	float __shared__ sh_out_m1[32][32];
	float reg_out_c0=0, reg_out_p1=0;
	float __shared__ sh_out1_m2[32][32];
	float reg_out1_m1=0, reg_out1_c0=0;
	float __shared__ sh_out2_m3[32][32];
	float reg_out2_m2=0, reg_out2_m1=0;
	float reg_out3_m4=0, reg_out3_m3=0, reg_out3_m2=0;

	//Value Initialization
	if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
		sh_in_c0[j-j0][i-i0] = 0;
		sh_out_m1[j-j0][i-i0] = 0;
		sh_out1_m2[j-j0][i-i0] = 0;
		sh_out2_m3[j-j0][i-i0] = 0;
	}
	//Rest of the computation
#pragma unroll 2
	for (int k=0; k<=L-1; ++k) {
		//Fetch new plane
		if (j <= min (j0+blockdim_j-1, M-1) & i <= min (i0+blockdim_i-1, N-1)) {
			sh_in_c0[j-j0][i-i0] = in[k*M*N + j*N + i];
		}
		__syncthreads ();
		if (j >= j0+1 & j <= min (j0+blockdim_j-2, M-2) & i >= i0+1 & i <= min (i0+blockdim_i-2, N-2)) {
			reg_out_c0 += (((2.666f * sh_in_c0[j-j0][i-i0]) - (0.166f * (((sh_in_c0[j-j0-1][i-i0] + sh_in_c0[j-j0+1][i-i0]) + sh_in_c0[j-j0][i-i0+1]) + sh_in_c0[j-j0][i-i0-1]))) - (0.0833f * (((sh_in_c0[j-j0-1][i-i0-1] + sh_in_c0[j-j0+1][i-i0-1]) + sh_in_c0[j-j0-1][i-i0+1]) + sh_in_c0[j-j0+1][i-i0+1])));
			reg_out_p1 += ((-(0.166f) * sh_in_c0[j-j0][i-i0]) - (0.0833f * (((sh_in_c0[j-j0-1][i-i0] + sh_in_c0[j-j0+1][i-i0]) + sh_in_c0[j-j0][i-i0-1]) + sh_in_c0[j-j0][i-i0+1])));
			sh_out_m1[j-j0][i-i0] += ((-(0.166f) * sh_in_c0[j-j0][i-i0]) - (0.0833f * (((sh_in_c0[j-j0-1][i-i0] + sh_in_c0[j-j0+1][i-i0]) + sh_in_c0[j-j0][i-i0-1]) + sh_in_c0[j-j0][i-i0+1])));
		}
		__syncthreads ();
		if (j >= j0+2 & j <= min (j0+blockdim_j-3, M-2) & i >= i0+2 & i <= min (i0+blockdim_i-3, N-2)) {
			reg_out1_m1 += (((2.666f * sh_out_m1[j-j0][i-i0]) - (0.166f * (((sh_out_m1[j-j0-1][i-i0] + sh_out_m1[j-j0+1][i-i0]) + sh_out_m1[j-j0][i-i0+1]) + sh_out_m1[j-j0][i-i0-1]))) - (0.0833f * (((sh_out_m1[j-j0-1][i-i0-1] + sh_out_m1[j-j0+1][i-i0-1]) + sh_out_m1[j-j0-1][i-i0+1]) + sh_out_m1[j-j0+1][i-i0+1])));
			reg_out1_c0 += ((-(0.166f) * sh_out_m1[j-j0][i-i0]) - (0.0833f * (((sh_out_m1[j-j0-1][i-i0] + sh_out_m1[j-j0+1][i-i0]) + sh_out_m1[j-j0][i-i0-1]) + sh_out_m1[j-j0][i-i0+1])));
			sh_out1_m2[j-j0][i-i0] += ((-(0.166f) * sh_out_m1[j-j0][i-i0]) - (0.0833f * (((sh_out_m1[j-j0-1][i-i0] + sh_out_m1[j-j0+1][i-i0]) + sh_out_m1[j-j0][i-i0-1]) + sh_out_m1[j-j0][i-i0+1])));
		}
		__syncthreads ();
		if (j >= j0+3 & j <= min (j0+blockdim_j-4, M-2) & i >= i0+3 & i <= min (i0+blockdim_i-4, N-2)) {
			reg_out2_m2 += (((2.666f * sh_out1_m2[j-j0][i-i0]) - (0.166f * (((sh_out1_m2[j-j0-1][i-i0] + sh_out1_m2[j-j0+1][i-i0]) + sh_out1_m2[j-j0][i-i0+1]) + sh_out1_m2[j-j0][i-i0-1]))) - (0.0833f * (((sh_out1_m2[j-j0-1][i-i0-1] + sh_out1_m2[j-j0+1][i-i0-1]) + sh_out1_m2[j-j0-1][i-i0+1]) + sh_out1_m2[j-j0+1][i-i0+1])));
			reg_out2_m1 += ((-(0.166f) * sh_out1_m2[j-j0][i-i0]) - (0.0833f * (((sh_out1_m2[j-j0-1][i-i0] + sh_out1_m2[j-j0+1][i-i0]) + sh_out1_m2[j-j0][i-i0-1]) + sh_out1_m2[j-j0][i-i0+1])));
			sh_out2_m3[j-j0][i-i0] += ((-(0.166f) * sh_out1_m2[j-j0][i-i0]) - (0.0833f * (((sh_out1_m2[j-j0-1][i-i0] + sh_out1_m2[j-j0+1][i-i0]) + sh_out1_m2[j-j0][i-i0-1]) + sh_out1_m2[j-j0][i-i0+1])));
		}
		__syncthreads ();
		if (j >= j0+4 & j <= min (j0+blockdim_j-5, M-2) & i >= i0+4 & i <= min (i0+blockdim_i-5, N-2)) {
			reg_out3_m3 += (((2.666f * sh_out2_m3[j-j0][i-i0]) - (0.166f * (((sh_out2_m3[j-j0-1][i-i0] + sh_out2_m3[j-j0+1][i-i0]) + sh_out2_m3[j-j0][i-i0+1]) + sh_out2_m3[j-j0][i-i0-1]))) - (0.0833f * (((sh_out2_m3[j-j0-1][i-i0-1] + sh_out2_m3[j-j0+1][i-i0-1]) + sh_out2_m3[j-j0-1][i-i0+1]) + sh_out2_m3[j-j0+1][i-i0+1])));
			reg_out3_m2 += ((-(0.166f) * sh_out2_m3[j-j0][i-i0]) - (0.0833f * (((sh_out2_m3[j-j0-1][i-i0] + sh_out2_m3[j-j0+1][i-i0]) + sh_out2_m3[j-j0][i-i0-1]) + sh_out2_m3[j-j0][i-i0+1])));
			reg_out3_m4 += ((-(0.166f) * sh_out2_m3[j-j0][i-i0]) - (0.0833f * (((sh_out2_m3[j-j0-1][i-i0] + sh_out2_m3[j-j0+1][i-i0]) + sh_out2_m3[j-j0][i-i0-1]) + sh_out2_m3[j-j0][i-i0+1])));
			out3[max(k-4,0)*M*N + j*N + i] = reg_out3_m4;
		}
		__syncthreads ();
		//Value rotation
		sh_out_m1[j-j0][i-i0] = reg_out_c0;
		reg_out_c0 = reg_out_p1;
		reg_out_p1 = 0;
		sh_out1_m2[j-j0][i-i0] = reg_out1_m1;
		reg_out1_m1 = reg_out1_c0;
		reg_out1_c0 = 0;
		sh_out2_m3[j-j0][i-i0] = reg_out2_m2;
		reg_out2_m2 = reg_out2_m1;
		reg_out2_m1 = 0;
		reg_out3_m4 = reg_out3_m3;
		reg_out3_m3 = reg_out3_m2;
		reg_out3_m2 = 0;
	}
}

extern "C" void host_code (float *h_in, float *h_out3, int L, int M, int N) {
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
	float *out3;
	cudaMalloc (&out3, sizeof(float)*L*M*N);
	check_error ("Failed to allocate device memory for out3\n");
	float *out;
	cudaMalloc (&out, sizeof(float)*L*M*N);
	check_error ("Failed to allocate device memory for out\n");

	dim3 blockconfig_1 (32, 32, 1);
	dim3 gridconfig_1 (ceil(N, blockconfig_1.x-8), ceil(M, blockconfig_1.y-8), 1);

	unsigned int power1, power2;
	nvmlReturn_t result;
	nvmlDevice_t device;
	nvmlEnableState_t mode;
	result=nvmlInit();
	result = nvmlDeviceGetHandleByIndex(0, &device);
	assert(NVML_SUCCESS == result);
	result=nvmlDeviceGetPowerManagementMode(device, &mode);
	printf("enabled = %d\n", mode);
	result=nvmlDeviceGetPowerUsage(device,&power1);
	assert(NVML_SUCCESS == result);
	cudaDeviceSynchronize();

	for (int x=0; x<500; x++) {
		possion <<<gridconfig_1, blockconfig_1>>> (in, out, out1, out2, out3, L, M, N);
	}

	cudaDeviceSynchronize();
	result=nvmlDeviceGetPowerUsage(device,&power2);
	assert(NVML_SUCCESS == result);
	power2 -= power1;
	printf("%u\n", power2);
	nvmlShutdown();
	cudaMemcpy (h_out3, out3, sizeof(float)*L*M*N, cudaMemcpyDeviceToHost);

	//Free allocated memory
	cudaFree (in);
	cudaFree (out1);
	cudaFree (out2);
	cudaFree (out3);
	cudaFree (out);
}
