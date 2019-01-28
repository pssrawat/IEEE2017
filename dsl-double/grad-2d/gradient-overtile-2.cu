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
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, float * __restrict__ __var_2__){
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
  int __iter_2__;
  __iter_2__ = (FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y) ; 
  if( __iter_2__ <= (FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1) ){
    int __iter_3__;
    __iter_3__ = (FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= (FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1) ){
      int __temp_0__;
      __temp_0__ = __iter_2__;
      int __temp_1__;
      __temp_1__ = __iter_3__;
      __tilevar_1__[__iter_3__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_2__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] = input[__temp_1__+(M-0)*(__temp_0__)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1) + (int)(threadIdx.y) ; 
  if( __iter_4__ <= FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2)) ){
      float __temp_2__;
      __temp_2__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_3__;
      __temp_3__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_4__;
      __temp_4__ = (__temp_2__ * __temp_3__);
      float __temp_5__;
      __temp_5__ = (0.000100f + __temp_4__);
      float __temp_6__;
      __temp_6__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_7__;
      __temp_7__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_8__;
      __temp_8__ = (__temp_6__ * __temp_7__);
      float __temp_9__;
      __temp_9__ = (__temp_5__ + __temp_8__);
      float __temp_10__;
      __temp_10__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_11__;
      __temp_11__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_12__;
      __temp_12__ = (__temp_10__ * __temp_11__);
      float __temp_13__;
      __temp_13__ = (__temp_9__ + __temp_12__);
      float __temp_14__;
      __temp_14__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_15__;
      __temp_15__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] - __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_16__;
      __temp_16__ = (__temp_14__ * __temp_15__);
      float __temp_17__;
      __temp_17__ = (__temp_13__ + __temp_16__);
      float __temp_18__;
      __temp_18__ = sqrt(__temp_17__);
      float __temp_19__;
      __temp_19__ = (1.000000f / __temp_18__);
      float __temp_20__;
      __temp_20__ = (__tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] + __temp_19__);
      __tilevar_0__[__iter_5__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_4__+(0-(FORMA_MAX(__iter_1__,1)-1)))] = __temp_20__;
    }
  }
  __syncthreads();
  int __iter_6__;
  __iter_6__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
  if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2)) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
    if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      float __temp_21__;
      __temp_21__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_22__;
      __temp_22__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_23__;
      __temp_23__ = (__temp_21__ * __temp_22__);
      float __temp_24__;
      __temp_24__ = (0.000100f + __temp_23__);
      float __temp_25__;
      __temp_25__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_26__;
      __temp_26__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_27__;
      __temp_27__ = (__temp_25__ * __temp_26__);
      float __temp_28__;
      __temp_28__ = (__temp_24__ + __temp_27__);
      float __temp_29__;
      __temp_29__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_30__;
      __temp_30__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_31__;
      __temp_31__ = (__temp_29__ * __temp_30__);
      float __temp_32__;
      __temp_32__ = (__temp_28__ + __temp_31__);
      float __temp_33__;
      __temp_33__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_34__;
      __temp_34__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] - __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_35__;
      __temp_35__ = (__temp_33__ * __temp_34__);
      float __temp_36__;
      __temp_36__ = (__temp_32__ + __temp_35__);
      float __temp_37__;
      __temp_37__ = sqrt(__temp_36__);
      float __temp_38__;
      __temp_38__ = (1.000000f / __temp_37__);
      float __temp_39__;
      __temp_39__ = (__tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,1)-1)))] + __temp_38__);
      __var_2__[__iter_7__+(M-0)*(__iter_6__)] = __temp_39__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}

