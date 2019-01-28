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
__global__ void __kernel_j3d27pt0__(float * __restrict__ input, int L, int M, int N, float * __var_2__){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z)- (1-(-1));
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-4))*(FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-2))*(FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 1;
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 1;
  int __iter_2__;
  __iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + 1;
  {
    int __iter_3__;
    __iter_3__ = (FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)) + (int)(threadIdx.z*1); 
    for (;__iter_3__+0 <= (FORMA_MIN((FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-2))+1),(L-2))+1); __iter_3__ += (int)(blockDim.z*1)) {
      int __iter_4__;
      __iter_4__ = (FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y*1); 
      if (__iter_4__ <= (FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-2))+1),(M-2))+1)) {
        int __iter_5__;
        __iter_5__ = (FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x); 
        if (__iter_5__ <= (FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-2))+1),(N-2))+1)) {
          int __temp_0__;
          __temp_0__ = (__iter_3__+0);
          int __temp_1__;
          __temp_1__ = (__iter_4__+0);
          int __temp_2__;
          __temp_2__ = (__iter_5__+0);
          __tilevar_1__[(__iter_5__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_4__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_3__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))] = input[__temp_2__+(N-0)*(__temp_1__+(M-0)*(__temp_0__))];
        }
      }
    }
  }
  __syncthreads();
  {
    int __iter_6__;
    __iter_6__ = FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1) + (int)(threadIdx.z*1); 
    if (__iter_6__ <= FORMA_MIN((FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-2))+1),(L-2))) {
      int __iter_7__;
      __iter_7__ = FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1) + (int)(threadIdx.y*1); 
      if (__iter_7__ <= FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-2))+1),(M-2))) {
        int __iter_8__;
        __iter_8__ = FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1) + (int)(threadIdx.x); 
        if (__iter_8__ <= FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-2))+1),(N-2))) {
          float __temp_3__;
          __temp_3__ = (0.500000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_4__;
          __temp_4__ = (0.700000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_5__;
          __temp_5__ = (__temp_3__ + __temp_4__);
          float __temp_6__;
          __temp_6__ = (0.900000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_7__;
          __temp_7__ = (__temp_5__ + __temp_6__);
          float __temp_8__;
          __temp_8__ = (1.200000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_9__;
          __temp_9__ = (__temp_7__ + __temp_8__);
          float __temp_10__;
          __temp_10__ = (1.500000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_11__;
          __temp_11__ = (__temp_9__ + __temp_10__);
          float __temp_12__;
          __temp_12__ = (1.200000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_13__;
          __temp_13__ = (__temp_11__ + __temp_12__);
          float __temp_14__;
          __temp_14__ = (0.900000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_15__;
          __temp_15__ = (__temp_13__ + __temp_14__);
          float __temp_16__;
          __temp_16__ = (0.700000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_17__;
          __temp_17__ = (__temp_15__ + __temp_16__);
          float __temp_18__;
          __temp_18__ = (0.500000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_19__;
          __temp_19__ = (__temp_17__ + __temp_18__);
          float __temp_20__;
          __temp_20__ = (0.500000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_21__;
          __temp_21__ = (__temp_19__ + __temp_20__);
          float __temp_22__;
          __temp_22__ = (0.700000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_23__;
          __temp_23__ = (__temp_21__ + __temp_22__);
          float __temp_24__;
          __temp_24__ = (0.900000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_25__;
          __temp_25__ = (__temp_23__ + __temp_24__);
          float __temp_26__;
          __temp_26__ = (1.200000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_27__;
          __temp_27__ = (__temp_25__ + __temp_26__);
          float __temp_28__;
          __temp_28__ = (1.500000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_29__;
          __temp_29__ = (__temp_27__ + __temp_28__);
          float __temp_30__;
          __temp_30__ = (1.200000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_31__;
          __temp_31__ = (__temp_29__ + __temp_30__);
          float __temp_32__;
          __temp_32__ = (0.900000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_33__;
          __temp_33__ = (__temp_31__ + __temp_32__);
          float __temp_34__;
          __temp_34__ = (0.700000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_35__;
          __temp_35__ = (__temp_33__ + __temp_34__);
          float __temp_36__;
          __temp_36__ = (0.500000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_37__;
          __temp_37__ = (__temp_35__ + __temp_36__);
          float __temp_38__;
          __temp_38__ = (0.500000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_39__;
          __temp_39__ = (__temp_37__ + __temp_38__);
          float __temp_40__;
          __temp_40__ = (0.700000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_41__;
          __temp_41__ = (__temp_39__ + __temp_40__);
          float __temp_42__;
          __temp_42__ = (0.900000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_43__;
          __temp_43__ = (__temp_41__ + __temp_42__);
          float __temp_44__;
          __temp_44__ = (1.200000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_45__;
          __temp_45__ = (__temp_43__ + __temp_44__);
          float __temp_46__;
          __temp_46__ = (1.500000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_47__;
          __temp_47__ = (__temp_45__ + __temp_46__);
          float __temp_48__;
          __temp_48__ = (1.200000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_49__;
          __temp_49__ = (__temp_47__ + __temp_48__);
          float __temp_50__;
          __temp_50__ = (0.900000 * __tilevar_1__[(__iter_8__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_51__;
          __temp_51__ = (__temp_49__ + __temp_50__);
          float __temp_52__;
          __temp_52__ = (0.700000 * __tilevar_1__[(__iter_8__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_53__;
          __temp_53__ = (__temp_51__ + __temp_52__);
          float __temp_54__;
          __temp_54__ = (0.500000 * __tilevar_1__[(__iter_8__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_7__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_6__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_2__,1)+(-1)),1)+(-1)))))]);
          float __temp_55__;
          __temp_55__ = (__temp_53__ + __temp_54__);
          float __temp_56__;
          __temp_56__ = (__temp_55__ / 159);
          __tilevar_0__[(__iter_8__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_7__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_6__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))] = __temp_56__;
        }
      }
    }
  }
  __syncthreads();
  {
    int __iter_9__;
    __iter_9__ = FORMA_MAX(__iter_2__,1) + (int)(threadIdx.z*1); 
    if (__iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-2))) {
      int __iter_10__;
      __iter_10__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y*1); 
      if (__iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-2))) {
        int __iter_11__;
        __iter_11__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x); 
        if (__iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-2))) {
          float __temp_57__;
          __temp_57__ = (0.500000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_58__;
          __temp_58__ = (0.700000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_59__;
          __temp_59__ = (__temp_57__ + __temp_58__);
          float __temp_60__;
          __temp_60__ = (0.900000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_61__;
          __temp_61__ = (__temp_59__ + __temp_60__);
          float __temp_62__;
          __temp_62__ = (1.200000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_63__;
          __temp_63__ = (__temp_61__ + __temp_62__);
          float __temp_64__;
          __temp_64__ = (1.500000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_65__;
          __temp_65__ = (__temp_63__ + __temp_64__);
          float __temp_66__;
          __temp_66__ = (1.200000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_67__;
          __temp_67__ = (__temp_65__ + __temp_66__);
          float __temp_68__;
          __temp_68__ = (0.900000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_69__;
          __temp_69__ = (__temp_67__ + __temp_68__);
          float __temp_70__;
          __temp_70__ = (0.700000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_71__;
          __temp_71__ = (__temp_69__ + __temp_70__);
          float __temp_72__;
          __temp_72__ = (0.500000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(-1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_73__;
          __temp_73__ = (__temp_71__ + __temp_72__);
          float __temp_74__;
          __temp_74__ = (0.500000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_75__;
          __temp_75__ = (__temp_73__ + __temp_74__);
          float __temp_76__;
          __temp_76__ = (0.700000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_77__;
          __temp_77__ = (__temp_75__ + __temp_76__);
          float __temp_78__;
          __temp_78__ = (0.900000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_79__;
          __temp_79__ = (__temp_77__ + __temp_78__);
          float __temp_80__;
          __temp_80__ = (1.200000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_81__;
          __temp_81__ = (__temp_79__ + __temp_80__);
          float __temp_82__;
          __temp_82__ = (1.500000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_83__;
          __temp_83__ = (__temp_81__ + __temp_82__);
          float __temp_84__;
          __temp_84__ = (1.200000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_85__;
          __temp_85__ = (__temp_83__ + __temp_84__);
          float __temp_86__;
          __temp_86__ = (0.900000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_87__;
          __temp_87__ = (__temp_85__ + __temp_86__);
          float __temp_88__;
          __temp_88__ = (0.700000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_89__;
          __temp_89__ = (__temp_87__ + __temp_88__);
          float __temp_90__;
          __temp_90__ = (0.500000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_91__;
          __temp_91__ = (__temp_89__ + __temp_90__);
          float __temp_92__;
          __temp_92__ = (0.500000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_93__;
          __temp_93__ = (__temp_91__ + __temp_92__);
          float __temp_94__;
          __temp_94__ = (0.700000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_95__;
          __temp_95__ = (__temp_93__ + __temp_94__);
          float __temp_96__;
          __temp_96__ = (0.900000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(-1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_97__;
          __temp_97__ = (__temp_95__ + __temp_96__);
          float __temp_98__;
          __temp_98__ = (1.200000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_99__;
          __temp_99__ = (__temp_97__ + __temp_98__);
          float __temp_100__;
          __temp_100__ = (1.500000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_101__;
          __temp_101__ = (__temp_99__ + __temp_100__);
          float __temp_102__;
          __temp_102__ = (1.200000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_103__;
          __temp_103__ = (__temp_101__ + __temp_102__);
          float __temp_104__;
          __temp_104__ = (0.900000 * __tilevar_0__[(__iter_11__+0)+(-1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_105__;
          __temp_105__ = (__temp_103__ + __temp_104__);
          float __temp_106__;
          __temp_106__ = (0.700000 * __tilevar_0__[(__iter_11__+0)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_107__;
          __temp_107__ = (__temp_105__ + __temp_106__);
          float __temp_108__;
          __temp_108__ = (0.500000 * __tilevar_0__[(__iter_11__+0)+(1)+(0-(FORMA_MAX(__iter_0__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_10__+0)+(1)+(0-(FORMA_MAX(__iter_1__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_9__+0)+(1)+(0-(FORMA_MAX(__iter_2__,1)+(-1)))))]);
          float __temp_109__;
          __temp_109__ = (__temp_107__ + __temp_108__);
          float __temp_110__;
          __temp_110__ = (__temp_109__ / 159);
          __var_2__[(__iter_11__+0)+(N-0)*((__iter_10__+0)+(M-0)*((__iter_9__+0)))] = __temp_110__;
        }
      }
    }
  }
}
int __blockSizeToSMemSize___kernel_j3d27pt0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z)- (1-(-1));
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-4))*(FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-2))*(FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}
__global__ void __kernel_j3d27pt1__(float * __restrict__ __var_2__, int L, int M, int N, float * __var_1__){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z)- (1-(-1));
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
  {
    int __iter_15__;
    __iter_15__ = (FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)) + (int)(threadIdx.z*1); 
    for (;__iter_15__+0 <= (FORMA_MIN((FORMA_MIN(((__iter_14__+FORMA_BLOCKDIM_Z)-1),(L-2))+1),(L-2))+1); __iter_15__ += (int)(blockDim.z*1)) {
      int __iter_16__;
      __iter_16__ = (FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)) + (int)(threadIdx.y*1); 
      if (__iter_16__ <= (FORMA_MIN((FORMA_MIN(((__iter_13__+FORMA_BLOCKDIM_Y)-1),(M-2))+1),(M-2))+1)) {
        int __iter_17__;
        __iter_17__ = (FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)) + (int)(threadIdx.x); 
        if (__iter_17__ <= (FORMA_MIN((FORMA_MIN(((__iter_12__+FORMA_BLOCKDIM_X)-1),(N-2))+1),(N-2))+1)) {
          int __temp_111__;
          __temp_111__ = (__iter_15__+0);
          int __temp_112__;
          __temp_112__ = (__iter_16__+0);
          int __temp_113__;
          __temp_113__ = (__iter_17__+0);
          __tilevar_3__[(__iter_17__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_16__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_15__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))] = __var_2__[__temp_113__+(N-0)*(__temp_112__+(M-0)*(__temp_111__))];
        }
      }
    }
  }
  __syncthreads();
  {
    int __iter_18__;
    __iter_18__ = FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1) + (int)(threadIdx.z*1); 
    if (__iter_18__ <= FORMA_MIN((FORMA_MIN(((__iter_14__+FORMA_BLOCKDIM_Z)-1),(L-2))+1),(L-2))) {
      int __iter_19__;
      __iter_19__ = FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1) + (int)(threadIdx.y*1); 
      if (__iter_19__ <= FORMA_MIN((FORMA_MIN(((__iter_13__+FORMA_BLOCKDIM_Y)-1),(M-2))+1),(M-2))) {
        int __iter_20__;
        __iter_20__ = FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1) + (int)(threadIdx.x); 
        if (__iter_20__ <= FORMA_MIN((FORMA_MIN(((__iter_12__+FORMA_BLOCKDIM_X)-1),(N-2))+1),(N-2))) {
          float __temp_114__;
          __temp_114__ = (0.500000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_115__;
          __temp_115__ = (0.700000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_116__;
          __temp_116__ = (__temp_114__ + __temp_115__);
          float __temp_117__;
          __temp_117__ = (0.900000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_118__;
          __temp_118__ = (__temp_116__ + __temp_117__);
          float __temp_119__;
          __temp_119__ = (1.200000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_120__;
          __temp_120__ = (__temp_118__ + __temp_119__);
          float __temp_121__;
          __temp_121__ = (1.500000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_122__;
          __temp_122__ = (__temp_120__ + __temp_121__);
          float __temp_123__;
          __temp_123__ = (1.200000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_124__;
          __temp_124__ = (__temp_122__ + __temp_123__);
          float __temp_125__;
          __temp_125__ = (0.900000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_126__;
          __temp_126__ = (__temp_124__ + __temp_125__);
          float __temp_127__;
          __temp_127__ = (0.700000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_128__;
          __temp_128__ = (__temp_126__ + __temp_127__);
          float __temp_129__;
          __temp_129__ = (0.500000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_130__;
          __temp_130__ = (__temp_128__ + __temp_129__);
          float __temp_131__;
          __temp_131__ = (0.500000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_132__;
          __temp_132__ = (__temp_130__ + __temp_131__);
          float __temp_133__;
          __temp_133__ = (0.700000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_134__;
          __temp_134__ = (__temp_132__ + __temp_133__);
          float __temp_135__;
          __temp_135__ = (0.900000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_136__;
          __temp_136__ = (__temp_134__ + __temp_135__);
          float __temp_137__;
          __temp_137__ = (1.200000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_138__;
          __temp_138__ = (__temp_136__ + __temp_137__);
          float __temp_139__;
          __temp_139__ = (1.500000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_140__;
          __temp_140__ = (__temp_138__ + __temp_139__);
          float __temp_141__;
          __temp_141__ = (1.200000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_142__;
          __temp_142__ = (__temp_140__ + __temp_141__);
          float __temp_143__;
          __temp_143__ = (0.900000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_144__;
          __temp_144__ = (__temp_142__ + __temp_143__);
          float __temp_145__;
          __temp_145__ = (0.700000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_146__;
          __temp_146__ = (__temp_144__ + __temp_145__);
          float __temp_147__;
          __temp_147__ = (0.500000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_148__;
          __temp_148__ = (__temp_146__ + __temp_147__);
          float __temp_149__;
          __temp_149__ = (0.500000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_150__;
          __temp_150__ = (__temp_148__ + __temp_149__);
          float __temp_151__;
          __temp_151__ = (0.700000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_152__;
          __temp_152__ = (__temp_150__ + __temp_151__);
          float __temp_153__;
          __temp_153__ = (0.900000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_154__;
          __temp_154__ = (__temp_152__ + __temp_153__);
          float __temp_155__;
          __temp_155__ = (1.200000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_156__;
          __temp_156__ = (__temp_154__ + __temp_155__);
          float __temp_157__;
          __temp_157__ = (1.500000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_158__;
          __temp_158__ = (__temp_156__ + __temp_157__);
          float __temp_159__;
          __temp_159__ = (1.200000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_160__;
          __temp_160__ = (__temp_158__ + __temp_159__);
          float __temp_161__;
          __temp_161__ = (0.900000 * __tilevar_3__[(__iter_20__+0)+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_162__;
          __temp_162__ = (__temp_160__ + __temp_161__);
          float __temp_163__;
          __temp_163__ = (0.700000 * __tilevar_3__[(__iter_20__+0)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_164__;
          __temp_164__ = (__temp_162__ + __temp_163__);
          float __temp_165__;
          __temp_165__ = (0.500000 * __tilevar_3__[(__iter_20__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_12__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_X-(-4))*((__iter_19__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_13__,1)+(-1)),1)+(-1)))+(FORMA_BLOCKDIM_Y-(-4))*((__iter_18__+0)+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_14__,1)+(-1)),1)+(-1)))))]);
          float __temp_166__;
          __temp_166__ = (__temp_164__ + __temp_165__);
          float __temp_167__;
          __temp_167__ = (__temp_166__ / 159);
          __tilevar_2__[(__iter_20__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_19__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_18__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))] = __temp_167__;
        }
      }
    }
  }
  __syncthreads();
  {
    int __iter_21__;
    __iter_21__ = FORMA_MAX(__iter_14__,1) + (int)(threadIdx.z*1); 
    if (__iter_21__ <= FORMA_MIN(((__iter_14__+FORMA_BLOCKDIM_Z)-1),(L-2))) {
      int __iter_22__;
      __iter_22__ = FORMA_MAX(__iter_13__,1) + (int)(threadIdx.y*1); 
      if (__iter_22__ <= FORMA_MIN(((__iter_13__+FORMA_BLOCKDIM_Y)-1),(M-2))) {
        int __iter_23__;
        __iter_23__ = FORMA_MAX(__iter_12__,1) + (int)(threadIdx.x); 
        if (__iter_23__ <= FORMA_MIN(((__iter_12__+FORMA_BLOCKDIM_X)-1),(N-2))) {
          float __temp_168__;
          __temp_168__ = (0.500000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_169__;
          __temp_169__ = (0.700000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_170__;
          __temp_170__ = (__temp_168__ + __temp_169__);
          float __temp_171__;
          __temp_171__ = (0.900000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_172__;
          __temp_172__ = (__temp_170__ + __temp_171__);
          float __temp_173__;
          __temp_173__ = (1.200000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_174__;
          __temp_174__ = (__temp_172__ + __temp_173__);
          float __temp_175__;
          __temp_175__ = (1.500000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_176__;
          __temp_176__ = (__temp_174__ + __temp_175__);
          float __temp_177__;
          __temp_177__ = (1.200000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_178__;
          __temp_178__ = (__temp_176__ + __temp_177__);
          float __temp_179__;
          __temp_179__ = (0.900000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_180__;
          __temp_180__ = (__temp_178__ + __temp_179__);
          float __temp_181__;
          __temp_181__ = (0.700000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_182__;
          __temp_182__ = (__temp_180__ + __temp_181__);
          float __temp_183__;
          __temp_183__ = (0.500000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(-1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_184__;
          __temp_184__ = (__temp_182__ + __temp_183__);
          float __temp_185__;
          __temp_185__ = (0.500000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_186__;
          __temp_186__ = (__temp_184__ + __temp_185__);
          float __temp_187__;
          __temp_187__ = (0.700000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_188__;
          __temp_188__ = (__temp_186__ + __temp_187__);
          float __temp_189__;
          __temp_189__ = (0.900000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_190__;
          __temp_190__ = (__temp_188__ + __temp_189__);
          float __temp_191__;
          __temp_191__ = (1.200000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_192__;
          __temp_192__ = (__temp_190__ + __temp_191__);
          float __temp_193__;
          __temp_193__ = (1.500000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_194__;
          __temp_194__ = (__temp_192__ + __temp_193__);
          float __temp_195__;
          __temp_195__ = (1.200000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_196__;
          __temp_196__ = (__temp_194__ + __temp_195__);
          float __temp_197__;
          __temp_197__ = (0.900000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_198__;
          __temp_198__ = (__temp_196__ + __temp_197__);
          float __temp_199__;
          __temp_199__ = (0.700000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_200__;
          __temp_200__ = (__temp_198__ + __temp_199__);
          float __temp_201__;
          __temp_201__ = (0.500000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_202__;
          __temp_202__ = (__temp_200__ + __temp_201__);
          float __temp_203__;
          __temp_203__ = (0.500000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_204__;
          __temp_204__ = (__temp_202__ + __temp_203__);
          float __temp_205__;
          __temp_205__ = (0.700000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_206__;
          __temp_206__ = (__temp_204__ + __temp_205__);
          float __temp_207__;
          __temp_207__ = (0.900000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(-1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_208__;
          __temp_208__ = (__temp_206__ + __temp_207__);
          float __temp_209__;
          __temp_209__ = (1.200000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_210__;
          __temp_210__ = (__temp_208__ + __temp_209__);
          float __temp_211__;
          __temp_211__ = (1.500000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_212__;
          __temp_212__ = (__temp_210__ + __temp_211__);
          float __temp_213__;
          __temp_213__ = (1.200000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_214__;
          __temp_214__ = (__temp_212__ + __temp_213__);
          float __temp_215__;
          __temp_215__ = (0.900000 * __tilevar_2__[(__iter_23__+0)+(-1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_216__;
          __temp_216__ = (__temp_214__ + __temp_215__);
          float __temp_217__;
          __temp_217__ = (0.700000 * __tilevar_2__[(__iter_23__+0)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_218__;
          __temp_218__ = (__temp_216__ + __temp_217__);
          float __temp_219__;
          __temp_219__ = (0.500000 * __tilevar_2__[(__iter_23__+0)+(1)+(0-(FORMA_MAX(__iter_12__,1)+(-1)))+(FORMA_BLOCKDIM_X-(-2))*((__iter_22__+0)+(1)+(0-(FORMA_MAX(__iter_13__,1)+(-1)))+(FORMA_BLOCKDIM_Y-(-2))*((__iter_21__+0)+(1)+(0-(FORMA_MAX(__iter_14__,1)+(-1)))))]);
          float __temp_220__;
          __temp_220__ = (__temp_218__ + __temp_219__);
          float __temp_221__;
          __temp_221__ = (__temp_220__ / 159);
          __var_1__[(__iter_23__+0)+(N-0)*((__iter_22__+0)+(M-0)*((__iter_21__+0)))] = __temp_221__;
        }
      }
    }
  }
}
int __blockSizeToSMemSize___kernel_j3d27pt1__(dim3 blockDim){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z)- (1-(-1));
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (2-(-2));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (2-(-2));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-4))*(FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-(-2))*(FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
}
/*Device code End */
/* Host Code Begin */
extern "C" void j3d27pt(float * h_input, int L, int M, int N, float * __var_0__){

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
  int __size_0___kernel_j3d27pt0__ = ((N-2) - 1 ) + 1;
  int __size_1___kernel_j3d27pt0__ = ((M-2) - 1 ) + 1;
  int __size_2___kernel_j3d27pt0__ = ((L-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel_j3d27pt0__;
  int _max_occupancy_gridsize___kernel_j3d27pt0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel_j3d27pt0__,&__max_occupancy_blocksize___kernel_j3d27pt0__,(const void*)__kernel_j3d27pt0__,0,0);
  int __max_occupancy_blocksize___kernel_j3d27pt0___0 = pow((float)__max_occupancy_blocksize___kernel_j3d27pt0__, (float)(1.0/(float)3));
  __max_occupancy_blocksize___kernel_j3d27pt0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel_j3d27pt0___0/32, 1)*32;
  int __block_0___kernel_j3d27pt0__ = 16;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_j3d27pt0___0,FORMA_MAX((__size_0___kernel_j3d27pt0__/1)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel_j3d27pt0__ /= __block_0___kernel_j3d27pt0__;
  int __max_occupancy_blocksize___kernel_j3d27pt0___1 = pow((float)__max_occupancy_blocksize___kernel_j3d27pt0__, (float)(1.0/(float)2));
  int __block_1___kernel_j3d27pt0__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_j3d27pt0___1,__size_1___kernel_j3d27pt0__/1),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel_j3d27pt0__ /= __block_1___kernel_j3d27pt0__;
  int __max_occupancy_blocksize___kernel_j3d27pt0___2 = __max_occupancy_blocksize___kernel_j3d27pt0__;
  int __block_2___kernel_j3d27pt0__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_j3d27pt0___2,__size_2___kernel_j3d27pt0__/1),FORMA_MAX_BLOCKDIM_2),3);
  __max_occupancy_blocksize___kernel_j3d27pt0__ /= __block_2___kernel_j3d27pt0__;
  dim3 __blockConfig___kernel_j3d27pt0__(__block_0___kernel_j3d27pt0__,__block_1___kernel_j3d27pt0__,__block_2___kernel_j3d27pt0__);
  int __SMemSize___kernel_j3d27pt0__ = 0;
  __SMemSize___kernel_j3d27pt0__ = __blockSizeToSMemSize___kernel_j3d27pt0__(__blockConfig___kernel_j3d27pt0__);
  while( __SMemSize___kernel_j3d27pt0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel_j3d27pt0__.z/2 > 3)
      __blockConfig___kernel_j3d27pt0__.z /= 2;
    __SMemSize___kernel_j3d27pt0__ = __blockSizeToSMemSize___kernel_j3d27pt0__(__blockConfig___kernel_j3d27pt0__);
    if( __SMemSize___kernel_j3d27pt0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel_j3d27pt0__.y/2 > 5)
      __blockConfig___kernel_j3d27pt0__.y /= 2;
    __SMemSize___kernel_j3d27pt0__ = __blockSizeToSMemSize___kernel_j3d27pt0__(__blockConfig___kernel_j3d27pt0__);
    if( __SMemSize___kernel_j3d27pt0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel_j3d27pt0__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel_j3d27pt0__.x /= 2;
    __SMemSize___kernel_j3d27pt0__ = __blockSizeToSMemSize___kernel_j3d27pt0__(__blockConfig___kernel_j3d27pt0__);
  }
  __block_0___kernel_j3d27pt0__ = __blockConfig___kernel_j3d27pt0__.x-(2-(-2));
  __block_1___kernel_j3d27pt0__ = __blockConfig___kernel_j3d27pt0__.y-(2-(-2));
  __block_2___kernel_j3d27pt0__ = __blockConfig___kernel_j3d27pt0__.z-(1-(-1));
  int __grid_0___kernel_j3d27pt0__ = FORMA_CEIL(__size_0___kernel_j3d27pt0__,__block_0___kernel_j3d27pt0__*1);
  int __grid_1___kernel_j3d27pt0__ = FORMA_CEIL(__size_1___kernel_j3d27pt0__,__block_1___kernel_j3d27pt0__*1);
  int __grid_2___kernel_j3d27pt0__ = FORMA_CEIL(__size_2___kernel_j3d27pt0__,__block_2___kernel_j3d27pt0__*1);
  dim3 __gridConfig___kernel_j3d27pt0__(__grid_0___kernel_j3d27pt0__,__grid_1___kernel_j3d27pt0__,__grid_2___kernel_j3d27pt0__);
  __kernel_j3d27pt0__<<<__gridConfig___kernel_j3d27pt0__,__blockConfig___kernel_j3d27pt0__,__SMemSize___kernel_j3d27pt0__>>>(input,   L,  M,  N,__var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel_j3d27pt0__\n");
  int __size_0___kernel_j3d27pt1__ = ((N-2) - 1 ) + 1;
  int __size_1___kernel_j3d27pt1__ = ((M-2) - 1 ) + 1;
  int __size_2___kernel_j3d27pt1__ = ((L-2) - 1 ) + 1;
  int __max_occupancy_blocksize___kernel_j3d27pt1__;
  int _max_occupancy_gridsize___kernel_j3d27pt1__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel_j3d27pt1__,&__max_occupancy_blocksize___kernel_j3d27pt1__,(const void*)__kernel_j3d27pt1__,0,0);
  int __max_occupancy_blocksize___kernel_j3d27pt1___0 = pow((double)__max_occupancy_blocksize___kernel_j3d27pt1__, (double)(1.0/(double)3));
  __max_occupancy_blocksize___kernel_j3d27pt1___0 = FORMA_MAX(__max_occupancy_blocksize___kernel_j3d27pt1___0/32, 1)*32;
  int __block_0___kernel_j3d27pt1__ = 16;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_j3d27pt1___0,FORMA_MAX((__size_0___kernel_j3d27pt1__/1)/32,1)*32),FORMA_MAX_BLOCKDIM_0),5);
  __max_occupancy_blocksize___kernel_j3d27pt1__ /= __block_0___kernel_j3d27pt1__;
  int __max_occupancy_blocksize___kernel_j3d27pt1___1 = pow((double)__max_occupancy_blocksize___kernel_j3d27pt1__, (double)(1.0/(double)2));
  int __block_1___kernel_j3d27pt1__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_j3d27pt1___1,__size_1___kernel_j3d27pt1__/1),FORMA_MAX_BLOCKDIM_1),5);
  __max_occupancy_blocksize___kernel_j3d27pt1__ /= __block_1___kernel_j3d27pt1__;
  int __max_occupancy_blocksize___kernel_j3d27pt1___2 = __max_occupancy_blocksize___kernel_j3d27pt1__;
  int __block_2___kernel_j3d27pt1__ = 8;//FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel_j3d27pt1___2,__size_2___kernel_j3d27pt1__/1),FORMA_MAX_BLOCKDIM_2),3);
  __max_occupancy_blocksize___kernel_j3d27pt1__ /= __block_2___kernel_j3d27pt1__;
  dim3 __blockConfig___kernel_j3d27pt1__(__block_0___kernel_j3d27pt1__,__block_1___kernel_j3d27pt1__,__block_2___kernel_j3d27pt1__);
  int __SMemSize___kernel_j3d27pt1__ = 0;
  __SMemSize___kernel_j3d27pt1__ = __blockSizeToSMemSize___kernel_j3d27pt1__(__blockConfig___kernel_j3d27pt1__);
  while( __SMemSize___kernel_j3d27pt1__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel_j3d27pt1__.z/2 > 3)
      __blockConfig___kernel_j3d27pt1__.z /= 2;
    __SMemSize___kernel_j3d27pt1__ = __blockSizeToSMemSize___kernel_j3d27pt1__(__blockConfig___kernel_j3d27pt1__);
    if( __SMemSize___kernel_j3d27pt1__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel_j3d27pt1__.y/2 > 5)
      __blockConfig___kernel_j3d27pt1__.y /= 2;
    __SMemSize___kernel_j3d27pt1__ = __blockSizeToSMemSize___kernel_j3d27pt1__(__blockConfig___kernel_j3d27pt1__);
    if( __SMemSize___kernel_j3d27pt1__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel_j3d27pt1__.x/2 > FORMA_MIN(32,5))
      __blockConfig___kernel_j3d27pt1__.x /= 2;
    __SMemSize___kernel_j3d27pt1__ = __blockSizeToSMemSize___kernel_j3d27pt1__(__blockConfig___kernel_j3d27pt1__);
  }
  __block_0___kernel_j3d27pt1__ = __blockConfig___kernel_j3d27pt1__.x-(2-(-2));
  __block_1___kernel_j3d27pt1__ = __blockConfig___kernel_j3d27pt1__.y-(2-(-2));
  __block_2___kernel_j3d27pt1__ = __blockConfig___kernel_j3d27pt1__.z-(1-(-1));
  int __grid_0___kernel_j3d27pt1__ = FORMA_CEIL(__size_0___kernel_j3d27pt1__,__block_0___kernel_j3d27pt1__*1);
  int __grid_1___kernel_j3d27pt1__ = FORMA_CEIL(__size_1___kernel_j3d27pt1__,__block_1___kernel_j3d27pt1__*1);
  int __grid_2___kernel_j3d27pt1__ = FORMA_CEIL(__size_2___kernel_j3d27pt1__,__block_2___kernel_j3d27pt1__*1);
  dim3 __gridConfig___kernel_j3d27pt1__(__grid_0___kernel_j3d27pt1__,__grid_1___kernel_j3d27pt1__,__grid_2___kernel_j3d27pt1__);
  __kernel_j3d27pt1__<<<__gridConfig___kernel_j3d27pt1__,__blockConfig___kernel_j3d27pt1__,__SMemSize___kernel_j3d27pt1__>>>(__var_2__,   L,  M,  N,__var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel_j3d27pt1__\n");
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
