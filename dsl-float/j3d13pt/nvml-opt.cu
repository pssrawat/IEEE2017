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
/* X, Y, Z */
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
	__shared__ float tilevar[2][32*32];
	float b[4], t[4];
	int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)-8);
	int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)-8);

	// Initialize the values
	int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
	int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
	if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1))) {
		b[0] = input[__iter_5__+N*(__iter_4__+M*(0))];
		tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = input[__iter_5__+N*(__iter_4__+M*(1))];
		t[0] = input[__iter_5__+N*(__iter_4__+M*(2))];  
		t[2] = input[__iter_5__+N*(__iter_4__+M*(3))];
	}
	// Rest of the computation
	for (int __iter_2__ = 2; __iter_2__ < L-2; __iter_2__++) {
		if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1))){
			b[2] = b[0];
			b[0]  = tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
			tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t[0];
			t[0] = t[2]; 
			t[2] = input[__iter_5__+N*(__iter_4__+M*(__iter_2__+2))]; 
		}
		__syncthreads ();
		if(__iter_4__ >= FORMA_MAX((__iter_1__+2),2) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-3)) & __iter_5__ >= FORMA_MAX((__iter_0__+2),2) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-3)) ){
			float __temp_3__ = (tilevar[0][__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_7__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_8__ = (0.083000f * __temp_3__ + 0.083000f * __temp_7__);
			float __temp_12__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_13__ = (__temp_8__ + 0.083000f * __temp_12__);
			float __temp_17__ = (tilevar[0][__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_18__ = (__temp_13__ + 0.083000f * __temp_17__);
			float __temp_22__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+2-__iter_1__)]);
			float __temp_23__ = (__temp_18__ + 0.083000f * __temp_22__);
			float __temp_27__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
			float __temp_28__ = (__temp_23__ + 0.083000f * __temp_27__);
			float __temp_32__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
			float __temp_33__ = (__temp_28__ + 0.083000f * __temp_32__);
			float __temp_37__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-2-__iter_1__)]);
			float __temp_38__ = (__temp_33__ + 0.083000f * __temp_37__);
			float __temp_43__ = (__temp_38__ + 0.083000f * t[2]);
			float __temp_48__ = (__temp_43__ + 0.083000f * t[0]);
			float __temp_53__ = (__temp_48__ + 0.083000f * b[0]);
			float __temp_58__ = (__temp_53__ + 0.083000f * b[2]);
			float __temp_62__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_63__ = (__temp_58__ - 0.996000f * __temp_62__);
			b[3] = b[1];
			b[1] = tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
			tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t[1];
			t[1] = t[3];
			t[3] = __temp_63__;
		}
		__syncthreads ();
		if(__iter_4__ >= FORMA_MAX((__iter_1__+4),2) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-3)) & __iter_5__ >= FORMA_MAX((__iter_0__+4),2) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-3)) ){
			float __temp_3__ = (tilevar[1][__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_7__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_8__ = (0.083000f * __temp_3__ + 0.083000f * __temp_7__);
			float __temp_12__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_13__ = (__temp_8__ + 0.083000f * __temp_12__);
			float __temp_17__ = (tilevar[1][__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_18__ = (__temp_13__ + 0.083000f * __temp_17__);
			float __temp_22__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+2-__iter_1__)]);
			float __temp_23__ = (__temp_18__ + 0.083000f * __temp_22__);
			float __temp_27__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
			float __temp_28__ = (__temp_23__ + 0.083000f * __temp_27__);
			float __temp_32__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
			float __temp_33__ = (__temp_28__ + 0.083000f * __temp_32__);
			float __temp_37__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-2-__iter_1__)]);
			float __temp_38__ = (__temp_33__ + 0.083000f * __temp_37__);
			float __temp_43__ = (__temp_38__ + 0.083000f * t[3]);
			float __temp_48__ = (__temp_43__ + 0.083000f * t[1]);
			float __temp_53__ = (__temp_48__ + 0.083000f * b[1]);
			float __temp_58__ = (__temp_53__ + 0.083000f * b[3]);
			float __temp_62__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
			float __temp_63__ = (__temp_58__ - 0.996000f * __temp_62__);
			__var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-2,0))] = __temp_63__;
		}
	}
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d13pt(float * h_input, int L, int M, int N, float * __var_0__){

	/* Host allocation Begin */
	float * input;
	cudaMalloc(&input,sizeof(float)*(L*M*N));
	Check_CUDA_Error("Allocation Error!! : input\n");
	cudaPointerAttributes ptrAttrib_h_input;
	cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
	if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
		if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
			memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
		cudaMemcpy(input,h_input,sizeof(float)*(L*M*N), memcpy_kind_h_input);
	}
	float * __var_1__;
	cudaMalloc(&__var_1__,sizeof(float)*(L*M*N));
	Check_CUDA_Error("Allocation Error!! : __var_1__\n");
	float * __var_2__;
	cudaMalloc(&__var_2__,sizeof(float)*(L*M*N));
	Check_CUDA_Error("Allocation Error!! : __var_2__\n");
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
	int __block_1___kernel___forma_kernel__0__ = 32;
	int __block_2___kernel___forma_kernel__0__ = 1;
	dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
	int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-8);
	int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y-8);
	int __grid_2___kernel___forma_kernel__0__ = 1;
	dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
	dim3 unrollConfig (__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z);

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

		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig>>> (input, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_2__);
		Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig>>> (__var_2__, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
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
	cudaMemcpy(__var_0__,__var_1__, sizeof(float)*(L*M*N), memcpy_kind___var_0__);
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
}
/*Host Free End*/
