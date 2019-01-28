/* --------------------------------------------------------------------
   OPTIMIZED CODE MAKING USE OF REGISTERS + SHARED MEMORY
   ----------------------------------------------------------------------*/


#include <stdio.h>
#include "cuda.h"
#define max(x,y)  ((x) > (y)? (x) : (y))
#define min(x,y)  ((x) < (y)? (x) : (y))
#define ceil(a,b) ((a) % (b) == 0 ? (a) / (b) : ((a) / (b)) + 1)
#include <nvml.h>
#include <assert.h>


void check_error (const char* message) {
	cudaError_t error = cudaGetLastError ();
	if (error != cudaSuccess) {
		printf ("CUDA error : %s, %s\n", message, cudaGetErrorString (error));
		exit(-1);
	}
}

__global__ void cheby (double h2inv, double a, double b, double c, double d, double * __restrict__ RHS, double * __restrict__ Ap, double * __restrict__ Dinv, double * __restrict__ Ac, double * __restrict__ out, int L, int M, int N, double * __restrict__ out1) {
	//Determing the block's indices
	int blockdim_i= (int)(blockDim.x);
	int i0 = (int)(blockIdx.x)*(blockdim_i-4);
	int i = max (i0, 0) + (int)(threadIdx.x);
	int blockdim_j= (int)(blockDim.y);
	int j0 = (int)(blockIdx.y)*(blockdim_j-4);
	int j = max (j0, 0) + (int)(threadIdx.y);

	//Declarations
	double reg_Ac_m2=0, reg_Ac_m1=0, __shared__ sh_Ac_c0[16][32];
	double reg_Ap_m1=0;
	double reg_Dinv_m2=0, reg_Dinv_m1=0;
	double reg_RHS_m2=0, reg_RHS_m1=0;
	double reg_out1_m2=0, __shared__ sh_out1_m1[16][32];
	double reg_temp1_m1=0, reg_temp1_c0=0, reg_temp1_p1=0;
	double reg_temp2_m2=0, reg_temp2_m1=0, reg_temp2_c0=0;

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

extern "C" void host_code (double *h_Ac, double *h_Ap, double *h_Dinv, double *h_RHS, double *h_out, double *c1, double *c2, double h2inv, int L, int M, int N) {
	double *Ac;
	cudaMalloc (&Ac, sizeof(double)*L*M*N);
	check_error ("Failed to allocate device memory for Ac\n");
	cudaMemcpy (Ac, h_Ac, sizeof(double)*L*M*N, cudaMemcpyHostToDevice);
	double *Ap;
	cudaMalloc (&Ap, sizeof(double)*L*M*N);
	check_error ("Failed to allocate device memory for Ap\n");
	cudaMemcpy (Ap, h_Ap, sizeof(double)*L*M*N, cudaMemcpyHostToDevice);
	double *Dinv;
	cudaMalloc (&Dinv, sizeof(double)*L*M*N);
	check_error ("Failed to allocate device memory for Dinv\n");
	cudaMemcpy (Dinv, h_Dinv, sizeof(double)*L*M*N, cudaMemcpyHostToDevice);
	double *RHS;
	cudaMalloc (&RHS, sizeof(double)*L*M*N);
	check_error ("Failed to allocate device memory for RHS\n");
	cudaMemcpy (RHS, h_RHS, sizeof(double)*L*M*N, cudaMemcpyHostToDevice);
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
	dim3 blockconfig_1 (32, 16, 1);
	dim3 gridconfig_1 (ceil(N, blockconfig_1.x-4), ceil(M, blockconfig_1.y-4), 1);
	dim3 blockconfig_2 (32, 16, 1);
	dim3 gridconfig_2 (ceil(N, blockconfig_2.x-4), ceil(M, blockconfig_2.y-4), 1);

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
		cheby <<<gridconfig_1, blockconfig_1>>> (h2inv, c1[0], c2[0], c1[1], c2[1], RHS, Ap, Dinv, Ac, out2, L, M, N, out1);
		cheby <<<gridconfig_2, blockconfig_2>>> (h2inv, c1[2], c2[2], c1[3], c2[3], RHS, out1, Dinv, out2, out, L, M, N, out3);
	}

	cudaDeviceSynchronize();
	result=nvmlDeviceGetPowerUsage(device,&power2);
	assert(NVML_SUCCESS == result);
	power2 -= power1;
	printf("%u\n", power2);
	nvmlShutdown();
	cudaMemcpy (h_out, out, sizeof(double)*L*M*N, cudaMemcpyDeviceToHost);
}
