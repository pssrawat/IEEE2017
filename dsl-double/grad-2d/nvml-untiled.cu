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
__global__ void __kernel___forma_kernel__0__(double * __restrict__ input, int N, int M, double * __restrict__ __var_4__){
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_0__;
	__iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_0__ <= (M-2)){
		int __iter_1__;
		__iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_1__ <= (N-2)){
			double __temp_0__;
			__temp_0__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(M-0)*(__iter_1__+(-1))]);
			double __temp_1__;
			__temp_1__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(M-0)*(__iter_1__+(-1))]);
			double __temp_2__;
			__temp_2__ = (__temp_0__ * __temp_1__);
			double __temp_3__;
			__temp_3__ = (0.000100f + __temp_2__);
			double __temp_4__;
			__temp_4__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(M-0)*(__iter_1__+(1))]);
			double __temp_5__;
			__temp_5__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(M-0)*(__iter_1__+(1))]);
			double __temp_6__;
			__temp_6__ = (__temp_4__ * __temp_5__);
			double __temp_7__;
			__temp_7__ = (__temp_3__ + __temp_6__);
			double __temp_8__;
			__temp_8__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(1)+(M-0)*(__iter_1__)]);
			double __temp_9__;
			__temp_9__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(1)+(M-0)*(__iter_1__)]);
			double __temp_10__;
			__temp_10__ = (__temp_8__ * __temp_9__);
			double __temp_11__;
			__temp_11__ = (__temp_7__ + __temp_10__);
			double __temp_12__;
			__temp_12__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(-1)+(M-0)*(__iter_1__)]);
			double __temp_13__;
			__temp_13__ = (input[__iter_0__+(M-0)*(__iter_1__)] - input[__iter_0__+(-1)+(M-0)*(__iter_1__)]);
			double __temp_14__;
			__temp_14__ = (__temp_12__ * __temp_13__);
			double __temp_15__;
			__temp_15__ = (__temp_11__ + __temp_14__);
			double __temp_16__;
			__temp_16__ = sqrt(__temp_15__);
			double __temp_17__;
			__temp_17__ = (1.000000f / __temp_16__);
			double __temp_18__;
			__temp_18__ = (input[__iter_0__+(M-0)*(__iter_1__)] + __temp_17__);
			__var_4__[__iter_0__+(M-0)*(__iter_1__)] = __temp_18__;
		}
	}
}
__global__ void __kernel___forma_kernel__1__(double * __restrict__ __var_4__, int N, int M, double * __restrict__ __var_3__){
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_2__;
	__iter_2__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_2__ <= (M-2)){
		int __iter_3__;
		__iter_3__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_3__ <= (N-2)){
			double __temp_19__;
			__temp_19__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(M-0)*(__iter_3__+(-1))]);
			double __temp_20__;
			__temp_20__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(M-0)*(__iter_3__+(-1))]);
			double __temp_21__;
			__temp_21__ = (__temp_19__ * __temp_20__);
			double __temp_22__;
			__temp_22__ = (0.000100f + __temp_21__);
			double __temp_23__;
			__temp_23__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(M-0)*(__iter_3__+(1))]);
			double __temp_24__;
			__temp_24__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(M-0)*(__iter_3__+(1))]);
			double __temp_25__;
			__temp_25__ = (__temp_23__ * __temp_24__);
			double __temp_26__;
			__temp_26__ = (__temp_22__ + __temp_25__);
			double __temp_27__;
			__temp_27__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__)]);
			double __temp_28__;
			__temp_28__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__)]);
			double __temp_29__;
			__temp_29__ = (__temp_27__ * __temp_28__);
			double __temp_30__;
			__temp_30__ = (__temp_26__ + __temp_29__);
			double __temp_31__;
			__temp_31__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__)]);
			double __temp_32__;
			__temp_32__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] - __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__)]);
			double __temp_33__;
			__temp_33__ = (__temp_31__ * __temp_32__);
			double __temp_34__;
			__temp_34__ = (__temp_30__ + __temp_33__);
			double __temp_35__;
			__temp_35__ = sqrt(__temp_34__);
			double __temp_36__;
			__temp_36__ = (1.000000f / __temp_35__);
			double __temp_37__;
			__temp_37__ = (__var_4__[__iter_2__+(M-0)*(__iter_3__)] + __temp_36__);
			__var_3__[__iter_2__+(M-0)*(__iter_3__)] = __temp_37__;
		}
	}
}
__global__ void __kernel___forma_kernel__2__(double * __restrict__ __var_3__, int N, int M, double * __restrict__ __var_2__){
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_4__;
	__iter_4__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_4__ <= (M-2)){
		int __iter_5__;
		__iter_5__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_5__ <= (N-2)){
			double __temp_38__;
			__temp_38__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(M-0)*(__iter_5__+(-1))]);
			double __temp_39__;
			__temp_39__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(M-0)*(__iter_5__+(-1))]);
			double __temp_40__;
			__temp_40__ = (__temp_38__ * __temp_39__);
			double __temp_41__;
			__temp_41__ = (0.000100f + __temp_40__);
			double __temp_42__;
			__temp_42__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(M-0)*(__iter_5__+(1))]);
			double __temp_43__;
			__temp_43__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(M-0)*(__iter_5__+(1))]);
			double __temp_44__;
			__temp_44__ = (__temp_42__ * __temp_43__);
			double __temp_45__;
			__temp_45__ = (__temp_41__ + __temp_44__);
			double __temp_46__;
			__temp_46__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__)]);
			double __temp_47__;
			__temp_47__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__)]);
			double __temp_48__;
			__temp_48__ = (__temp_46__ * __temp_47__);
			double __temp_49__;
			__temp_49__ = (__temp_45__ + __temp_48__);
			double __temp_50__;
			__temp_50__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__)]);
			double __temp_51__;
			__temp_51__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] - __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__)]);
			double __temp_52__;
			__temp_52__ = (__temp_50__ * __temp_51__);
			double __temp_53__;
			__temp_53__ = (__temp_49__ + __temp_52__);
			double __temp_54__;
			__temp_54__ = sqrt(__temp_53__);
			double __temp_55__;
			__temp_55__ = (1.000000f / __temp_54__);
			double __temp_56__;
			__temp_56__ = (__var_3__[__iter_4__+(M-0)*(__iter_5__)] + __temp_55__);
			__var_2__[__iter_4__+(M-0)*(__iter_5__)] = __temp_56__;
		}
	}
}
__global__ void __kernel___forma_kernel__3__(double * __restrict__ __var_2__, int N, int M, double * __restrict__ __var_1__){
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_6__;
	__iter_6__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_6__ <= (M-2)){
		int __iter_7__;
		__iter_7__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_7__ <= (N-2)){
			double __temp_57__;
			__temp_57__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(M-0)*(__iter_7__+(-1))]);
			double __temp_58__;
			__temp_58__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(M-0)*(__iter_7__+(-1))]);
			double __temp_59__;
			__temp_59__ = (__temp_57__ * __temp_58__);
			double __temp_60__;
			__temp_60__ = (0.000100f + __temp_59__);
			double __temp_61__;
			__temp_61__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(M-0)*(__iter_7__+(1))]);
			double __temp_62__;
			__temp_62__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(M-0)*(__iter_7__+(1))]);
			double __temp_63__;
			__temp_63__ = (__temp_61__ * __temp_62__);
			double __temp_64__;
			__temp_64__ = (__temp_60__ + __temp_63__);
			double __temp_65__;
			__temp_65__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__)]);
			double __temp_66__;
			__temp_66__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__)]);
			double __temp_67__;
			__temp_67__ = (__temp_65__ * __temp_66__);
			double __temp_68__;
			__temp_68__ = (__temp_64__ + __temp_67__);
			double __temp_69__;
			__temp_69__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__)]);
			double __temp_70__;
			__temp_70__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] - __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__)]);
			double __temp_71__;
			__temp_71__ = (__temp_69__ * __temp_70__);
			double __temp_72__;
			__temp_72__ = (__temp_68__ + __temp_71__);
			double __temp_73__;
			__temp_73__ = sqrt(__temp_72__);
			double __temp_74__;
			__temp_74__ = (1.000000f / __temp_73__);
			double __temp_75__;
			__temp_75__ = (__var_2__[__iter_6__+(M-0)*(__iter_7__)] + __temp_74__);
			__var_1__[__iter_6__+(M-0)*(__iter_7__)] = __temp_75__;
		}
	}
}
/*Device code End */
/* Host Code Begin */
extern "C" void gradient(double * h_input, int N, int M, double * __var_0__){

	/* Host allocation Begin */
	double * input;
	cudaMalloc(&input,sizeof(double)*((N-0)*(M-0)));
	Check_CUDA_Error("Allocation Error!! : input\n");
	cudaPointerAttributes ptrAttrib_h_input;
	cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
	if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
		if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
			memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
		cudaMemcpy(input,h_input,sizeof(double)*((N-0)*(M-0)), memcpy_kind_h_input);
	}
	double * __var_1__;
	cudaMalloc(&__var_1__,sizeof(double)*((N-0)*(M-0)));
	Check_CUDA_Error("Allocation Error!! : __var_1__\n");
	double * __var_2__;
	cudaMalloc(&__var_2__,sizeof(double)*((N-0)*(M-0)));
	Check_CUDA_Error("Allocation Error!! : __var_2__\n");
	double * __var_3__;
	cudaMalloc(&__var_3__,sizeof(double)*((N-0)*(M-0)));
	Check_CUDA_Error("Allocation Error!! : __var_3__\n");
	double * __var_4__;
	cudaMalloc(&__var_4__,sizeof(double)*((N-0)*(M-0)));
	Check_CUDA_Error("Allocation Error!! : __var_4__\n");
	/*Host Allocation End */
	/* Kernel Launch Begin */
#ifdef _TIMER_
	cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
	cudaEventCreate(&_forma_timer_start_);
	cudaEventCreate(&_forma_timer_stop_);
	cudaEventRecord(_forma_timer_start_,0);
#endif
	int __size_0___kernel___forma_kernel__0__ = ((M-2) - 1 ) + 1;
	int __size_1___kernel___forma_kernel__0__ = ((N-2) - 1 ) + 1;
	int __block_0___kernel___forma_kernel__0__ = 16;
	int __block_1___kernel___forma_kernel__0__ = 32;
	dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
	int __SMemSize___kernel___forma_kernel__0__ = 0;
	int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
	int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
	dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);

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

	for (int x=0; x<1000; x++) {
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __var_4__);
		Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_4__, N, M, __var_3__);
		Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_3__, N, M, __var_2__);
		Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, N, M, __var_1__);
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
	cudaMemcpy(__var_0__,__var_1__, sizeof(double)*((N-0)*(M-0)), memcpy_kind___var_0__);
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
