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
/*Shared Memory Variable */
extern __shared__ char __FORMA_SHARED_MEM__[];
/* Device code Begin */
__global__ void __kernel_jacobi0__(float * __restrict__ input, int M, int N, float * __var_2__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 1;
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 1;
  {
    int __iter_2__;
    __iter_2__ = (FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y*1); 
    if (__iter_2__ <= (FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1)) {
      int __iter_3__;
      __iter_3__ = (FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x); 
      if (__iter_3__ <= (FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1)) {
        int __temp_0__;
        __temp_0__ = (__iter_2__+0);
        int __temp_1__;
        __temp_1__ = (__iter_3__+0);
        __tilevar_1__[(__iter_3__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_2__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1))))] = input[__temp_1__+(M-0)*(__temp_0__)];
      }
    }
  }
  __syncthreads();
  {
    int __iter_4__;
    __iter_4__ = FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1) + (int)(threadIdx.y*1); 
    if (__iter_4__ <= FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))) {
      int __iter_5__;
      __iter_5__ = FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1) + (int)(threadIdx.x); 
      if (__iter_5__ <= FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))) {
        float __temp_2__;
        __temp_2__ = (5.000000f * __tilevar_1__[(__iter_5__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_4__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1))))]);
        float __temp_3__;
        __temp_3__ = (12.000000f * __tilevar_1__[(__iter_5__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_4__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1))))]);
        float __temp_4__;
        __temp_4__ = (__temp_2__ + __temp_3__);
        float __temp_5__;
        __temp_5__ = (15.000000f * __tilevar_1__[(__iter_5__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_4__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1))))]);
        float __temp_6__;
        __temp_6__ = (__temp_4__ + __temp_5__);
        float __temp_7__;
        __temp_7__ = (12.000000f * __tilevar_1__[(__iter_5__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_4__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1))))]);
        float __temp_8__;
        __temp_8__ = (__temp_6__ + __temp_7__);
        float __temp_9__;
        __temp_9__ = (5.000000f * __tilevar_1__[(__iter_5__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_4__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1))))]);
        float __temp_10__;
        __temp_10__ = (__temp_8__ + __temp_9__);
        float __temp_11__;
        __temp_11__ = (__temp_10__ / 118.000000f);
        __tilevar_0__[(__iter_5__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_4__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1))))] = __temp_11__;
      }
    }
  }
  __syncthreads();
  {
    int __iter_6__;
    __iter_6__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y*1); 
    if (__iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))) {
      int __iter_7__;
      __iter_7__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x); 
      if (__iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))) {
        float __temp_12__;
        __temp_12__ = (5.000000f * __tilevar_0__[(__iter_7__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1))))]);
        float __temp_13__;
        __temp_13__ = (12.000000f * __tilevar_0__[(__iter_7__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_6__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1))))]);
        float __temp_14__;
        __temp_14__ = (__temp_12__ + __temp_13__);
        float __temp_15__;
        __temp_15__ = (15.000000f * __tilevar_0__[(__iter_7__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_6__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1))))]);
        float __temp_16__;
        __temp_16__ = (__temp_14__ + __temp_15__);
        float __temp_17__;
        __temp_17__ = (12.000000f * __tilevar_0__[(__iter_7__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_6__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1))))]);
        float __temp_18__;
        __temp_18__ = (__temp_16__ + __temp_17__);
        float __temp_19__;
        __temp_19__ = (5.000000f * __tilevar_0__[(__iter_7__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_6__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1))))]);
        float __temp_20__;
        __temp_20__ = (__temp_18__ + __temp_19__);
        float __temp_21__;
        __temp_21__ = (__temp_20__ / 118.000000f);
        __var_2__[(__iter_7__+0)+(M-0)*((__iter_6__+0))] = __temp_21__;
      }
    }
  }
}
int __blockSizeToSMemSize___kernel_jacobi0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}
__global__ void __kernel_jacobi1__(float * __restrict__ __var_2__, int M, int N, float * __var_1__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  int __iter_8__;
  __iter_8__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 1;
  int __iter_9__;
  __iter_9__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 1;
  {
    int __iter_10__;
    __iter_10__ = (FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y*1); 
    if (__iter_10__ <= (FORMA_MIN((FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1)) {
      int __iter_11__;
      __iter_11__ = (FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x); 
      if (__iter_11__ <= (FORMA_MIN((FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1)) {
        int __temp_22__;
        __temp_22__ = (__iter_10__+0);
        int __temp_23__;
        __temp_23__ = (__iter_11__+0);
        __tilevar_3__[(__iter_11__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_10__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1))))] = __var_2__[__temp_23__+(M-0)*(__temp_22__)];
      }
    }
  }
  __syncthreads();
  {
    int __iter_12__;
    __iter_12__ = FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1) + (int)(threadIdx.y*1); 
    if (__iter_12__ <= FORMA_MIN((FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))) {
      int __iter_13__;
      __iter_13__ = FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1) + (int)(threadIdx.x); 
      if (__iter_13__ <= FORMA_MIN((FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))) {
        float __temp_24__;
        __temp_24__ = (5.000000f * __tilevar_3__[(__iter_13__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_12__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1))))]);
        float __temp_25__;
        __temp_25__ = (12.000000f * __tilevar_3__[(__iter_13__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_12__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1))))]);
        float __temp_26__;
        __temp_26__ = (__temp_24__ + __temp_25__);
        float __temp_27__;
        __temp_27__ = (15.000000f * __tilevar_3__[(__iter_13__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_12__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1))))]);
        float __temp_28__;
        __temp_28__ = (__temp_26__ + __temp_27__);
        float __temp_29__;
        __temp_29__ = (12.000000f * __tilevar_3__[(__iter_13__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_12__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1))))]);
        float __temp_30__;
        __temp_30__ = (__temp_28__ + __temp_29__);
        float __temp_31__;
        __temp_31__ = (5.000000f * __tilevar_3__[(__iter_13__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_12__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1))))]);
        float __temp_32__;
        __temp_32__ = (__temp_30__ + __temp_31__);
        float __temp_33__;
        __temp_33__ = (__temp_32__ / 118.000000f);
        __tilevar_2__[(__iter_13__+0)+(0-(FORMA_MAX(__iter_8__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_12__+0)+(0-(FORMA_MAX(__iter_9__,1)+(-1))))] = __temp_33__;
      }
    }
  }
  __syncthreads();
  {
    int __iter_14__;
    __iter_14__ = FORMA_MAX(__iter_9__,1) + (int)(threadIdx.y*1); 
    if (__iter_14__ <= FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-2))) {
      int __iter_15__;
      __iter_15__ = FORMA_MAX(__iter_8__,1) + (int)(threadIdx.x); 
      if (__iter_15__ <= FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-2))) {
        float __temp_34__;
        __temp_34__ = (5.000000f * __tilevar_2__[(__iter_15__+0)+(0-(FORMA_MAX(__iter_8__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_14__+0)+(-1)+(0-(FORMA_MAX(__iter_9__,1)+(-1))))]);
        float __temp_35__;
        __temp_35__ = (12.000000f * __tilevar_2__[(__iter_15__+0)+(-1)+(0-(FORMA_MAX(__iter_8__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_14__+0)+(0-(FORMA_MAX(__iter_9__,1)+(-1))))]);
        float __temp_36__;
        __temp_36__ = (__temp_34__ + __temp_35__);
        float __temp_37__;
        __temp_37__ = (15.000000f * __tilevar_2__[(__iter_15__+0)+(0-(FORMA_MAX(__iter_8__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_14__+0)+(0-(FORMA_MAX(__iter_9__,1)+(-1))))]);
        float __temp_38__;
        __temp_38__ = (__temp_36__ + __temp_37__);
        float __temp_39__;
        __temp_39__ = (12.000000f * __tilevar_2__[(__iter_15__+0)+(1)+(0-(FORMA_MAX(__iter_8__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_14__+0)+(0-(FORMA_MAX(__iter_9__,1)+(-1))))]);
        float __temp_40__;
        __temp_40__ = (__temp_38__ + __temp_39__);
        float __temp_41__;
        __temp_41__ = (5.000000f * __tilevar_2__[(__iter_15__+0)+(0-(FORMA_MAX(__iter_8__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_14__+0)+(1)+(0-(FORMA_MAX(__iter_9__,1)+(-1))))]);
        float __temp_42__;
        __temp_42__ = (__temp_40__ + __temp_41__);
        float __temp_43__;
        __temp_43__ = (__temp_42__ / 118.000000f);
        __var_1__[(__iter_15__+0)+(M-0)*((__iter_14__+0))] = __temp_43__;
      }
    }
  }
}
int __blockSizeToSMemSize___kernel_jacobi1__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}
/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(float * h_input, int M, int N, float * __var_0__){

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
  int __size_0___kernel_jacobi0__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel_jacobi0__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel_jacobi0__;
  int _max_occupancy_gridsize___kernel_jacobi0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel_jacobi0__,&__max_occupancy_blocksize___kernel_jacobi0__,(const void*)__kernel_jacobi0__,0,0);
  int __max_occupancy_blocksize___kernel_jacobi0___0 = pow((double)__max_occupancy_blocksize___kernel_jacobi0__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel_jacobi0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel_jacobi0___0/32, 1)*32;
  int __block_0___kernel_jacobi0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_jacobi0___0,FORMA_MAX((__size_0___kernel_jacobi0__/1)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel_jacobi0__ /= __block_0___kernel_jacobi0__;
  int __max_occupancy_blocksize___kernel_jacobi0___1 = __max_occupancy_blocksize___kernel_jacobi0__;
  int __block_1___kernel_jacobi0__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_jacobi0___1,__size_1___kernel_jacobi0__/1),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel_jacobi0__ /= __block_1___kernel_jacobi0__;
  dim3 __blockConfig___kernel_jacobi0__(__block_0___kernel_jacobi0__,__block_1___kernel_jacobi0__);
  int __SMemSize___kernel_jacobi0__ = 0;
  __SMemSize___kernel_jacobi0__ = __blockSizeToSMemSize___kernel_jacobi0__(__blockConfig___kernel_jacobi0__);
  while( __SMemSize___kernel_jacobi0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel_jacobi0__.y/2 > 5)
      __blockConfig___kernel_jacobi0__.y /= 2;
    __SMemSize___kernel_jacobi0__ = __blockSizeToSMemSize___kernel_jacobi0__(__blockConfig___kernel_jacobi0__);
    if( __SMemSize___kernel_jacobi0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel_jacobi0__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel_jacobi0__.x /= 2;
    __SMemSize___kernel_jacobi0__ = __blockSizeToSMemSize___kernel_jacobi0__(__blockConfig___kernel_jacobi0__);
  }
  __block_0___kernel_jacobi0__ = __blockConfig___kernel_jacobi0__.x-(2-(-2));
  __block_1___kernel_jacobi0__ = __blockConfig___kernel_jacobi0__.y-(2-(-2));
  int __grid_0___kernel_jacobi0__ = FORMA_CEIL(__size_0___kernel_jacobi0__,__block_0___kernel_jacobi0__*1);
  int __grid_1___kernel_jacobi0__ = FORMA_CEIL(__size_1___kernel_jacobi0__,__block_1___kernel_jacobi0__*1);
  dim3 __gridConfig___kernel_jacobi0__(__grid_0___kernel_jacobi0__,__grid_1___kernel_jacobi0__);
  __kernel_jacobi0__<<<__gridConfig___kernel_jacobi0__,__blockConfig___kernel_jacobi0__,__SMemSize___kernel_jacobi0__>>>(input,   M,  N,__var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel_jacobi0__\n");
  int __size_0___kernel_jacobi1__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel_jacobi1__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel_jacobi1__;
  int _max_occupancy_gridsize___kernel_jacobi1__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel_jacobi1__,&__max_occupancy_blocksize___kernel_jacobi1__,(const void*)__kernel_jacobi1__,0,0);
  int __max_occupancy_blocksize___kernel_jacobi1___0 = pow((double)__max_occupancy_blocksize___kernel_jacobi1__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel_jacobi1___0 = FORMA_MAX(__max_occupancy_blocksize___kernel_jacobi1___0/32, 1)*32;
  int __block_0___kernel_jacobi1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_jacobi1___0,FORMA_MAX((__size_0___kernel_jacobi1__/1)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel_jacobi1__ /= __block_0___kernel_jacobi1__;
  int __max_occupancy_blocksize___kernel_jacobi1___1 = __max_occupancy_blocksize___kernel_jacobi1__;
  int __block_1___kernel_jacobi1__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_jacobi1___1,__size_1___kernel_jacobi1__/1),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel_jacobi1__ /= __block_1___kernel_jacobi1__;
  dim3 __blockConfig___kernel_jacobi1__(__block_0___kernel_jacobi1__,__block_1___kernel_jacobi1__);
  int __SMemSize___kernel_jacobi1__ = 0;
  __SMemSize___kernel_jacobi1__ = __blockSizeToSMemSize___kernel_jacobi1__(__blockConfig___kernel_jacobi1__);
  while( __SMemSize___kernel_jacobi1__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel_jacobi1__.y/2 > 5)
      __blockConfig___kernel_jacobi1__.y /= 2;
    __SMemSize___kernel_jacobi1__ = __blockSizeToSMemSize___kernel_jacobi1__(__blockConfig___kernel_jacobi1__);
    if( __SMemSize___kernel_jacobi1__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel_jacobi1__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel_jacobi1__.x /= 2;
    __SMemSize___kernel_jacobi1__ = __blockSizeToSMemSize___kernel_jacobi1__(__blockConfig___kernel_jacobi1__);
  }
  __block_0___kernel_jacobi1__ = __blockConfig___kernel_jacobi1__.x-(2-(-2));
  __block_1___kernel_jacobi1__ = __blockConfig___kernel_jacobi1__.y-(2-(-2));
  int __grid_0___kernel_jacobi1__ = FORMA_CEIL(__size_0___kernel_jacobi1__,__block_0___kernel_jacobi1__*1);
  int __grid_1___kernel_jacobi1__ = FORMA_CEIL(__size_1___kernel_jacobi1__,__block_1___kernel_jacobi1__*1);
  dim3 __gridConfig___kernel_jacobi1__(__grid_0___kernel_jacobi1__,__grid_1___kernel_jacobi1__);
  __kernel_jacobi1__<<<__gridConfig___kernel_jacobi1__,__blockConfig___kernel_jacobi1__,__SMemSize___kernel_jacobi1__>>>(__var_2__,   M,  N,__var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel_jacobi1__\n");
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
}
/*Host Free End*/
