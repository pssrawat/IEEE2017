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
#define mod(x,y) ( (x) & (y-1))

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
/* Device code Begin */
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  __shared__ float __tilevar_0__[3][128];
  __shared__ float __tilevar_1__[3][128];
  int __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X-4);

  // Initialize the values
  int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
    __tilevar_0__[1][__iter_3__-__iter_0__] = input[__iter_3__+M*0];
    __tilevar_0__[2][__iter_3__-__iter_0__] = input[__iter_3__+M*1];
  }
  // Rest of the computation
  for (int __iter_1__ = 1; __iter_1__ < N-1; __iter_1__++) {
    if(__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){
      __tilevar_0__[0][__iter_3__-__iter_0__] = __tilevar_0__[1][__iter_3__-__iter_0__];
      __tilevar_0__[1][__iter_3__-__iter_0__] = __tilevar_0__[2][__iter_3__-__iter_0__];
      __tilevar_0__[2][__iter_3__-__iter_0__] = input[__iter_3__+M*(__iter_1__+1)];
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+1),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      float __temp_2__ = (__tilevar_0__[0][__iter_3__-1-__iter_0__]);
      float __temp_5__ = (__tilevar_0__[0][__iter_3__-__iter_0__]);
      float __temp_6__ = (7 * __temp_2__ + 5 * __temp_5__);
      float __temp_9__ = (__tilevar_0__[0][__iter_3__+1-__iter_0__]);
      float __temp_10__ = (__temp_6__ + 9 * __temp_9__);
      float __temp_13__ = (__tilevar_0__[1][__iter_3__-1-__iter_0__]);
      float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
      float __temp_17__ = (__tilevar_0__[1][__iter_3__-__iter_0__]);
      float __temp_18__ = (__temp_14__ + 15 * __temp_17__);
      float __temp_21__ = (__tilevar_0__[1][__iter_3__+1-__iter_0__]);
      float __temp_22__ = (__temp_18__ + 12 * __temp_21__);
      float __temp_25__ = (__tilevar_0__[2][__iter_3__-1-__iter_0__]);
      float __temp_26__ = (__temp_22__ + 9 * __temp_25__);
      float __temp_29__ = (__tilevar_0__[2][__iter_3__-__iter_0__]);
      float __temp_30__ = (__temp_26__ + 5 * __temp_29__);
      float __temp_33__ = (__tilevar_0__[2][__iter_3__+1-__iter_0__]);
      float __temp_34__ = (__temp_30__ + 7 * __temp_33__);
      float __temp_35__ = (__temp_34__ / 118);
      __tilevar_1__[0][__iter_3__-__iter_0__] = __tilevar_1__[1][__iter_3__-__iter_0__];
      __tilevar_1__[1][__iter_3__-__iter_0__] = __tilevar_1__[2][__iter_3__-__iter_0__];
      __tilevar_1__[2][__iter_3__-__iter_0__] = __temp_35__;
    }
    __syncthreads ();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+2),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      float __temp_2__ = (__tilevar_1__[0][__iter_3__-1-__iter_0__]);
      float __temp_5__ = (__tilevar_1__[0][__iter_3__-__iter_0__]);
      float __temp_6__ = (7 * __temp_2__ + 5 * __temp_5__);
      float __temp_9__ = (__tilevar_1__[0][__iter_3__+1-__iter_0__]);
      float __temp_10__ = (__temp_6__ + 9 * __temp_9__);
      float __temp_13__ = (__tilevar_1__[1][__iter_3__-1-__iter_0__]);
      float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
      float __temp_17__ = (__tilevar_1__[1][__iter_3__-__iter_0__]);
      float __temp_18__ = (__temp_14__ + 15 * __temp_17__);
      float __temp_21__ = (__tilevar_1__[1][__iter_3__+1-__iter_0__]);
      float __temp_22__ = (__temp_18__ + 12 * __temp_21__);
      float __temp_25__ = (__tilevar_1__[2][__iter_3__-1-__iter_0__]);
      float __temp_26__ = (__temp_22__ + 9 * __temp_25__);
      float __temp_29__ = (__tilevar_1__[2][__iter_3__-__iter_0__]);
      float __temp_30__ = (__temp_26__ + 5 * __temp_29__);
      float __temp_33__ = (__tilevar_1__[2][__iter_3__+1-__iter_0__]);
      float __temp_34__ = (__temp_30__ + 7 * __temp_33__);
      float __temp_35__ = (__temp_34__ / 118);
      __var_1__[__iter_3__+(M)*FORMA_MAX(__iter_1__-1,0)] = __temp_35__;
    }
  }
} 

/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(float * h_input, int N, int M, float * __var_0__){

/* Host allocation Begin */
  float * input;
  cudaMalloc(&input,sizeof(float)*((N)*(M)));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(float)*((N)*(M)), memcpy_kind_h_input);
  }
  float * __var_1__;
  cudaMalloc(&__var_1__,sizeof(float)*((N)*(M)));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  float * __var_2__;
  cudaMalloc(&__var_2__,sizeof(float)*((N)*(M)));
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
  int __size_0___kernel___forma_kernel__0__ = ((M-1) - 0 ) + 1;
  int __block_0___kernel___forma_kernel__0__ = 128;
  int __block_1___kernel___forma_kernel__0__ = 1;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-4);
  int __grid_1___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_2__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__>>> (__var_2__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(float)*((N)*(M)), memcpy_kind___var_0__);
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
