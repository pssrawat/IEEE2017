#include "cuda.h"
#ifdef _TIMER_
#include "cuda_profiler_api.h"
#endif
#include "stdio.h"
#include <nvml.h>
#include <assert.h>

#define FORMA_MAX(a,b) ( (a) > (b) ? (a) : (b) )
#define max(a,b) FORMA_MAX(a,b)
#define FORMA_MIN(a,b) ( (a) < (b) ? (a) : (b) )
#define min(a,b) FORMA_MIN(a,b)
#define FORMA_CEIL(a,b) ( (a) % (b) == 0 ? (a) / (b) : ((a) / (b)) + 1 )

#ifndef FORMA_MAX_BLOCKDIM_0
#define FORMA_MAX_BLOCKDIM_0 1024
#endif
#ifndef FORMA_MAX_BLOCKDIM_1
#define FORMA_MAX_BLOCKDIM_1 1024
#endif
#ifndef FORMA_MAX_BLOCKDIM_2
#define FORMA_MAX_BLOCKDIM_2 1024
#endif
	template<typename T>
__global__ void  __kernel_init__(T* input, T value)
{
	int loc = (int)(blockIdx.x)*(int)(blockDim.x)+(int)(threadIdx.x);
	input[loc] = value;
}


	template<typename T>
void initialize_array(T* d_input, int size, T value)
{
	dim3 init_grid(FORMA_CEIL(size,FORMA_MAX_BLOCKDIM_0));
	dim3 init_block(FORMA_MAX_BLOCKDIM_0);
	__kernel_init__<<<init_grid,init_block>>>(d_input,value);
}


void Check_CUDA_Error(const char* message);
/*Texture references */
/* Device code Begin */
__global__ void __kernel___forma_kernel__0__(double * __restrict__ input, int L, int M, int N, double * __restrict__ __var_4__){
	int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_0__;
	__iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 2;
	if(__iter_0__ <= (N-3)){
		int __iter_1__;
		__iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 2;
		if(__iter_1__ <= (M-3)){
			int __iter_2__;
			__iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 2;
			if(__iter_2__ <= (L-3)){
				double __temp_0__;
				__temp_0__ = (0.083000f * input[__iter_0__+(2)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				double __temp_1__;
				__temp_1__ = (0.083000f * input[__iter_0__+(1)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				double __temp_2__;
				__temp_2__ = (__temp_0__ + __temp_1__);
				double __temp_3__;
				__temp_3__ = (0.083000f * input[__iter_0__+(-1)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				double __temp_4__;
				__temp_4__ = (__temp_2__ + __temp_3__);
				double __temp_5__;
				__temp_5__ = (0.083000f * input[__iter_0__+(-2)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				double __temp_6__;
				__temp_6__ = (__temp_4__ + __temp_5__);
				double __temp_7__;
				__temp_7__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(2)+(M-0)*(__iter_2__))]);
				double __temp_8__;
				__temp_8__ = (__temp_6__ + __temp_7__);
				double __temp_9__;
				__temp_9__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__))]);
				double __temp_10__;
				__temp_10__ = (__temp_8__ + __temp_9__);
				double __temp_11__;
				__temp_11__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__))]);
				double __temp_12__;
				__temp_12__ = (__temp_10__ + __temp_11__);
				double __temp_13__;
				__temp_13__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(-2)+(M-0)*(__iter_2__))]);
				double __temp_14__;
				__temp_14__ = (__temp_12__ + __temp_13__);
				double __temp_15__;
				__temp_15__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__+(2)))]);
				double __temp_16__;
				__temp_16__ = (__temp_14__ + __temp_15__);
				double __temp_17__;
				__temp_17__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__+(1)))]);
				double __temp_18__;
				__temp_18__ = (__temp_16__ + __temp_17__);
				double __temp_19__;
				__temp_19__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__+(-1)))]);
				double __temp_20__;
				__temp_20__ = (__temp_18__ + __temp_19__);
				double __temp_21__;
				__temp_21__ = (0.083000f * input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__+(-2)))]);
				double __temp_22__;
				__temp_22__ = (__temp_20__ + __temp_21__);
				double __temp_23__;
				__temp_23__ = (0.996000f * input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				double __temp_24__;
				__temp_24__ = (__temp_22__ - __temp_23__);
				__var_4__[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))] = __temp_24__;
			}
		}
	}
}

/* Host Code Begin */
extern "C" void j3d13pt(double * h_input, int L, int M, int N, double * __var_0__){

	/* Host allocation Begin */
	double * input;
	cudaMalloc(&input,sizeof(double)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : input\n");
	cudaPointerAttributes ptrAttrib_h_input;
	cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
	if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
		if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
			memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
		cudaMemcpy(input,h_input,sizeof(double)*((L-0)*(M-0)*(N-0)), memcpy_kind_h_input);
	}
	double * __var_1__;
	cudaMalloc(&__var_1__,sizeof(double)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : __var_1__\n");
	double * __var_2__;
	cudaMalloc(&__var_2__,sizeof(double)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : __var_2__\n");
	double * __var_3__;
	cudaMalloc(&__var_3__,sizeof(double)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : __var_3__\n");
	double * __var_4__;
	cudaMalloc(&__var_4__,sizeof(double)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : __var_4__\n");
	/*Host Allocation End */
	/* Kernel Launch Begin */
#ifdef _TIMER_
	cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
	cudaEventCreate(&_forma_timer_start_);
	cudaEventCreate(&_forma_timer_stop_);
	cudaEventRecord(_forma_timer_start_,0);
#endif
	int __size_0___kernel___forma_kernel__0__ = ((N-3) - 2 ) + 1;
	int __size_1___kernel___forma_kernel__0__ = ((M-3) - 2 ) + 1;
	int __size_2___kernel___forma_kernel__0__ = ((L-3) - 2 ) + 1;
	int __block_0___kernel___forma_kernel__0__ = 16;
	int __block_1___kernel___forma_kernel__0__ = 4;
	int __block_2___kernel___forma_kernel__0__ = 4;
	dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
	int __SMemSize___kernel___forma_kernel__0__ = 0;
	int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
	int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
	int __grid_2___kernel___forma_kernel__0__ = FORMA_CEIL(__size_2___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
	dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);

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

		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __var_4__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_4__, L, M, N, __var_3__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_3__, L, M, N, __var_2__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, L, M, N, __var_1__);
		Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
	}

	cudaDeviceSynchronize();
	result=nvmlDeviceGetPowerUsage(device,&power2);
	assert(NVML_SUCCESS == result);
	power2 -= power1;
	printf("%u\n", power2);
	nvmlShutdown();
	cudaPointerAttributes ptrAttrib___var_0__;
	cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
	if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
		if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
			memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	cudaMemcpy(__var_0__,__var_1__, sizeof(double)*((L-0)*(M-0)*(N-0)), memcpy_kind___var_0__);
#ifdef _TIMER_
	cudaEventRecord(_forma_timer_stop_,0);
	cudaEventSynchronize(_forma_timer_stop_);
	float elapsedTime;
	cudaEventElapsedTime(&elapsedTime,_forma_timer_start_,_forma_timer_stop_);
	printf("[FORMA] Computation Time(ms) : %lf\n",elapsedTime);
	cudaEventDestroy(_forma_timer_start_);
	cudaEventDestroy(_forma_timer_stop_);
#endif
	/*Kernel Launch End */
	/* Host Free Begin */
	cudaFree(input);
	cudaFree(__var_1__);
	cudaFree(__var_2__);
	cudaFree(__var_3__);
	cudaFree(__var_4__);
}
/*Host Free End*/
