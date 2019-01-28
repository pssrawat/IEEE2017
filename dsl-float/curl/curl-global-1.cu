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
__global__ void __kernel___forma_kernel__0__(struct float4 * __restrict__ input, float dx, float dy, float dz, int L, int M, int N, struct float4 * __restrict__ __copy_arr_0__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, struct float4 * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  struct float4* __tilevar_0__ = (struct float4*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(struct float4)*((FORMA_BLOCKDIM_Z*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X));

  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_2__;
  __iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z);
  __syncthreads();
  int __iter_3__;
  __iter_3__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_3__ += (int)(blockDim.z) ){
    int __iter_4__;
    __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ; 
    if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ){
      int __iter_5__;
      __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        float __temp_0__;
        __temp_0__ = (input[__iter_5__+N*(__iter_4__+M*(__iter_3__+1))].y - input[__iter_5__+N*(__iter_4__+M*__iter_3__)].y);
        float __temp_1__;
        __temp_1__ = (dz * __temp_0__);
        float __temp_2__;
        __temp_2__ = (input[__iter_5__+N*(__iter_4__+1+M*__iter_3__)].z - input[__iter_5__+N*(__iter_4__+M*__iter_3__)].z);
        float __temp_3__;
        __temp_3__ = (dy * __temp_2__);
        float __temp_4__;
        __temp_4__ = (__temp_1__ - __temp_3__);
        float __temp_5__;
        __temp_5__ = (input[__iter_5__+N*(__iter_4__+M*(__iter_3__+1))].x - input[__iter_5__+N*(__iter_4__+M*__iter_3__)].x);
        float __temp_6__;
        __temp_6__ = (dz * __temp_5__);
        float __temp_7__;
        __temp_7__ = (input[__iter_5__+1+N*(__iter_4__+M*__iter_3__)].z - input[__iter_5__+N*(__iter_4__+M*__iter_3__)].z);
        float __temp_8__;
        __temp_8__ = (dx * __temp_7__);
        float __temp_9__;
        __temp_9__ = (__temp_6__ - __temp_8__);
        float __temp_10__;
        __temp_10__ = (input[__iter_5__+N*(__iter_4__+1+M*__iter_3__)].x - input[__iter_5__+N*(__iter_4__+M*__iter_3__)].x);
        float __temp_11__;
        __temp_11__ = (dy * __temp_10__);
        float __temp_12__;
        __temp_12__ = (input[__iter_5__+1+N*(__iter_4__+M*__iter_3__)].y - input[__iter_5__+N*(__iter_4__+M*__iter_3__)].y);
        float __temp_13__;
        __temp_13__ = (dx * __temp_12__);
        float __temp_14__;
        __temp_14__ = (__temp_11__ - __temp_13__);
        float __temp_15__;
        __temp_15__ = (__temp_4__ + input[__iter_5__+N*(__iter_4__+M*__iter_3__)].x);
        float __temp_16__;
        __temp_16__ = (__temp_9__ + input[__iter_5__+N*(__iter_4__+M*__iter_3__)].y);
        float __temp_17__;
        __temp_17__ = (__temp_14__ + input[__iter_5__+N*(__iter_4__+M*__iter_3__)].z);
        __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_3__-__iter_2__))].x = __temp_15__;
        __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_3__-__iter_2__))].y = __temp_16__;
        __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_3__-__iter_2__))].z = __temp_17__;
        __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_3__-__iter_2__))].w = 0.000000f;
      }
    }
  }
  int __iter_6__;
  __iter_6__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_6__ += (int)(blockDim.z) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ; 
    if( __iter_7__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ){
      int __iter_8__;
      __iter_8__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_6__ < (FORMA_MAX(__iter_2__,0)+2) || __iter_6__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2))-2) || __iter_7__ < (FORMA_MAX(__iter_1__,0)+2) || __iter_7__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2) || __iter_8__ < (FORMA_MAX(__iter_0__,0)+2) || __iter_8__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_8__+N*(__iter_7__+M*__iter_6__)].x = __tilevar_0__[__iter_8__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_7__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_6__-__iter_2__))].x;
          __copy_arr_0__[__iter_8__+N*(__iter_7__+M*__iter_6__)].y = __tilevar_0__[__iter_8__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_7__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_6__-__iter_2__))].y;
          __copy_arr_0__[__iter_8__+N*(__iter_7__+M*__iter_6__)].z = __tilevar_0__[__iter_8__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_7__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_6__-__iter_2__))].z;
          __copy_arr_0__[__iter_8__+N*(__iter_7__+M*__iter_6__)].w = __tilevar_0__[__iter_8__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_7__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_6__-__iter_2__))].w;

        }
      }
    }
  }
  __syncthreads();
  int __iter_12__;
  __iter_12__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_12__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-1)) ; __iter_12__ += (int)(blockDim.z) ){
    int __iter_13__;
    __iter_13__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    if( __iter_13__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-1)) ){
      int __iter_14__;
      __iter_14__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_14__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-1)) ){
        float __temp_36__;
        __temp_36__ = (__tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].y - __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-1-__iter_2__))].y);
        float __temp_37__;
        __temp_37__ = (dz * __temp_36__);
        float __temp_38__;
        __temp_38__ = (__tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].z - __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-1-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].z);
        float __temp_39__;
        __temp_39__ = (dy * __temp_38__);
        float __temp_40__;
        __temp_40__ = (__temp_37__ - __temp_39__);
        float __temp_41__;
        __temp_41__ = (__tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].x - __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-1-__iter_2__))].x);
        float __temp_42__;
        __temp_42__ = (dz * __temp_41__);
        float __temp_43__;
        __temp_43__ = (__tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].z - __tilevar_0__[__iter_14__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].z);
        float __temp_44__;
        __temp_44__ = (dx * __temp_43__);
        float __temp_45__;
        __temp_45__ = (__temp_42__ - __temp_44__);
        float __temp_46__;
        __temp_46__ = (__tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].x - __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-1-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].x);
        float __temp_47__;
        __temp_47__ = (dy * __temp_46__);
        float __temp_48__;
        __temp_48__ = (__tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].y - __tilevar_0__[__iter_14__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].y);
        float __temp_49__;
        __temp_49__ = (dx * __temp_48__);
        float __temp_50__;
        __temp_50__ = (__temp_47__ - __temp_49__);
        float __temp_51__;
        __temp_51__ = (__temp_40__ + __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].x);
        float __temp_52__;
        __temp_52__ = (__temp_45__ + __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].y);
        float __temp_53__;
        __temp_53__ = (__temp_50__ + __tilevar_0__[__iter_14__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_13__-__iter_1__+FORMA_BLOCKDIM_Y*(__iter_12__-__iter_2__))].z);
        __var_1__[__iter_14__+N*(__iter_13__+M*__iter_12__)].x = __temp_51__;
        __var_1__[__iter_14__+N*(__iter_13__+M*__iter_12__)].y = __temp_52__;
        __var_1__[__iter_14__+N*(__iter_13__+M*__iter_12__)].z = __temp_53__;
        __var_1__[__iter_14__+N*(__iter_13__+M*__iter_12__)].w = 0.000000f;
      }
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(struct float4)*((FORMA_BLOCKDIM_Z*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X));
  return SMemSize;
}