__global__ void __kernel___forma_kernel__1__(float * __restrict__ __var_2__, int N, int M, float * __restrict__ __var_1__){
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
  int __iter_10__;
  __iter_10__ = (FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y) ; 
  if( __iter_10__ <= (FORMA_MIN((FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1) ){
    int __iter_11__;
    __iter_11__ = (FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= (FORMA_MIN((FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1) ){
      int __temp_40__;
      __temp_40__ = __iter_10__;
      int __temp_41__;
      __temp_41__ = __iter_11__;
      __tilevar_3__[__iter_11__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] = __var_2__[__temp_41__+(M-0)*(__temp_40__)];
    }
  }
  __syncthreads();
  int __iter_12__;
  __iter_12__ = FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1) + (int)(threadIdx.y) ; 
  if( __iter_12__ <= FORMA_MIN((FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2)) ){
    int __iter_13__;
    __iter_13__ = FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1) + (int)(threadIdx.x) ; 
    if( __iter_13__ <= FORMA_MIN((FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2)) ){
      float __temp_42__;
      __temp_42__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_43__;
      __temp_43__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_44__;
      __temp_44__ = (__temp_42__ * __temp_43__);
      float __temp_45__;
      __temp_45__ = (0.000100f + __temp_44__);
      float __temp_46__;
      __temp_46__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_47__;
      __temp_47__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_48__;
      __temp_48__ = (__temp_46__ * __temp_47__);
      float __temp_49__;
      __temp_49__ = (__temp_45__ + __temp_48__);
      float __temp_50__;
      __temp_50__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_51__;
      __temp_51__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_52__;
      __temp_52__ = (__temp_50__ * __temp_51__);
      float __temp_53__;
      __temp_53__ = (__temp_49__ + __temp_52__);
      float __temp_54__;
      __temp_54__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_55__;
      __temp_55__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] - __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))]);
      float __temp_56__;
      __temp_56__ = (__temp_54__ * __temp_55__);
      float __temp_57__;
      __temp_57__ = (__temp_53__ + __temp_56__);
      float __temp_58__;
      __temp_58__ = sqrt(__temp_57__);
      float __temp_59__;
      __temp_59__ = (1.000000f / __temp_58__);
      float __temp_60__;
      __temp_60__ = (__tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,1)+(-1)),1)-1)))] + __temp_59__);
      __tilevar_2__[__iter_13__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_12__+(0-(FORMA_MAX(__iter_9__,1)-1)))] = __temp_60__;
    }
  }
  __syncthreads();
  int __iter_14__;
  __iter_14__ = FORMA_MAX(__iter_9__,1) + (int)(threadIdx.y) ; 
  if( __iter_14__ <= FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-2)) ){
    int __iter_15__;
    __iter_15__ = FORMA_MAX(__iter_8__,1) + (int)(threadIdx.x) ; 
    if( __iter_15__ <= FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      float __temp_61__;
      __temp_61__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_62__;
      __temp_62__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_63__;
      __temp_63__ = (__temp_61__ * __temp_62__);
      float __temp_64__;
      __temp_64__ = (0.000100f + __temp_63__);
      float __temp_65__;
      __temp_65__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_66__;
      __temp_66__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_67__;
      __temp_67__ = (__temp_65__ * __temp_66__);
      float __temp_68__;
      __temp_68__ = (__temp_64__ + __temp_67__);
      float __temp_69__;
      __temp_69__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_70__;
      __temp_70__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_71__;
      __temp_71__ = (__temp_69__ * __temp_70__);
      float __temp_72__;
      __temp_72__ = (__temp_68__ + __temp_71__);
      float __temp_73__;
      __temp_73__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_74__;
      __temp_74__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] - __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))]);
      float __temp_75__;
      __temp_75__ = (__temp_73__ * __temp_74__);
      float __temp_76__;
      __temp_76__ = (__temp_72__ + __temp_75__);
      float __temp_77__;
      __temp_77__ = sqrt(__temp_76__);
      float __temp_78__;
      __temp_78__ = (1.000000f / __temp_77__);
      float __temp_79__;
      __temp_79__ = (__tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,1)-1)))] + __temp_78__);
      __var_1__[__iter_15__+(M-0)*(__iter_14__)] = __temp_79__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__1__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void gradient (float * h_input, int N, int M, float * __var_0__){

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
  int __size_0___kernel___forma_kernel__0__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int _max_occupancy_gridsize___kernel___forma_kernel__0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__0__,&__max_occupancy_blocksize___kernel___forma_kernel__0__,(const void*)__kernel___forma_kernel__0__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__0___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__0___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_1___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  while( __SMemSize___kernel___forma_kernel__0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__0__.y/2 > 5)
      __blockConfig___kernel___forma_kernel__0__.y /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel___forma_kernel__0__.x /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  }
  __block_0___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.x-(2-(-2));
  __block_1___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.y-(2-(-2));
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  int __size_0___kernel___forma_kernel__1__ = ((M-2) - 1 ) + 1;
  int __size_1___kernel___forma_kernel__1__ = ((N-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__1__;
  int _max_occupancy_gridsize___kernel___forma_kernel__1__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__1__,&__max_occupancy_blocksize___kernel___forma_kernel__1__,(const void*)__kernel___forma_kernel__1__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__1___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__1__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__1___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__1___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__1___0,FORMA_MAX((__size_0___kernel___forma_kernel__1__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel___forma_kernel__1__ /= __block_0___kernel___forma_kernel__1__;
  int __max_occupancy_blocksize___kernel___forma_kernel__1___1 = __max_occupancy_blocksize___kernel___forma_kernel__1__;
  int __block_1___kernel___forma_kernel__1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__1___1,__size_1___kernel___forma_kernel__1__),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel___forma_kernel__1__ /= __block_1___kernel___forma_kernel__1__;
  dim3 __blockConfig___kernel___forma_kernel__1__(__block_0___kernel___forma_kernel__1__,__block_1___kernel___forma_kernel__1__);
  int __SMemSize___kernel___forma_kernel__1__ = 0;
  __SMemSize___kernel___forma_kernel__1__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__1__);
  while( __SMemSize___kernel___forma_kernel__1__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__1__.y/2 > 5)
      __blockConfig___kernel___forma_kernel__1__.y /= 2;
    __SMemSize___kernel___forma_kernel__1__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__1__);
    if( __SMemSize___kernel___forma_kernel__1__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__1__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel___forma_kernel__1__.x /= 2;
    __SMemSize___kernel___forma_kernel__1__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__1__);
  }
  __block_0___kernel___forma_kernel__1__ = __blockConfig___kernel___forma_kernel__1__.x-(2-(-2));
  __block_1___kernel___forma_kernel__1__ = __blockConfig___kernel___forma_kernel__1__.y-(2-(-2));
  int __grid_0___kernel___forma_kernel__1__ = FORMA_CEIL(__size_0___kernel___forma_kernel__1__,__block_0___kernel___forma_kernel__1__);
  int __grid_1___kernel___forma_kernel__1__ = FORMA_CEIL(__size_1___kernel___forma_kernel__1__,__block_1___kernel___forma_kernel__1__);
  dim3 __gridConfig___kernel___forma_kernel__1__(__grid_0___kernel___forma_kernel__1__,__grid_1___kernel___forma_kernel__1__);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__1__, __blockConfig___kernel___forma_kernel__1__, __SMemSize___kernel___forma_kernel__1__>>> (__var_2__, N, M, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");
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
