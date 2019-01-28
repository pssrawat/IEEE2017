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
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_2__;
  __iter_2__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ; 
  if( __iter_2__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(0-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
  if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      int __temp_0__;
      __temp_0__ = __iter_4__+(-1);
      int __temp_1__;
      __temp_1__ = __iter_5__;
      float __temp_2__;
      __temp_2__ = (5 * __tilevar_2__[__temp_1__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_0__+(0-(__iter_1__+0)))]);
      int __temp_3__;
      __temp_3__ = __iter_4__;
      int __temp_4__;
      __temp_4__ = __iter_5__+(-1);
      float __temp_5__;
      __temp_5__ = (12 * __tilevar_2__[__temp_4__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_3__+(0-(__iter_1__+0)))]);
      float __temp_6__;
      __temp_6__ = (__temp_2__ + __temp_5__);
      int __temp_7__;
      __temp_7__ = __iter_4__;
      int __temp_8__;
      __temp_8__ = __iter_5__;
      float __temp_9__;
      __temp_9__ = (15 * __tilevar_2__[__temp_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_7__+(0-(__iter_1__+0)))]);
      float __temp_10__;
      __temp_10__ = (__temp_6__ + __temp_9__);
      int __temp_11__;
      __temp_11__ = __iter_4__;
      int __temp_12__;
      __temp_12__ = __iter_5__+(1);
      float __temp_13__;
      __temp_13__ = (12 * __tilevar_2__[__temp_12__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_11__+(0-(__iter_1__+0)))]);
      float __temp_14__;
      __temp_14__ = (__temp_10__ + __temp_13__);
      int __temp_15__;
      __temp_15__ = __iter_4__+(1);
      int __temp_16__;
      __temp_16__ = __iter_5__;
      float __temp_17__;
      __temp_17__ = (5 * __tilevar_2__[__temp_16__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_15__+(0-(__iter_1__+0)))]);
      float __temp_18__;
      __temp_18__ = (__temp_14__ + __temp_17__);
      float __temp_19__;
      __temp_19__ = (__temp_18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+1)))] = __temp_19__;
    }
  }
  int __iter_6__;
  __iter_6__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
  if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
    if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      if (__iter_6__ < (FORMA_MAX((__iter_1__+1),1)+2) || __iter_6__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))-2) || __iter_7__ < (FORMA_MAX((__iter_0__+1),1)+2) || __iter_7__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2))-2)) {
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+1)))];
      }
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
  if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      int __temp_30__;
      __temp_30__ = __iter_10__+(-1);
      int __temp_31__;
      __temp_31__ = __iter_11__;
      float __temp_32__;
      __temp_32__ = (5 * __tilevar_3__[__temp_31__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__temp_30__+(0-(__iter_1__+1)))]);
      int __temp_33__;
      __temp_33__ = __iter_10__;
      int __temp_34__;
      __temp_34__ = __iter_11__+(-1);
      float __temp_35__;
      __temp_35__ = (12 * __tilevar_3__[__temp_34__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__temp_33__+(0-(__iter_1__+1)))]);
      float __temp_36__;
      __temp_36__ = (__temp_32__ + __temp_35__);
      int __temp_37__;
      __temp_37__ = __iter_10__;
      int __temp_38__;
      __temp_38__ = __iter_11__;
      float __temp_39__;
      __temp_39__ = (15 * __tilevar_3__[__temp_38__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__temp_37__+(0-(__iter_1__+1)))]);
      float __temp_40__;
      __temp_40__ = (__temp_36__ + __temp_39__);
      int __temp_41__;
      __temp_41__ = __iter_10__;
      int __temp_42__;
      __temp_42__ = __iter_11__+(1);
      float __temp_43__;
      __temp_43__ = (12 * __tilevar_3__[__temp_42__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__temp_41__+(0-(__iter_1__+1)))]);
      float __temp_44__;
      __temp_44__ = (__temp_40__ + __temp_43__);
      int __temp_45__;
      __temp_45__ = __iter_10__+(1);
      int __temp_46__;
      __temp_46__ = __iter_11__;
      float __temp_47__;
      __temp_47__ = (5 * __tilevar_3__[__temp_46__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__temp_45__+(0-(__iter_1__+1)))]);
      float __temp_48__;
      __temp_48__ = (__temp_44__ + __temp_47__);
      float __temp_49__;
      __temp_49__ = (__temp_48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+2)))] = __temp_49__;
    }
  }
  int __iter_12__;
  __iter_12__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
  if( __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) ){
    int __iter_13__;
    __iter_13__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
    if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      if (__iter_12__ < (FORMA_MAX((__iter_1__+2),1)+2) || __iter_12__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))-2) || __iter_13__ < (FORMA_MAX((__iter_0__+2),1)+2) || __iter_13__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2))-2)) {
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+2)))];
      }
    }
  }
  __syncthreads();
  int __iter_16__;
  __iter_16__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
  if( __iter_16__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      float __temp_60__;
      __temp_60__ = (5 * __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+2)))]);
      float __temp_61__;
      __temp_61__ = (12 * __tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_62__;
      __temp_62__ = (__temp_60__ + __temp_61__);
      float __temp_63__;
      __temp_63__ = (15 * __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_64__;
      __temp_64__ = (__temp_62__ + __temp_63__);
      float __temp_65__;
      __temp_65__ = (12 * __tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_66__;
      __temp_66__ = (__temp_64__ + __temp_65__);
      float __temp_67__;
      __temp_67__ = (5 * __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_68__;
      __temp_68__ = (__temp_66__ + __temp_67__);
      float __temp_69__;
      __temp_69__ = (__temp_68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+3)))] = __temp_69__;
    }
  }
  int __iter_18__;
  __iter_18__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
  if( __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ){
    int __iter_19__;
    __iter_19__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
    if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      if (__iter_18__ < (FORMA_MAX((__iter_1__+3),1)+2) || __iter_18__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))-2) || __iter_19__ < (FORMA_MAX((__iter_0__+3),1)+2) || __iter_19__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2))-2)) {
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+3)))];
      }
    }
  }
  __syncthreads();
  int __iter_22__;
  __iter_22__ = FORMA_MAX((__iter_1__+4),1) + (int)(threadIdx.y) ; 
  if( __iter_22__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
      float __temp_80__;
      __temp_80__ = (5 * __tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+3)))]);
      float __temp_81__;
      __temp_81__ = (12 * __tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+3)))]);
      float __temp_82__;
      __temp_82__ = (__temp_80__ + __temp_81__);
      float __temp_83__;
      __temp_83__ = (15 * __tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+3)))]);
      float __temp_84__;
      __temp_84__ = (__temp_82__ + __temp_83__);
      float __temp_85__;
      __temp_85__ = (12 * __tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+3)))]);
      float __temp_86__;
      __temp_86__ = (__temp_84__ + __temp_85__);
      float __temp_87__;
      __temp_87__ = (5 * __tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+3)))]);
      float __temp_88__;
      __temp_88__ = (__temp_86__ + __temp_87__);
      float __temp_89__;
      __temp_89__ = (__temp_88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_89__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  return SMemSize;
}

