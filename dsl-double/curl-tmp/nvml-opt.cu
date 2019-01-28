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
/*Shared Memory Variable */
extern __shared__ char __FORMA_SHARED_MEM__[];
/* Device code Begin */
__global__ void __kernel___forma_kernel__0__(struct double4 * __restrict__ input, double dx, double dy, double dz, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, struct double4 * __restrict__ __var_1__){
	int __FORMA_SHARED_MEM_OFFSET__ = 0;
	struct double4* __tilevar_0__ = (struct double4*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
	__FORMA_SHARED_MEM_OFFSET__ += sizeof(struct double4)*((FORMA_BLOCKDIM_Z*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X));

	double b_x = 0.0f, b_y = 0.0f;

	int __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X-2);
	int __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y-2);
	int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
	int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;

#pragma unroll 4 
	for (int __iter_2__ = 0; __iter_2__ < L-1; __iter_2__++) {
		if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),M-2) ){
			if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),N-2) ){
				double __temp_0__ = (input[__iter_5__+N*(__iter_4__+M*(__iter_2__+1))].y - input[__iter_5__+N*(__iter_4__+M*__iter_2__)].y);
				double __temp_1__ = (dz * __temp_0__);
				double __temp_2__ = (input[__iter_5__+N*(__iter_4__+1+M*__iter_2__)].z - input[__iter_5__+N*(__iter_4__+M*__iter_2__)].z);
				double __temp_3__ = (dy * __temp_2__);
				double __temp_4__ = (__temp_1__ - __temp_3__);
				double __temp_5__ = (input[__iter_5__+N*(__iter_4__+M*(__iter_2__+1))].x - input[__iter_5__+N*(__iter_4__+M*__iter_2__)].x);
				double __temp_6__ = (dz * __temp_5__);
				double __temp_7__ = (input[__iter_5__+1+N*(__iter_4__+M*__iter_2__)].z - input[__iter_5__+N*(__iter_4__+M*__iter_2__)].z);
				double __temp_8__ = (dx * __temp_7__);
				double __temp_9__ = (__temp_6__ - __temp_8__);
				double __temp_10__ = (input[__iter_5__+N*(__iter_4__+1+M*__iter_2__)].x - input[__iter_5__+N*(__iter_4__+M*__iter_2__)].x);
				double __temp_11__ = (dy * __temp_10__);
				double __temp_12__ = (input[__iter_5__+1+N*(__iter_4__+M*__iter_2__)].y - input[__iter_5__+N*(__iter_4__+M*__iter_2__)].y);
				double __temp_13__ = (dx * __temp_12__);
				double __temp_14__ = (__temp_11__ - __temp_13__);
				double __temp_15__ = (__temp_4__ + input[__iter_5__+N*(__iter_4__+M*__iter_2__)].x);
				double __temp_16__ = (__temp_9__ + input[__iter_5__+N*(__iter_4__+M*__iter_2__)].y);
				double __temp_17__ = (__temp_14__ + input[__iter_5__+N*(__iter_4__+M*__iter_2__)].z);
				b_x = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].x;
				b_y = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].y;
				__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].x = __temp_15__;
				__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].y = __temp_16__;
				__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].z = __temp_17__;
				__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].w = 0.0f;
			}
		}
		__syncthreads();
		if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-1))){
			if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-1))){
				double __temp_36__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].y - b_y);
				double __temp_37__ = (dz * __temp_36__);
				double __temp_38__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].z - __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)].z);
				double __temp_39__ = (dy * __temp_38__);
				double __temp_40__ = (__temp_37__ - __temp_39__);
				double __temp_41__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].x - b_x);
				double __temp_42__ = (dz * __temp_41__);
				double __temp_43__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].z - __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].z);
				double __temp_44__ = (dx * __temp_43__);
				double __temp_45__ = (__temp_42__ - __temp_44__);
				double __temp_46__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].x - __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)].x);
				double __temp_47__ = (dy * __temp_46__);
				double __temp_48__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].y - __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].y);
				double __temp_49__ = (dx * __temp_48__);
				double __temp_50__ = (__temp_47__ - __temp_49__);
				double __temp_51__ = (__temp_40__ + __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].x);
				double __temp_52__ = (__temp_45__ + __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].y);
				double __temp_53__ = (__temp_50__ + __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)].z);
				__var_1__[__iter_5__+N*(__iter_4__+M*__iter_2__)].x = __temp_51__;
				__var_1__[__iter_5__+N*(__iter_4__+M*__iter_2__)].y = __temp_52__;
				__var_1__[__iter_5__+N*(__iter_4__+M*__iter_2__)].z = __temp_53__;
				__var_1__[__iter_5__+N*(__iter_4__+M*__iter_2__)].w = 0.0f;
			}
		}
		__syncthreads ();
	}
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
	int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int SMemSize = 0;
	SMemSize += sizeof(struct double4)*((FORMA_BLOCKDIM_Z*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X));
	return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void curl(struct double4 * h_input, double dx, double dy, double dz, int L, int M, int N, struct double4 * __var_0__){

	/* Host allocation Begin */
	struct double4 * input;
	cudaMalloc(&input,sizeof(struct double4)*(L*M*N));
	Check_CUDA_Error("Allocation Error!! : input\n");
	cudaPointerAttributes ptrAttrib_h_input;
	cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
	if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
		if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
			memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
		cudaMemcpy(input,h_input,sizeof(struct double4)*(L*M*N), memcpy_kind_h_input);
	}
	struct double4 * __var_1__;
	cudaMalloc(&__var_1__,sizeof(struct double4)*(L*M*N));
	Check_CUDA_Error("Allocation Error!! : __var_1__\n");
	/*Host Allocation End */
	/* Kernel Launch Begin */
	int __FORMA_MAX_SHARED_MEM__;
	cudaDeviceGetAttribute(&__FORMA_MAX_SHARED_MEM__,cudaDevAttrMaxSharedMemoryPerBlock,0);
#ifdef _TIMER_
	cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
	cudaEventCreate(&_forma_timer_start_);
	cudaEventCreate(&_forma_timer_stop_);
	cudaEventRecord(_forma_timer_start_,0);
#endif
	int __size_0___kernel___forma_kernel__0__ = N;
	int __size_1___kernel___forma_kernel__0__ = M;
	int __block_0___kernel___forma_kernel__0__ = 32;
	int __block_1___kernel___forma_kernel__0__ = 16;
	int __block_2___kernel___forma_kernel__0__ = 1;
	dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
	int __SMemSize___kernel___forma_kernel__0__ = 0;
	__SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
	int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-2);
	int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y-2);
	int __grid_2___kernel___forma_kernel__0__ = 1;
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
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, dx, dy, dz, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
	}

	cudaDeviceSynchronize();
	result=nvmlDeviceGetPowerUsage(device,&power2);
	assert(NVML_SUCCESS == result);
	power2 -= power1;
	printf("%u\n", power2);
	nvmlShutdown();

	Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

	cudaPointerAttributes ptrAttrib___var_0__;
	cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
	if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
		if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
			memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	cudaMemcpy(__var_0__,__var_1__, sizeof(struct double4)*(L*M*N), memcpy_kind___var_0__);
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
}
/*Host Free End*/
