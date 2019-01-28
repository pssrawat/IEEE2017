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
__global__ void __kernel___forma_kernel__0__(float * input, int N, int M, float * __var_4__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
  if(__iter_0__ <= (M-2)){
    int __iter_1__;
    __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
    if(__iter_1__ <= (N-2)){
      float __temp_0__;
      __temp_0__ = (5 * input[__iter_0__+(M-0)*(__iter_1__+(-1))]);
      float __temp_1__;
      __temp_1__ = (12 * input[__iter_0__+(-1)+(M-0)*(__iter_1__)]);
      float __temp_2__;
      __temp_2__ = (__temp_0__ + __temp_1__);
      float __temp_3__;
      __temp_3__ = (15 * input[__iter_0__+(M-0)*(__iter_1__)]);
      float __temp_4__;
      __temp_4__ = (__temp_2__ + __temp_3__);
      float __temp_5__;
      __temp_5__ = (12 * input[__iter_0__+(1)+(M-0)*(__iter_1__)]);
      float __temp_6__;
      __temp_6__ = (__temp_4__ + __temp_5__);
      float __temp_7__;
      __temp_7__ = (5 * input[__iter_0__+(M-0)*(__iter_1__+(1))]);
      float __temp_8__;
      __temp_8__ = (__temp_6__ + __temp_7__);
      float __temp_9__;
      __temp_9__ = (__temp_8__ / 118);
      __var_4__[__iter_0__+(M-0)*(__iter_1__)] = __temp_9__;
    }
  }
}
__global__ void __kernel___forma_kernel__1__(float * __var_4__, int N, int M, float * __var_3__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_2__;
  __iter_2__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
  if(__iter_2__ <= (M-2)){
    int __iter_3__;
    __iter_3__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
    if(__iter_3__ <= (N-2)){
      float __temp_10__;
      __temp_10__ = (5 * __var_4__[__iter_2__+(M-0)*(__iter_3__+(-1))]);
      float __temp_11__;
      __temp_11__ = (12 * __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__)]);
      float __temp_12__;
      __temp_12__ = (__temp_10__ + __temp_11__);
      float __temp_13__;
      __temp_13__ = (15 * __var_4__[__iter_2__+(M-0)*(__iter_3__)]);
      float __temp_14__;
      __temp_14__ = (__temp_12__ + __temp_13__);
      float __temp_15__;
      __temp_15__ = (12 * __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__)]);
      float __temp_16__;
      __temp_16__ = (__temp_14__ + __temp_15__);
      float __temp_17__;
      __temp_17__ = (5 * __var_4__[__iter_2__+(M-0)*(__iter_3__+(1))]);
      float __temp_18__;
      __temp_18__ = (__temp_16__ + __temp_17__);
      float __temp_19__;
      __temp_19__ = (__temp_18__ / 118);
      __var_3__[__iter_2__+(M-0)*(__iter_3__)] = __temp_19__;
    }
  }
}
__global__ void __kernel___forma_kernel__2__(float * __var_3__, int N, int M, float * __var_2__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_4__;
  __iter_4__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
  if(__iter_4__ <= (M-2)){
    int __iter_5__;
    __iter_5__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
    if(__iter_5__ <= (N-2)){
      float __temp_20__;
      __temp_20__ = (5 * __var_3__[__iter_4__+(M-0)*(__iter_5__+(-1))]);
      float __temp_21__;
      __temp_21__ = (12 * __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__)]);
      float __temp_22__;
      __temp_22__ = (__temp_20__ + __temp_21__);
      float __temp_23__;
      __temp_23__ = (15 * __var_3__[__iter_4__+(M-0)*(__iter_5__)]);
      float __temp_24__;
      __temp_24__ = (__temp_22__ + __temp_23__);
      float __temp_25__;
      __temp_25__ = (12 * __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__)]);
      float __temp_26__;
      __temp_26__ = (__temp_24__ + __temp_25__);
      float __temp_27__;
      __temp_27__ = (5 * __var_3__[__iter_4__+(M-0)*(__iter_5__+(1))]);
      float __temp_28__;
      __temp_28__ = (__temp_26__ + __temp_27__);
      float __temp_29__;
      __temp_29__ = (__temp_28__ / 118);
      __var_2__[__iter_4__+(M-0)*(__iter_5__)] = __temp_29__;
    }
  }
}
__global__ void __kernel___forma_kernel__3__(float * __var_2__, int N, int M, float * __var_1__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_6__;
  __iter_6__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
  if(__iter_6__ <= (M-2)){
    int __iter_7__;
    __iter_7__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
    if(__iter_7__ <= (N-2)){
      float __temp_30__;
      __temp_30__ = (5 * __var_2__[__iter_6__+(M-0)*(__iter_7__+(-1))]);
      float __temp_31__;
      __temp_31__ = (12 * __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__)]);
      float __temp_32__;
      __temp_32__ = (__temp_30__ + __temp_31__);
      float __temp_33__;
      __temp_33__ = (15 * __var_2__[__iter_6__+(M-0)*(__iter_7__)]);
      float __temp_34__;
      __temp_34__ = (__temp_32__ + __temp_33__);
      float __temp_35__;
      __temp_35__ = (12 * __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__)]);
      float __temp_36__;
      __temp_36__ = (__temp_34__ + __temp_35__);
      float __temp_37__;
      __temp_37__ = (5 * __var_2__[__iter_6__+(M-0)*(__iter_7__+(1))]);
      float __temp_38__;
      __temp_38__ = (__temp_36__ + __temp_37__);
      float __temp_39__;
      __temp_39__ = (__temp_38__ / 118);
      __var_1__[__iter_6__+(M-0)*(__iter_7__)] = __temp_39__;
    }
  }
}
/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(float * h_input, int N, int M, float * __var_0__){

/* Host allocation Begin */
  float * input;
  cudaMalloc(&input,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(float)*((N-0)*(M-0)), memcpy_kind_h_input);
  }
  float * __var_1__;
  cudaMalloc(&__var_1__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  float * __var_2__;
  cudaMalloc(&__var_2__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_2__\n");
  float * __var_3__;
  cudaMalloc(&__var_3__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_3__\n");
  float * __var_4__;
  cudaMalloc(&__var_4__,sizeof(float)*((N-0)*(M-0)));
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
  int __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int _max_occupancy_gridsize___kernel___forma_kernel__0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__0__,&__max_occupancy_blocksize___kernel___forma_kernel__0__,(const void*)__kernel___forma_kernel__0__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__0___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__0___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),1);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_1___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),1);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __var_4__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  int __size_0___kernel___forma_kernel__1__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel___forma_kernel__1__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__1__;
  int _max_occupancy_gridsize___kernel___forma_kernel__1__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__1__,&__max_occupancy_blocksize___kernel___forma_kernel__1__,(const void*)__kernel___forma_kernel__1__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__1___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__1__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__1___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__1___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__1___0,FORMA_MAX((__size_0___kernel___forma_kernel__1__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),1);
  __max_occupancy_blocksize___kernel___forma_kernel__1__ /= __block_0___kernel___forma_kernel__1__;
  int __max_occupancy_blocksize___kernel___forma_kernel__1___1 = __max_occupancy_blocksize___kernel___forma_kernel__1__;
  int __block_1___kernel___forma_kernel__1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__1___1,__size_1___kernel___forma_kernel__1__),FORMA_MAX_BLOCKDIM_1),1);
  __max_occupancy_blocksize___kernel___forma_kernel__1__ /= __block_1___kernel___forma_kernel__1__;
  dim3 __blockConfig___kernel___forma_kernel__1__(__block_0___kernel___forma_kernel__1__,__block_1___kernel___forma_kernel__1__);
  int __SMemSize___kernel___forma_kernel__1__ = 0;
  int __grid_0___kernel___forma_kernel__1__ = FORMA_CEIL(__size_0___kernel___forma_kernel__1__,__block_0___kernel___forma_kernel__1__);
  int __grid_1___kernel___forma_kernel__1__ = FORMA_CEIL(__size_1___kernel___forma_kernel__1__,__block_1___kernel___forma_kernel__1__);
  dim3 __gridConfig___kernel___forma_kernel__1__(__grid_0___kernel___forma_kernel__1__,__grid_1___kernel___forma_kernel__1__);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__1__, __blockConfig___kernel___forma_kernel__1__, __SMemSize___kernel___forma_kernel__1__>>> (__var_4__, N, M, __var_3__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");
  int __size_0___kernel___forma_kernel__2__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel___forma_kernel__2__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__2__;
  int _max_occupancy_gridsize___kernel___forma_kernel__2__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__2__,&__max_occupancy_blocksize___kernel___forma_kernel__2__,(const void*)__kernel___forma_kernel__2__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__2___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__2__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__2___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__2___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__2__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__2___0,FORMA_MAX((__size_0___kernel___forma_kernel__2__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),1);
  __max_occupancy_blocksize___kernel___forma_kernel__2__ /= __block_0___kernel___forma_kernel__2__;
  int __max_occupancy_blocksize___kernel___forma_kernel__2___1 = __max_occupancy_blocksize___kernel___forma_kernel__2__;
  int __block_1___kernel___forma_kernel__2__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__2___1,__size_1___kernel___forma_kernel__2__),FORMA_MAX_BLOCKDIM_1),1);
  __max_occupancy_blocksize___kernel___forma_kernel__2__ /= __block_1___kernel___forma_kernel__2__;
  dim3 __blockConfig___kernel___forma_kernel__2__(__block_0___kernel___forma_kernel__2__,__block_1___kernel___forma_kernel__2__);
  int __SMemSize___kernel___forma_kernel__2__ = 0;
  int __grid_0___kernel___forma_kernel__2__ = FORMA_CEIL(__size_0___kernel___forma_kernel__2__,__block_0___kernel___forma_kernel__2__);
  int __grid_1___kernel___forma_kernel__2__ = FORMA_CEIL(__size_1___kernel___forma_kernel__2__,__block_1___kernel___forma_kernel__2__);
  dim3 __gridConfig___kernel___forma_kernel__2__(__grid_0___kernel___forma_kernel__2__,__grid_1___kernel___forma_kernel__2__);
  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__2__, __blockConfig___kernel___forma_kernel__2__, __SMemSize___kernel___forma_kernel__2__>>> (__var_3__, N, M, __var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");
  int __size_0___kernel___forma_kernel__3__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel___forma_kernel__3__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__3__;
  int _max_occupancy_gridsize___kernel___forma_kernel__3__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__3__,&__max_occupancy_blocksize___kernel___forma_kernel__3__,(const void*)__kernel___forma_kernel__3__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__3___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__3__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__3___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__3___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__3__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__3___0,FORMA_MAX((__size_0___kernel___forma_kernel__3__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),1);
  __max_occupancy_blocksize___kernel___forma_kernel__3__ /= __block_0___kernel___forma_kernel__3__;
  int __max_occupancy_blocksize___kernel___forma_kernel__3___1 = __max_occupancy_blocksize___kernel___forma_kernel__3__;
  int __block_1___kernel___forma_kernel__3__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__3___1,__size_1___kernel___forma_kernel__3__),FORMA_MAX_BLOCKDIM_1),1);
  __max_occupancy_blocksize___kernel___forma_kernel__3__ /= __block_1___kernel___forma_kernel__3__;
  dim3 __blockConfig___kernel___forma_kernel__3__(__block_0___kernel___forma_kernel__3__,__block_1___kernel___forma_kernel__3__);
  int __SMemSize___kernel___forma_kernel__3__ = 0;
  int __grid_0___kernel___forma_kernel__3__ = FORMA_CEIL(__size_0___kernel___forma_kernel__3__,__block_0___kernel___forma_kernel__3__);
  int __grid_1___kernel___forma_kernel__3__ = FORMA_CEIL(__size_1___kernel___forma_kernel__3__,__block_1___kernel___forma_kernel__3__);
  dim3 __gridConfig___kernel___forma_kernel__3__(__grid_0___kernel___forma_kernel__3__,__grid_1___kernel___forma_kernel__3__);
  __kernel___forma_kernel__3__<<<__gridConfig___kernel___forma_kernel__3__, __blockConfig___kernel___forma_kernel__3__, __SMemSize___kernel___forma_kernel__3__>>> (__var_2__, N, M, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__3__\n");
  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(float)*((N-0)*(M-0)), memcpy_kind___var_0__);
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
