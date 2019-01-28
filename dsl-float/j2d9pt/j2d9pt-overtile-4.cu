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
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, float * __restrict__ __var_1__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (4-(-4));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (4-(-4));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-6))*(FORMA_BLOCKDIM_X-(-6))));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 1;
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 1;
  int __iter_2__;
  __iter_2__ = (FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)+(-1)) + (int)(threadIdx.y) ; 
  if( __iter_2__ <= (FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1),(N-2))+1),(N-2))+1) ){
    int __iter_3__;
    __iter_3__ = (FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)+(-1)) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= (FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1),(M-2))+1),(M-2))+1) ){
      int __temp_0__;
      __temp_0__ = __iter_2__;
      int __temp_1__;
      __temp_1__ = __iter_3__;
      __tilevar_3__[__iter_3__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__iter_2__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))] = input[__temp_1__+(M-0)*(__temp_0__)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1) + (int)(threadIdx.y) ; 
  if( __iter_4__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1),(N-2))+1),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1),(M-2))+1),(M-2)) ){
      int __temp_2__;
      __temp_2__ = __iter_4__+(-1);
      int __temp_3__;
      __temp_3__ = __iter_5__+(-1);
      float __temp_4__;
      __temp_4__ = (7 * __tilevar_3__[__temp_3__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_2__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      int __temp_5__;
      __temp_5__ = __iter_4__+(-1);
      int __temp_6__;
      __temp_6__ = __iter_5__;
      float __temp_7__;
      __temp_7__ = (5 * __tilevar_3__[__temp_6__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_5__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_8__;
      __temp_8__ = (__temp_4__ + __temp_7__);
      int __temp_9__;
      __temp_9__ = __iter_4__+(-1);
      int __temp_10__;
      __temp_10__ = __iter_5__+(1);
      float __temp_11__;
      __temp_11__ = (9 * __tilevar_3__[__temp_10__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_9__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_12__;
      __temp_12__ = (__temp_8__ + __temp_11__);
      int __temp_13__;
      __temp_13__ = __iter_4__;
      int __temp_14__;
      __temp_14__ = __iter_5__+(-1);
      float __temp_15__;
      __temp_15__ = (12 * __tilevar_3__[__temp_14__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_13__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_16__;
      __temp_16__ = (__temp_12__ + __temp_15__);
      int __temp_17__;
      __temp_17__ = __iter_4__;
      int __temp_18__;
      __temp_18__ = __iter_5__;
      float __temp_19__;
      __temp_19__ = (15 * __tilevar_3__[__temp_18__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_17__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_20__;
      __temp_20__ = (__temp_16__ + __temp_19__);
      int __temp_21__;
      __temp_21__ = __iter_4__;
      int __temp_22__;
      __temp_22__ = __iter_5__+(1);
      float __temp_23__;
      __temp_23__ = (12 * __tilevar_3__[__temp_22__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_21__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_24__;
      __temp_24__ = (__temp_20__ + __temp_23__);
      int __temp_25__;
      __temp_25__ = __iter_4__+(1);
      int __temp_26__;
      __temp_26__ = __iter_5__+(-1);
      float __temp_27__;
      __temp_27__ = (9 * __tilevar_3__[__temp_26__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_25__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_28__;
      __temp_28__ = (__temp_24__ + __temp_27__);
      int __temp_29__;
      __temp_29__ = __iter_4__+(1);
      int __temp_30__;
      __temp_30__ = __iter_5__;
      float __temp_31__;
      __temp_31__ = (5 * __tilevar_3__[__temp_30__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_29__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_32__;
      __temp_32__ = (__temp_28__ + __temp_31__);
      int __temp_33__;
      __temp_33__ = __iter_4__+(1);
      int __temp_34__;
      __temp_34__ = __iter_5__+(1);
      float __temp_35__;
      __temp_35__ = (7 * __tilevar_3__[__temp_34__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-8))*(__temp_33__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_36__;
      __temp_36__ = (__temp_32__ + __temp_35__);
      float __temp_37__;
      __temp_37__ = (__temp_36__ / 118);
      __tilevar_2__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))] = __temp_37__;
    }
  }
  __syncthreads();
  int __iter_6__;
  __iter_6__ = FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1) + (int)(threadIdx.y) ; 
  if( __iter_6__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2))+1),(N-2)) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1) + (int)(threadIdx.x) ; 
    if( __iter_7__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2))+1),(M-2)) ){
      int __temp_38__;
      __temp_38__ = __iter_6__+(-1);
      int __temp_39__;
      __temp_39__ = __iter_7__+(-1);
      float __temp_40__;
      __temp_40__ = (7 * __tilevar_2__[__temp_39__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_38__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      int __temp_41__;
      __temp_41__ = __iter_6__+(-1);
      int __temp_42__;
      __temp_42__ = __iter_7__;
      float __temp_43__;
      __temp_43__ = (5 * __tilevar_2__[__temp_42__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_41__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_44__;
      __temp_44__ = (__temp_40__ + __temp_43__);
      int __temp_45__;
      __temp_45__ = __iter_6__+(-1);
      int __temp_46__;
      __temp_46__ = __iter_7__+(1);
      float __temp_47__;
      __temp_47__ = (9 * __tilevar_2__[__temp_46__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_45__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_48__;
      __temp_48__ = (__temp_44__ + __temp_47__);
      int __temp_49__;
      __temp_49__ = __iter_6__;
      int __temp_50__;
      __temp_50__ = __iter_7__+(-1);
      float __temp_51__;
      __temp_51__ = (12 * __tilevar_2__[__temp_50__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_49__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_52__;
      __temp_52__ = (__temp_48__ + __temp_51__);
      int __temp_53__;
      __temp_53__ = __iter_6__;
      int __temp_54__;
      __temp_54__ = __iter_7__;
      float __temp_55__;
      __temp_55__ = (15 * __tilevar_2__[__temp_54__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_53__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_56__;
      __temp_56__ = (__temp_52__ + __temp_55__);
      int __temp_57__;
      __temp_57__ = __iter_6__;
      int __temp_58__;
      __temp_58__ = __iter_7__+(1);
      float __temp_59__;
      __temp_59__ = (12 * __tilevar_2__[__temp_58__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_57__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_60__;
      __temp_60__ = (__temp_56__ + __temp_59__);
      int __temp_61__;
      __temp_61__ = __iter_6__+(1);
      int __temp_62__;
      __temp_62__ = __iter_7__+(-1);
      float __temp_63__;
      __temp_63__ = (9 * __tilevar_2__[__temp_62__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_61__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_64__;
      __temp_64__ = (__temp_60__ + __temp_63__);
      int __temp_65__;
      __temp_65__ = __iter_6__+(1);
      int __temp_66__;
      __temp_66__ = __iter_7__;
      float __temp_67__;
      __temp_67__ = (5 * __tilevar_2__[__temp_66__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_65__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_68__;
      __temp_68__ = (__temp_64__ + __temp_67__);
      int __temp_69__;
      __temp_69__ = __iter_6__+(1);
      int __temp_70__;
      __temp_70__ = __iter_7__+(1);
      float __temp_71__;
      __temp_71__ = (7 * __tilevar_2__[__temp_70__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-6))*(__temp_69__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)+(-1)),1)-1)))]);
      float __temp_72__;
      __temp_72__ = (__temp_68__ + __temp_71__);
      float __temp_73__;
      __temp_73__ = (__temp_72__ / 118);
      __tilevar_1__[__iter_7__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))] = __temp_73__;
    }
  }
  __syncthreads();
  int __iter_8__;
  __iter_8__ = FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1) + (int)(threadIdx.y) ; 
  if( __iter_8__ <= FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2))+1),(N-2)) ){
    int __iter_9__;
    __iter_9__ = FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1) + (int)(threadIdx.x) ; 
    if( __iter_9__ <= FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2))+1),(M-2)) ){
      float __temp_74__;
      __temp_74__ = (7 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_75__;
      __temp_75__ = (5 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_76__;
      __temp_76__ = (__temp_74__ + __temp_75__);
      float __temp_77__;
      __temp_77__ = (9 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_78__;
      __temp_78__ = (__temp_76__ + __temp_77__);
      float __temp_79__;
      __temp_79__ = (12 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_80__;
      __temp_80__ = (__temp_78__ + __temp_79__);
      float __temp_81__;
      __temp_81__ = (15 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_82__;
      __temp_82__ = (__temp_80__ + __temp_81__);
      float __temp_83__;
      __temp_83__ = (12 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_84__;
      __temp_84__ = (__temp_82__ + __temp_83__);
      float __temp_85__;
      __temp_85__ = (9 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_86__;
      __temp_86__ = (__temp_84__ + __temp_85__);
      float __temp_87__;
      __temp_87__ = (5 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_88__;
      __temp_88__ = (__temp_86__ + __temp_87__);
      float __temp_89__;
      __temp_89__ = (7 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,1)+(-1)),1)-1))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,1)+(-1)),1)-1)))]);
      float __temp_90__;
      __temp_90__ = (__temp_88__ + __temp_89__);
      float __temp_91__;
      __temp_91__ = (__temp_90__ / 118);
      __tilevar_0__[__iter_9__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_8__+(0-(FORMA_MAX(__iter_1__,1)-1)))] = __temp_91__;
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX(__iter_1__,1) + (int)(threadIdx.y) ; 
  if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX(__iter_0__,1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-2)) ){
      float __temp_92__;
      __temp_92__ = (7 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_93__;
      __temp_93__ = (5 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_94__;
      __temp_94__ = (__temp_92__ + __temp_93__);
      float __temp_95__;
      __temp_95__ = (9 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_96__;
      __temp_96__ = (__temp_94__ + __temp_95__);
      float __temp_97__;
      __temp_97__ = (12 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_98__;
      __temp_98__ = (__temp_96__ + __temp_97__);
      float __temp_99__;
      __temp_99__ = (15 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_100__;
      __temp_100__ = (__temp_98__ + __temp_99__);
      float __temp_101__;
      __temp_101__ = (12 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_102__;
      __temp_102__ = (__temp_100__ + __temp_101__);
      float __temp_103__;
      __temp_103__ = (9 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_104__;
      __temp_104__ = (__temp_102__ + __temp_103__);
      float __temp_105__;
      __temp_105__ = (5 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_106__;
      __temp_106__ = (__temp_104__ + __temp_105__);
      float __temp_107__;
      __temp_107__ = (7 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,1)-1))+(FORMA_BLOCKDIM_X-(-2))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,1)-1)))]);
      float __temp_108__;
      __temp_108__ = (__temp_106__ + __temp_107__);
      float __temp_109__;
      __temp_109__ = (__temp_108__ / 118);
      __var_1__[__iter_11__+(M-0)*(__iter_10__)] = __temp_109__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (4-(-4));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (4-(-4));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-6))*(FORMA_BLOCKDIM_X-(-6))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-2))*(FORMA_BLOCKDIM_X-(-2))));
  return SMemSize;
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
  int __block_0___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),9);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_1___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),9);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  while( __SMemSize___kernel___forma_kernel__0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__0__.y/2 > 9)
      __blockConfig___kernel___forma_kernel__0__.y /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.x/2 > FORMA_MIN(32,9))
      __blockConfig___kernel___forma_kernel__0__.x /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  }
  __block_0___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.x-(4-(-4));
  __block_1___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.y-(4-(-4));
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
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
}
/*Host Free End*/