__global__ void __kernel___forma_kernel__1__(struct float4 * __restrict__ input, float dx, float dy, float dz, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, struct float4 * __restrict__ __copy_arr_0__){
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_2__;
  __iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z);
  int __iter_9__;
  __iter_9__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__;
    __iter_10__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ; 
    for( ; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y) ){
      int __iter_11__;
      __iter_11__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-2)) ){
        if (__iter_9__ < FORMA_MAX(__iter_2__,0) || __iter_9__ > FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) || __iter_10__ < FORMA_MAX(__iter_1__,0) || __iter_10__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) || __iter_11__ < FORMA_MAX(__iter_0__,0) || __iter_11__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))) {
          float __temp_18__;
          __temp_18__ = (input[__iter_11__+N*(__iter_10__+M*(__iter_9__+1))].y - input[__iter_11__+N*(__iter_10__+M*__iter_9__)].y);
          float __temp_19__;
          __temp_19__ = (dz * __temp_18__);
          float __temp_20__;
          __temp_20__ = (input[__iter_11__+N*(__iter_10__+1+M*__iter_9__)].z - input[__iter_11__+N*(__iter_10__+M*__iter_9__)].z);
          float __temp_21__;
          __temp_21__ = (dy * __temp_20__);
          float __temp_22__;
          __temp_22__ = (__temp_19__ - __temp_21__);
          float __temp_23__;
          __temp_23__ = (input[__iter_11__+N*(__iter_10__+M*(__iter_9__+1))].x - input[__iter_11__+N*(__iter_10__+M*__iter_9__)].x);
          float __temp_24__;
          __temp_24__ = (dz * __temp_23__);
          float __temp_25__;
          __temp_25__ = (input[__iter_11__+1+N*(__iter_10__+M*__iter_9__)].z - input[__iter_11__+N*(__iter_10__+M*__iter_9__)].z);
          float __temp_26__;
          __temp_26__ = (dx * __temp_25__);
          float __temp_27__;
          __temp_27__ = (__temp_24__ - __temp_26__);
          float __temp_28__;
          __temp_28__ = (input[__iter_11__+N*(__iter_10__+1+M*__iter_9__)].x - input[__iter_11__+N*(__iter_10__+M*__iter_9__)].x);
          float __temp_29__;
          __temp_29__ = (dy * __temp_28__);
          float __temp_30__;
          __temp_30__ = (input[__iter_11__+1+N*(__iter_10__+M*__iter_9__)].y - input[__iter_11__+N*(__iter_10__+M*__iter_9__)].y);
          float __temp_31__;
          __temp_31__ = (dx * __temp_30__);
          float __temp_32__;
          __temp_32__ = (__temp_29__ - __temp_31__);
          float __temp_33__;
          __temp_33__ = (__temp_22__ + input[__iter_11__+N*(__iter_10__+M*__iter_9__)].x);
          float __temp_34__;
          __temp_34__ = (__temp_27__ + input[__iter_11__+N*(__iter_10__+M*__iter_9__)].y);
          float __temp_35__;
          __temp_35__ = (__temp_32__ + input[__iter_11__+N*(__iter_10__+M*__iter_9__)].z);
          __copy_arr_0__[__iter_11__+N*(__iter_10__+M*__iter_9__)].x = __temp_33__;
          __copy_arr_0__[__iter_11__+N*(__iter_10__+M*__iter_9__)].y = __temp_34__;
          __copy_arr_0__[__iter_11__+N*(__iter_10__+M*__iter_9__)].z = __temp_35__;
          __copy_arr_0__[__iter_11__+N*(__iter_10__+M*__iter_9__)].w = 0.000000f;
        }
      }
    }
  }
}

