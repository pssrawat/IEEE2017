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
__global__ void __kernel_j3d27pt0__(double * __restrict__ input, int L, int M, int N, double * __restrict__ __var_4__){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
  if(__iter_0__ <= (N-2)){
    int __iter_1__;
    __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
    if(__iter_1__ <= (M-2)){
      int __iter_2__;
      __iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 1;
      if(__iter_2__ <= (L-2)){
        double __temp_0__;
        __temp_0__ = (0.5f * input[__iter_0__-1+N*(__iter_1__-1+M*(__iter_2__-1))]);
        double __temp_1__;
        __temp_1__ = (0.7f * input[__iter_0__+N*(__iter_1__-1+M*(__iter_2__-1))]);
        double __temp_2__;
        __temp_2__ = (__temp_0__ + __temp_1__);
        double __temp_3__;
        __temp_3__ = (0.9f * input[__iter_0__+1+N*(__iter_1__-1+M*(__iter_2__-1))]);
        double __temp_4__;
        __temp_4__ = (__temp_2__ + __temp_3__);
        double __temp_5__;
        __temp_5__ = (1.2f * input[__iter_0__-1+N*(__iter_1__+M*(__iter_2__-1))]);
        double __temp_6__;
        __temp_6__ = (__temp_4__ + __temp_5__);
        double __temp_7__;
        __temp_7__ = (1.5f * input[__iter_0__+N*(__iter_1__+M*(__iter_2__-1))]);
        double __temp_8__;
        __temp_8__ = (__temp_6__ + __temp_7__);
        double __temp_9__;
        __temp_9__ = (1.2f * input[__iter_0__+1+N*(__iter_1__+M*(__iter_2__-1))]);
        double __temp_10__;
        __temp_10__ = (__temp_8__ + __temp_9__);
        double __temp_11__;
        __temp_11__ = (0.9f * input[__iter_0__-1+N*(__iter_1__+1+M*(__iter_2__-1))]);
        double __temp_12__;
        __temp_12__ = (__temp_10__ + __temp_11__);
        double __temp_13__;
        __temp_13__ = (0.7f * input[__iter_0__+N*(__iter_1__+1+M*(__iter_2__-1))]);
        double __temp_14__;
        __temp_14__ = (__temp_12__ + __temp_13__);
        double __temp_15__;
        __temp_15__ = (0.5f * input[__iter_0__+1+N*(__iter_1__+1+M*(__iter_2__-1))]);
        double __temp_16__;
        __temp_16__ = (__temp_14__ + __temp_15__);
        double __temp_17__;
        __temp_17__ = (0.51f * input[__iter_0__-1+N*(__iter_1__-1+M*(__iter_2__))]);
        double __temp_18__;
        __temp_18__ = (__temp_16__ + __temp_17__);
        double __temp_19__;
        __temp_19__ = (0.71f * input[__iter_0__+N*(__iter_1__-1+M*(__iter_2__))]);
        double __temp_20__;
        __temp_20__ = (__temp_18__ + __temp_19__);
        double __temp_21__;
        __temp_21__ = (0.91f * input[__iter_0__+1+N*(__iter_1__-1+M*(__iter_2__))]);
        double __temp_22__;
        __temp_22__ = (__temp_20__ + __temp_21__);
        double __temp_23__;
        __temp_23__ = (1.21f * input[__iter_0__-1+N*(__iter_1__+M*(__iter_2__))]);
        double __temp_24__;
        __temp_24__ = (__temp_22__ + __temp_23__);
        double __temp_25__;
        __temp_25__ = (1.51f * input[__iter_0__+N*(__iter_1__+M*(__iter_2__))]);
        double __temp_26__;
        __temp_26__ = (__temp_24__ + __temp_25__);
        double __temp_27__;
        __temp_27__ = (1.21f * input[__iter_0__+1+N*(__iter_1__+M*(__iter_2__))]);
        double __temp_28__;
        __temp_28__ = (__temp_26__ + __temp_27__);
        double __temp_29__;
        __temp_29__ = (0.91f * input[__iter_0__-1+N*(__iter_1__+1+M*(__iter_2__))]);
        double __temp_30__;
        __temp_30__ = (__temp_28__ + __temp_29__);
        double __temp_31__;
        __temp_31__ = (0.71f * input[__iter_0__+N*(__iter_1__+1+M*(__iter_2__))]);
        double __temp_32__;
        __temp_32__ = (__temp_30__ + __temp_31__);
        double __temp_33__;
        __temp_33__ = (0.51f * input[__iter_0__+1+N*(__iter_1__+1+M*(__iter_2__))]);
        double __temp_34__;
        __temp_34__ = (__temp_32__ + __temp_33__);
        double __temp_35__;
        __temp_35__ = (0.52f * input[__iter_0__-1+N*(__iter_1__-1+M*(__iter_2__+1))]);
        double __temp_36__;
        __temp_36__ = (__temp_34__ + __temp_35__);
        double __temp_37__;
        __temp_37__ = (0.72f * input[__iter_0__+N*(__iter_1__-1+M*(__iter_2__+1))]);
        double __temp_38__;
        __temp_38__ = (__temp_36__ + __temp_37__);
        double __temp_39__;
        __temp_39__ = (0.92f * input[__iter_0__+1+N*(__iter_1__-1+M*(__iter_2__+1))]);
        double __temp_40__;
        __temp_40__ = (__temp_38__ + __temp_39__);
        double __temp_41__;
        __temp_41__ = (1.22f * input[__iter_0__-1+N*(__iter_1__+M*(__iter_2__+1))]);
        double __temp_42__;
        __temp_42__ = (__temp_40__ + __temp_41__);
        double __temp_43__;
        __temp_43__ = (1.52f * input[__iter_0__+N*(__iter_1__+M*(__iter_2__+1))]);
        double __temp_44__;
        __temp_44__ = (__temp_42__ + __temp_43__);
        double __temp_45__;
        __temp_45__ = (1.22f * input[__iter_0__+1+N*(__iter_1__+M*(__iter_2__+1))]);
        double __temp_46__;
        __temp_46__ = (__temp_44__ + __temp_45__);
        double __temp_47__;
        __temp_47__ = (0.92f * input[__iter_0__-1+N*(__iter_1__+1+M*(__iter_2__+1))]);
        double __temp_48__;
        __temp_48__ = (__temp_46__ + __temp_47__);
        double __temp_49__;
        __temp_49__ = (0.72f * input[__iter_0__+N*(__iter_1__+1+M*(__iter_2__+1))]);
        double __temp_50__;
        __temp_50__ = (__temp_48__ + __temp_49__);
        double __temp_51__;
        __temp_51__ = (0.52f * input[__iter_0__+1+N*(__iter_1__+1+M*(__iter_2__+1))]);
        double __temp_52__;
        __temp_52__ = (__temp_50__ + __temp_51__);
        double __temp_53__;
        __temp_53__ = (__temp_52__ / 159);
        __var_4__[__iter_0__+N*(__iter_1__+M*(__iter_2__))] = __temp_53__;
      }
    }
  }
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d27pt (double * h_input, int L, int M, int N, double * __var_0__){

/* Host allocation Begin */
  double * input;
  cudaMalloc(&input,sizeof(double)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(double)*(L*M*N), memcpy_kind_h_input);
  }
  double * __var_1__;
  cudaMalloc(&__var_1__,sizeof(double)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  double * __var_2__;
  cudaMalloc(&__var_2__,sizeof(double)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __var_2__\n");
/*Host Allocation End */
/* Kernel Launch Begin */
#ifdef _TIMER_
  cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
  cudaEventCreate(&_forma_timer_start_);
  cudaEventCreate(&_forma_timer_stop_);
  cudaEventRecord(_forma_timer_start_,0);
#endif
  int __size_0___kernel_j3d27pt0__ = ((N-2) - 1 ) + 1;
  int __size_1___kernel_j3d27pt0__ = ((M-2) - 1 ) + 1;
  int __size_2___kernel_j3d27pt0__ = ((L-2) - 1 ) + 1;
  int __block_0___kernel_j3d27pt0__ = 16;
  int __block_1___kernel_j3d27pt0__ = 4;
  int __block_2___kernel_j3d27pt0__ = 4;
  dim3 __blockConfig___kernel_j3d27pt0__(__block_0___kernel_j3d27pt0__,__block_1___kernel_j3d27pt0__,__block_2___kernel_j3d27pt0__);
  int __SMemSize___kernel_j3d27pt0__ = 0;
  int __grid_0___kernel_j3d27pt0__ = FORMA_CEIL(__size_0___kernel_j3d27pt0__,__block_0___kernel_j3d27pt0__);
  int __grid_1___kernel_j3d27pt0__ = FORMA_CEIL(__size_1___kernel_j3d27pt0__,__block_1___kernel_j3d27pt0__);
  int __grid_2___kernel_j3d27pt0__ = FORMA_CEIL(__size_2___kernel_j3d27pt0__,__block_2___kernel_j3d27pt0__);
  dim3 __gridConfig___kernel_j3d27pt0__(__grid_0___kernel_j3d27pt0__,__grid_1___kernel_j3d27pt0__,__grid_2___kernel_j3d27pt0__);

  __kernel_j3d27pt0__<<<__gridConfig___kernel_j3d27pt0__, __blockConfig___kernel_j3d27pt0__, __SMemSize___kernel_j3d27pt0__>>> (input, L, M, N, __var_2__);
  __kernel_j3d27pt0__<<<__gridConfig___kernel_j3d27pt0__, __blockConfig___kernel_j3d27pt0__, __SMemSize___kernel_j3d27pt0__>>> (__var_2__, L, M, N, __var_1__);
  __kernel_j3d27pt0__<<<__gridConfig___kernel_j3d27pt0__, __blockConfig___kernel_j3d27pt0__, __SMemSize___kernel_j3d27pt0__>>> (__var_1__, L, M, N, __var_2__);
  __kernel_j3d27pt0__<<<__gridConfig___kernel_j3d27pt0__, __blockConfig___kernel_j3d27pt0__, __SMemSize___kernel_j3d27pt0__>>> (__var_2__, L, M, N, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel_j3d27pt0__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(double)*(L*M*N), memcpy_kind___var_0__);
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