__global__ void __kernel___forma_kernel__1__(float * __restrict__ input, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __copy_arr_0__){
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_8__;
  __iter_8__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
  for( ; __iter_8__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2)) ; __iter_8__ += (int)(blockDim.y) ){
    int __iter_9__;
    __iter_9__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
    if( __iter_9__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      if (__iter_8__ < FORMA_MAX((__iter_1__+1),1) || __iter_8__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) || __iter_9__ < FORMA_MAX((__iter_0__+1),1) || __iter_9__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2))) {
        float __temp_20__;
        __temp_20__ = (5 * input[__iter_9__+(M-0)*(__iter_8__+(-1))]);
        float __temp_21__;
        __temp_21__ = (12 * input[__iter_9__+(-1)+(M-0)*(__iter_8__)]);
        float __temp_22__;
        __temp_22__ = (__temp_20__ + __temp_21__);
        float __temp_23__;
        __temp_23__ = (15 * input[__iter_9__+(M-0)*(__iter_8__)]);
        float __temp_24__;
        __temp_24__ = (__temp_22__ + __temp_23__);
        float __temp_25__;
        __temp_25__ = (12 * input[__iter_9__+(1)+(M-0)*(__iter_8__)]);
        float __temp_26__;
        __temp_26__ = (__temp_24__ + __temp_25__);
        float __temp_27__;
        __temp_27__ = (5 * input[__iter_9__+(M-0)*(__iter_8__+(1))]);
        float __temp_28__;
        __temp_28__ = (__temp_26__ + __temp_27__);
        float __temp_29__;
        __temp_29__ = (__temp_28__ / 118);
        __copy_arr_0__[__iter_9__+(M-0)*(__iter_8__)] = __temp_29__;
      }
    }
  }
}