__global__ void __kernel___forma_kernel__2__(struct float4 * __restrict__ __copy_arr_0__, float dx, float dy, float dz, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, struct float4 * __restrict__ __var_1__){
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y);
  int __iter_2__;
  __iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z);
  int __iter_15__;
  __iter_15__ = FORMA_MAX(__iter_2__,1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-1)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__;
    __iter_16__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
    for( ; __iter_16__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) ; __iter_16__ += (int)(blockDim.y) ){
      int __iter_17__;
      __iter_17__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        if (__iter_15__ < FORMA_MAX((__iter_2__+1),1) || __iter_15__ > FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-1)) || __iter_16__ < FORMA_MAX((__iter_1__+1),1) || __iter_16__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-1)) || __iter_17__ < FORMA_MAX((__iter_0__+1),1) || __iter_17__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-1))) {
          float __temp_54__;
          __temp_54__ = (__copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].y - __copy_arr_0__[__iter_17__+N*(__iter_16__+M*(__iter_15__-1))].y);
          float __temp_55__;
          __temp_55__ = (dz * __temp_54__);
          float __temp_56__;
          __temp_56__ = (__copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].z - __copy_arr_0__[__iter_17__+N*(__iter_16__-1+M*__iter_15__)].z);
          float __temp_57__;
          __temp_57__ = (dy * __temp_56__);
          float __temp_58__;
          __temp_58__ = (__temp_55__ - __temp_57__);
          float __temp_59__;
          __temp_59__ = (__copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].x - __copy_arr_0__[__iter_17__+N*(__iter_16__+M*(__iter_15__-1))].x);
          float __temp_60__;
          __temp_60__ = (dz * __temp_59__);
          float __temp_61__;
          __temp_61__ = (__copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].z - __copy_arr_0__[__iter_17__-1+N*(__iter_16__+M*__iter_15__)].z);
          float __temp_62__;
          __temp_62__ = (dx * __temp_61__);
          float __temp_63__;
          __temp_63__ = (__temp_60__ - __temp_62__);
          float __temp_64__;
          __temp_64__ = (__copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].x - __copy_arr_0__[__iter_17__+N*(__iter_16__-1+M*__iter_15__)].x);
          float __temp_65__;
          __temp_65__ = (dy * __temp_64__);
          float __temp_66__;
          __temp_66__ = (__copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].y - __copy_arr_0__[__iter_17__-1+N*(__iter_16__+M*__iter_15__)].y);
          float __temp_67__;
          __temp_67__ = (dx * __temp_66__);
          float __temp_68__;
          __temp_68__ = (__temp_65__ - __temp_67__);
          float __temp_69__;
          __temp_69__ = (__temp_58__ + __copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].x);
          float __temp_70__;
          __temp_70__ = (__temp_63__ + __copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].y);
          float __temp_71__;
          __temp_71__ = (__temp_68__ + __copy_arr_0__[__iter_17__+N*(__iter_16__+M*__iter_15__)].z);
          __var_1__[__iter_17__+N*(__iter_16__+M*__iter_15__)].x = __temp_69__;
          __var_1__[__iter_17__+N*(__iter_16__+M*__iter_15__)].y = __temp_70__;
          __var_1__[__iter_17__+N*(__iter_16__+M*__iter_15__)].z = __temp_71__;
          __var_1__[__iter_17__+N*(__iter_16__+M*__iter_15__)].w = 0.000000f;
        }
      }
    }
  }
}

