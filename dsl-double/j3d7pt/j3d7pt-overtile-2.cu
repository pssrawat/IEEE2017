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

__global__ void __kernel___forma_kernel__1__(float * __restrict__ __var_2__, int L, int M, int N, float * __restrict__ __var_1__){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z)- (2-(-2));
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-4))*(FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-2))*(FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  int __iter_12__;
  __iter_12__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 1;
  int __iter_13__;
  __iter_13__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 1;
  int __iter_14__;
  __iter_14__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + 1;
  int __iter_15__;
  __iter_15__ = (FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)) + (int)(threadIdx.z) ; 
  if( __iter_15__ <= (FORMA_MIN((FORMA_MIN(((__iter_14__+FORMA_BLOCKDIM_Z)-1),(L-2))+1),(L-2))+1) ){
    int __iter_16__;
    __iter_16__ = (FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y) ; 
    if( __iter_16__ <= (FORMA_MIN((FORMA_MIN(((__iter_13__+FORMA_BLOCKDIM_Y)-1),(M-2))+1),(M-2))+1) ){
      int __iter_17__;
      __iter_17__ = (FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= (FORMA_MIN((FORMA_MIN(((__iter_12__+FORMA_BLOCKDIM_X)-1),(N-2))+1),(N-2))+1) ){
        int __temp_29__;
        __temp_29__ = __iter_15__;
        int __temp_30__;
        __temp_30__ = __iter_16__;
        int __temp_31__;
        __temp_31__ = __iter_17__;
        __tilevar_3__[__iter_17__+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_16__+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_15__+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))] = __var_2__[__temp_31__+(N-0)*(__temp_30__+(M-0)*(__temp_29__))];
      }
    }
  }
  __syncthreads();
  int __iter_18__;
  __iter_18__ = FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1) + (int)(threadIdx.z) ; 
  if( __iter_18__ <= FORMA_MIN((FORMA_MIN(((__iter_14__+FORMA_BLOCKDIM_Z)-1),(L-2))+1),(L-2)) ){
    int __iter_19__;
    __iter_19__ = FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1) + (int)(threadIdx.y) ; 
    if( __iter_19__ <= FORMA_MIN((FORMA_MIN(((__iter_13__+FORMA_BLOCKDIM_Y)-1),(M-2))+1),(M-2)) ){
      int __iter_20__;
      __iter_20__ = FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN((FORMA_MIN(((__iter_12__+FORMA_BLOCKDIM_X)-1),(N-2))+1),(N-2)) ){
        float __temp_32__;
        __temp_32__ = (0.161000f * __tilevar_3__[__iter_20__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_33__;
        __temp_33__ = (0.162000f * __tilevar_3__[__iter_20__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_34__;
        __temp_34__ = (__temp_32__ + __temp_33__);
        float __temp_35__;
        __temp_35__ = (0.163000f * __tilevar_3__[__iter_20__+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_36__;
        __temp_36__ = (__temp_34__ + __temp_35__);
        float __temp_37__;
        __temp_37__ = (0.164000f * __tilevar_3__[__iter_20__+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_38__;
        __temp_38__ = (__temp_36__ + __temp_37__);
        float __temp_39__;
        __temp_39__ = (0.165000f * __tilevar_3__[__iter_20__+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_40__;
        __temp_40__ = (__temp_38__ + __temp_39__);
        float __temp_41__;
        __temp_41__ = (0.166000f * __tilevar_3__[__iter_20__+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_42__;
        __temp_42__ = (__temp_40__ + __temp_41__);
        float __temp_43__;
        __temp_43__ = (1.670000f * __tilevar_3__[__iter_20__+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_19__+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_Y-(-4))*(__iter_18__+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)-1))))]);
        float __temp_44__;
        __temp_44__ = (__temp_42__ - __temp_43__);
        __tilevar_2__[__iter_20__+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_19__+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_18__+(0-(FORMA_MAX(__iter_14__,1)-1))))] = __temp_44__;
      }
    }
  }
  __syncthreads();
  int __iter_21__;
  __iter_21__ = FORMA_MAX(__iter_14__,1) + (int)(threadIdx.z) ; 
  if( __iter_21__ <= FORMA_MIN(((__iter_14__+FORMA_BLOCKDIM_Z)-1),(L-2)) ){
    int __iter_22__;
    __iter_22__ = FORMA_MAX(__iter_13__,1) + (int)(threadIdx.y) ; 
    if( __iter_22__ <= FORMA_MIN(((__iter_13__+FORMA_BLOCKDIM_Y)-1),(M-2)) ){
      int __iter_23__;
      __iter_23__ = FORMA_MAX(__iter_12__,1) + (int)(threadIdx.x) ; 
      if( __iter_23__ <= FORMA_MIN(((__iter_12__+FORMA_BLOCKDIM_X)-1),(N-2)) ){
        float __temp_45__;
        __temp_45__ = (0.161000f * __tilevar_2__[__iter_23__+(1)+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_46__;
        __temp_46__ = (0.162000f * __tilevar_2__[__iter_23__+(-1)+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_47__;
        __temp_47__ = (__temp_45__ + __temp_46__);
        float __temp_48__;
        __temp_48__ = (0.163000f * __tilevar_2__[__iter_23__+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(1)+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_49__;
        __temp_49__ = (__temp_47__ + __temp_48__);
        float __temp_50__;
        __temp_50__ = (0.164000f * __tilevar_2__[__iter_23__+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(-1)+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_51__;
        __temp_51__ = (__temp_49__ + __temp_50__);
        float __temp_52__;
        __temp_52__ = (0.165000f * __tilevar_2__[__iter_23__+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(1)+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_53__;
        __temp_53__ = (__temp_51__ + __temp_52__);
        float __temp_54__;
        __temp_54__ = (0.166000f * __tilevar_2__[__iter_23__+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(-1)+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_55__;
        __temp_55__ = (__temp_53__ + __temp_54__);
        float __temp_56__;
        __temp_56__ = (1.670000f * __tilevar_2__[__iter_23__+(0-(FORMA_MAX(__iter_12__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_22__+(0-(FORMA_MAX(__iter_13__,1)-1))+(FORMA_BLOCKDIM_Y-(-2))*(__iter_21__+(0-(FORMA_MAX(__iter_14__,1)-1))))]);
        float __temp_57__;
        __temp_57__ = (__temp_55__ - __temp_56__);
        __var_1__[__iter_23__+(N-0)*(__iter_22__+(M-0)*(__iter_21__))] = __temp_57__;
      }
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__1__(dim3 blockDim){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z)- (2-(-2));
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-4))*(FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-2))*(FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d7pt(float * h_input, int L, int M, int N, float * __var_0__){

/* Host allocation Begin */
  float * input;
  cudaMalloc(&input,sizeof(float)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(float)*((L-0)*(M-0)*(N-0)), memcpy_kind_h_input);
  }
  float * __var_1__;
  cudaMalloc(&__var_1__,sizeof(float)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  float * __var_2__;
  cudaMalloc(&__var_2__,sizeof(float)*((L-0)*(M-0)*(N-0)));
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
  int __size_0___kernel___forma_kernel__0__ = ((N-2) - 1 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((M-2) - 1 ) + 1;
  int __size_2___kernel___forma_kernel__0__ = ((L-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int _max_occupancy_gridsize___kernel___forma_kernel__0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__0__,&__max_occupancy_blocksize___kernel___forma_kernel__0__,(const void*)__kernel___forma_kernel__1__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__0___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)3));
  __max_occupancy_blocksize___kernel___forma_kernel__0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__0___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__0__ = 16;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)2));
  int __block_1___kernel___forma_kernel__0__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___2 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_2___kernel___forma_kernel__0__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___2,__size_2___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_2),5);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_2___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__);
  while( __SMemSize___kernel___forma_kernel__0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__0__.z/2 > 5)
      __blockConfig___kernel___forma_kernel__0__.z /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.y/2 > 5)
      __blockConfig___kernel___forma_kernel__0__.y /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel___forma_kernel__0__.x /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__);
  }
  __block_0___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.x-(2-(-2));
  __block_1___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.y-(2-(-2));
  __block_2___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.z-(2-(-2));
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __grid_2___kernel___forma_kernel__0__ = FORMA_CEIL(__size_2___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  dim3 __gridConfig___kernel___forma_kernel__1__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__1__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __var_2__);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__1__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, L, M, N, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");
  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(float)*((L-0)*(M-0)*(N-0)), memcpy_kind___var_0__);
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
