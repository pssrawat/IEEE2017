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
__global__ void __kernel___forma_kernel__0__(struct double4 * __restrict__ input, double dx, double dy, double dz, int L, int M, int N, struct double4 * __restrict__ __var_2__){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 0;
  if(__iter_0__ <= (N-2)){
    int __iter_1__;
    __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 0;
    if(__iter_1__ <= (M-2)){
      int __iter_2__;
      __iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 0;
      if(__iter_2__ <= (L-2)){
        double __temp_0__;
        __temp_0__ = (input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__+(1)))].y - input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].y);
        double __temp_1__;
        __temp_1__ = (dz * __temp_0__);
        double __temp_2__;
        __temp_2__ = (input[__iter_0__+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__))].z - input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].z);
        double __temp_3__;
        __temp_3__ = (dy * __temp_2__);
        double __temp_4__;
        __temp_4__ = (__temp_1__ - __temp_3__);
        double __temp_5__;
        __temp_5__ = (input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__+(1)))].x - input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].x);
        double __temp_6__;
        __temp_6__ = (dz * __temp_5__);
        double __temp_7__;
        __temp_7__ = (input[__iter_0__+(1)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].z - input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].z);
        double __temp_8__;
        __temp_8__ = (dx * __temp_7__);
        double __temp_9__;
        __temp_9__ = (__temp_6__ - __temp_8__);
        double __temp_10__;
        __temp_10__ = (input[__iter_0__+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__))].x - input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].x);
        double __temp_11__;
        __temp_11__ = (dy * __temp_10__);
        double __temp_12__;
        __temp_12__ = (input[__iter_0__+(1)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].y - input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].y);
        double __temp_13__;
        __temp_13__ = (dx * __temp_12__);
        double __temp_14__;
        __temp_14__ = (__temp_11__ - __temp_13__);
        double __temp_15__;
        __temp_15__ = (__temp_4__ + input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].x);
        double __temp_16__;
        __temp_16__ = (__temp_9__ + input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].y);
        double __temp_17__;
        __temp_17__ = (__temp_14__ + input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].z);
        __var_2__[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].x = __temp_15__;
        __var_2__[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].y = __temp_16__;
        __var_2__[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].z = __temp_17__;
        __var_2__[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))].w = 0.000000f;
      }
    }
  }
}
__global__ void __kernel___forma_kernel__1__(struct double4 * __restrict__ __var_2__, double dx, double dy, double dz, int L, int M, int N, struct double4 * __restrict__ __var_1__){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_3__;
  __iter_3__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
  if(__iter_3__ <= (N-1)){
    int __iter_4__;
    __iter_4__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
    if(__iter_4__ <= (M-1)){
      int __iter_5__;
      __iter_5__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 1;
      if(__iter_5__ <= (L-1)){
        double __temp_18__;
        __temp_18__ = (__var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].y - __var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__+(-1)))].y);
        double __temp_19__;
        __temp_19__ = (dz * __temp_18__);
        double __temp_20__;
        __temp_20__ = (__var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].z - __var_2__[__iter_3__+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__))].z);
        double __temp_21__;
        __temp_21__ = (dy * __temp_20__);
        double __temp_22__;
        __temp_22__ = (__temp_19__ - __temp_21__);
        double __temp_23__;
        __temp_23__ = (__var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].x - __var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__+(-1)))].x);
        double __temp_24__;
        __temp_24__ = (dz * __temp_23__);
        double __temp_25__;
        __temp_25__ = (__var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].z - __var_2__[__iter_3__+(-1)+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].z);
        double __temp_26__;
        __temp_26__ = (dx * __temp_25__);
        double __temp_27__;
        __temp_27__ = (__temp_24__ - __temp_26__);
        double __temp_28__;
        __temp_28__ = (__var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].x - __var_2__[__iter_3__+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__))].x);
        double __temp_29__;
        __temp_29__ = (dy * __temp_28__);
        double __temp_30__;
        __temp_30__ = (__var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].y - __var_2__[__iter_3__+(-1)+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].y);
        double __temp_31__;
        __temp_31__ = (dx * __temp_30__);
        double __temp_32__;
        __temp_32__ = (__temp_29__ - __temp_31__);
        double __temp_33__;
        __temp_33__ = (__temp_22__ + __var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].x);
        double __temp_34__;
        __temp_34__ = (__temp_27__ + __var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].y);
        double __temp_35__;
        __temp_35__ = (__temp_32__ + __var_2__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].z);
        __var_1__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].x = __temp_33__;
        __var_1__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].y = __temp_34__;
        __var_1__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].z = __temp_35__;
        __var_1__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))].w = 0.000000f;
      }
    }
  }
}
/*Device code End */
/* Host Code Begin */
extern "C" void curl(struct double4 * h_input, double dx, double dy, double dz, int L, int M, int N, struct double4 * __var_0__){

/* Host allocation Begin */
  struct double4 * input;
  cudaMalloc(&input,sizeof(struct double4)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(struct double4)*((L-0)*(M-0)*(N-0)), memcpy_kind_h_input);
  }
  struct double4 * __var_1__;
  cudaMalloc(&__var_1__,sizeof(struct double4)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  struct double4 * __var_2__;
  cudaMalloc(&__var_2__,sizeof(struct double4)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : __var_2__\n");
/*Host Allocation End */
/* Kernel Launch Begin */
#ifdef _TIMER_
  cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
  cudaEventCreate(&_forma_timer_start_);
  cudaEventCreate(&_forma_timer_stop_);
  cudaEventRecord(_forma_timer_start_,0);
#endif
  int __size_0___kernel___forma_kernel__0__ = ((N-2) - 0 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((M-2) - 0 ) + 1;
  int __size_2___kernel___forma_kernel__0__ = ((L-2) - 0 ) + 1;
  int __block_0___kernel___forma_kernel__0__ = 16;
  int __block_1___kernel___forma_kernel__0__ = 4;
  int __block_2___kernel___forma_kernel__0__ = 4;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __grid_2___kernel___forma_kernel__0__ = FORMA_CEIL(__size_2___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, dx, dy, dz, L, M, N, __var_2__);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, dx, dy, dz, L, M, N, __var_1__);


  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(struct double4)*((L-0)*(M-0)*(N-0)), memcpy_kind___var_0__);
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
