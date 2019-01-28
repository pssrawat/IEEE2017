#include "cuda.h"
#ifdef _TIMER_
#include "cuda_profiler_api.h"
#endif
#include "stdio.h"

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

void Check_CUDA_Error(const char* message);
/*Texture references */
/*Shared Memory Variable */
extern __shared__ char __FORMA_SHARED_MEM__[];
/* Device code Begin */
/* X, Y, Z */
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)-4);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)-4);
  float t2=0.0f, t3=0.0f;
  float m2=0.0f, m3=0.0f;
  float out2=0.0f, out3=0.0f;

  // Initialize the values
  int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  // Rest of the computation
  for (int __iter_2__ = 0; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1))){
        __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = input[__iter_5__+N*(__iter_4__+M*(__iter_2__))]; 
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))){
	// Bottom
	float c0 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        float b0 = -0.166f * c0;
	float a0 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]; 
	float a1 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a2 = __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
 	float a3 = __tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float b1 = -0.0833f * (a0 + a1 + a2 + a3);
	t2 += (b0 + b1);
	// Mid
	float b2 = 2.666f * c0; 
	float a4 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)];
	float a5 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a6 = __tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        float a7 = __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float b3 = -0.166f * (a4 + a5 + a6 + a7);
	float a8 = __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]; 
	float a9 = __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a10 = __tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)];
        float a11 = __tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float b4 = -0.0833f * (a8 + a9 + a10 + a11);
	m2 += (b2 + b3 + b4);
	// Top
	float b5 = -0.166f * c0;
	float a12 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)];
	float a13 = __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a14 = __tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float a15 = __tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float b6 = -0.0833f * (a12 + a13 + a14 + a15);
	out2 += (b5 + b6); 
        __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = out2;
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+2),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))){
	// Bottom
	float c0 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        float b0 = -0.166f * c0;
	float a0 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]; 
	float a1 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a2 = __tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
 	float a3 = __tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float b1 = -0.0833f * (a0 + a1 + a2 + a3);
	t3 += (b0 + b1);
	// Mid
	float b2 = 2.666f * c0; 
	float a4 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)];
	float a5 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a6 = __tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        float a7 = __tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float b3 = -0.166f * (a4 + a5 + a6 + a7);
	float a8 = __tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]; 
	float a9 = __tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a10 = __tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)];
        float a11 = __tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float b4 = -0.0833f * (a8 + a9 + a10 + a11);
	m3 += (b2 + b3 + b4);
	// Top
	float b5 = -0.166f * c0;
	float a12 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)];
	float a13 = __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)];
	float a14 = __tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float a15 = __tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	float b6 = -0.0833f * (a12 + a13 + a14 + a15);
	out3 += (b5 + b6); 
	__var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-2,0))] = out3;
    }
    __syncthreads ();
    // Now rotate 
    out2 = m2; m2 = t2; t2 = 0.0f;
    out3 = m3; m3 = t3; t3 = 0.0f;
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(2*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void host_code (float * h_input, float * __var_0__, int L, int M, int N) {

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
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-4);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y-4);
  int __grid_2___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  dim3 unrollConfig (__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_2__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

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