__global__ void __kernel___forma_kernel__2__(float * __restrict__ __copy_arr_0__, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __copy_arr_1__){
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_14__;
  __iter_14__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
  for( ; __iter_14__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2)) ; __iter_14__ += (int)(blockDim.y) ){
    int __iter_15__;
    __iter_15__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
    if( __iter_15__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      if (__iter_14__ < FORMA_MAX((__iter_1__+2),1) || __iter_14__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) || __iter_15__ < FORMA_MAX((__iter_0__+2),1) || __iter_15__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2))) {
        float __temp_50__;
        __temp_50__ = (5 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__+(-1))]);
        float __temp_51__;
        __temp_51__ = (12 * __copy_arr_0__[__iter_15__+(-1)+(M-0)*(__iter_14__)]);
        float __temp_52__;
        __temp_52__ = (__temp_50__ + __temp_51__);
        float __temp_53__;
        __temp_53__ = (15 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__)]);
        float __temp_54__;
        __temp_54__ = (__temp_52__ + __temp_53__);
        float __temp_55__;
        __temp_55__ = (12 * __copy_arr_0__[__iter_15__+(1)+(M-0)*(__iter_14__)]);
        float __temp_56__;
        __temp_56__ = (__temp_54__ + __temp_55__);
        float __temp_57__;
        __temp_57__ = (5 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__+(1))]);
        float __temp_58__;
        __temp_58__ = (__temp_56__ + __temp_57__);
        float __temp_59__;
        __temp_59__ = (__temp_58__ / 118);
        __copy_arr_1__[__iter_15__+(M-0)*(__iter_14__)] = __temp_59__;
      }
    }
  }
}

__global__ void __kernel___forma_kernel__3__(float * __restrict__ __copy_arr_1__, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __copy_arr_2__){
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_20__;
  __iter_20__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
  for( ; __iter_20__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2)) ; __iter_20__ += (int)(blockDim.y) ){
    int __iter_21__;
    __iter_21__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
    if( __iter_21__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      if (__iter_20__ < FORMA_MAX((__iter_1__+3),1) || __iter_20__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) || __iter_21__ < FORMA_MAX((__iter_0__+3),1) || __iter_21__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2))) {
        float __temp_70__;
        __temp_70__ = (5 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__+(-1))]);
        float __temp_71__;
        __temp_71__ = (12 * __copy_arr_1__[__iter_21__+(-1)+(M-0)*(__iter_20__)]);
        float __temp_72__;
        __temp_72__ = (__temp_70__ + __temp_71__);
        float __temp_73__;
        __temp_73__ = (15 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__)]);
        float __temp_74__;
        __temp_74__ = (__temp_72__ + __temp_73__);
        float __temp_75__;
        __temp_75__ = (12 * __copy_arr_1__[__iter_21__+(1)+(M-0)*(__iter_20__)]);
        float __temp_76__;
        __temp_76__ = (__temp_74__ + __temp_75__);
        float __temp_77__;
        __temp_77__ = (5 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__+(1))]);
        float __temp_78__;
        __temp_78__ = (__temp_76__ + __temp_77__);
        float __temp_79__;
        __temp_79__ = (__temp_78__ / 118);
        __copy_arr_2__[__iter_21__+(M-0)*(__iter_20__)] = __temp_79__;
      }
    }
  }
}