/*Device code End */
/* Host Code Begin */
extern "C" void curl(struct float4 * h_input, float dx, float dy, float dz, int L, int M, int N, struct float4 * __var_0__){

/* Host allocation Begin */
  struct float4 * input;
  cudaMalloc(&input,sizeof(struct float4)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(struct float4)*(L*M*N), memcpy_kind_h_input);
  }
  struct float4 * __var_1__;
  cudaMalloc(&__var_1__,sizeof(struct float4)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  struct float4 * __copy_arr_0__;
  cudaMalloc(&__copy_arr_0__,sizeof(struct float4)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_0__\n");
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
  int __size_0___kernel___forma_kernel__0__ = ((N-1) - 0 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((M-1) - 0 ) + 1;
  int __size_2___kernel___forma_kernel__0__ = ((L-1) - 0 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int _max_occupancy_gridsize___kernel___forma_kernel__0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__0__,&__max_occupancy_blocksize___kernel___forma_kernel__0__,(const void*)__kernel___forma_kernel__0__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__0___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)3));
  __max_occupancy_blocksize___kernel___forma_kernel__0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__0___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),1);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)2));
  int __block_1___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),1);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___2 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_2___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___2,__size_2___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_2),1);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_2___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  while( __SMemSize___kernel___forma_kernel__0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__0__.z/2 > 1)
      __blockConfig___kernel___forma_kernel__0__.z /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.y/2 > 1)
      __blockConfig___kernel___forma_kernel__0__.y /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.x/2 > FORMA_MIN(32,1))
      __blockConfig___kernel___forma_kernel__0__.x /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  }
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y);
  int __grid_2___kernel___forma_kernel__0__ = FORMA_CEIL(__size_2___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.z);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  dim3 __blockConfig_st__kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, 2);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig_st__kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, dx, dy, dz, L, M, N, __copy_arr_0__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  dim3 __blockConfig___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/2, 1);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__1__>>> (input, dx, dy, dz, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __copy_arr_0__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");

  dim3 __blockConfig___kernel___forma_kernel__2__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/2, 1);
  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__2__>>> (__copy_arr_0__, dx, dy, dz, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(struct float4)*(L*M*N), memcpy_kind___var_0__);
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
}
/*Host Free End*/