__global__ void __kernel___forma_kernel__4__(float * __restrict__ __copy_arr_2__, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_24__;
  __iter_24__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2)) ; __iter_24__ += (int)(blockDim.y) ){
    int __iter_25__;
    __iter_25__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
    if( __iter_25__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      if (__iter_24__ < FORMA_MAX((__iter_1__+4),1) || __iter_24__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-2)) || __iter_25__ < FORMA_MAX((__iter_0__+4),1) || __iter_25__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2))) {
        float __temp_90__;
        __temp_90__ = (5 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__+(-1))]);
        float __temp_91__;
        __temp_91__ = (12 * __copy_arr_2__[__iter_25__+(-1)+(M-0)*(__iter_24__)]);
        float __temp_92__;
        __temp_92__ = (__temp_90__ + __temp_91__);
        float __temp_93__;
        __temp_93__ = (15 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__)]);
        float __temp_94__;
        __temp_94__ = (__temp_92__ + __temp_93__);
        float __temp_95__;
        __temp_95__ = (12 * __copy_arr_2__[__iter_25__+(1)+(M-0)*(__iter_24__)]);
        float __temp_96__;
        __temp_96__ = (__temp_94__ + __temp_95__);
        float __temp_97__;
        __temp_97__ = (5 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__+(1))]);
        float __temp_98__;
        __temp_98__ = (__temp_96__ + __temp_97__);
        float __temp_99__;
        __temp_99__ = (__temp_98__ / 118);
        __var_1__[__iter_25__+(M-0)*(__iter_24__)] = __temp_99__;
      }
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
  float * __copy_arr_0__;
  cudaMalloc(&__copy_arr_0__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_0__\n");
  float * __copy_arr_1__;
  cudaMalloc(&__copy_arr_1__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_1__\n");
  float * __copy_arr_2__;
  cudaMalloc(&__copy_arr_2__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_2__\n");
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
  int __size_1___kernel___forma_kernel__0__ = ((N-1) - 0 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int _max_occupancy_gridsize___kernel___forma_kernel__0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__0__,&__max_occupancy_blocksize___kernel___forma_kernel__0__,(const void*)__kernel___forma_kernel__0__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__0___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__0___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),7);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_1___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),7);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  while( __SMemSize___kernel___forma_kernel__0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__0__.y/2 > 7)
      __blockConfig___kernel___forma_kernel__0__.y /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.x/2 > FORMA_MIN(32,7))
      __blockConfig___kernel___forma_kernel__0__.x /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  }
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  dim3 __blockConfig___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/2);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__1__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __copy_arr_0__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");

  dim3 __blockConfig___kernel___forma_kernel__2__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/2);
  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__2__>>> (__copy_arr_0__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __copy_arr_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");

  dim3 __blockConfig___kernel___forma_kernel__3__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/2);
  __kernel___forma_kernel__3__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__3__>>> (__copy_arr_1__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __copy_arr_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__3__\n");

  dim3 __blockConfig___kernel___forma_kernel__4__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/2);
  __kernel___forma_kernel__4__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__4__>>> (__copy_arr_2__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__4__\n");

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
  cudaFree(__copy_arr_0__);
  cudaFree(__copy_arr_1__);
  cudaFree(__copy_arr_2__);
}
/*Host Free End*/
