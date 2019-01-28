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
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (8-(-8));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (8-(-8));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-16))*(FORMA_BLOCKDIM_X-(-16))));
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-12))*(FORMA_BLOCKDIM_X-(-12))));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 2;
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 2;
  int __iter_2__;
  __iter_2__ = (FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)+(-2)) + (int)(threadIdx.y) ; 
  if( __iter_2__ <= (FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3))+2),(N-3))+2),(N-3))+2) ){
    int __iter_3__;
    __iter_3__ = (FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)+(-2)) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= (FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3))+2),(M-3))+2),(M-3))+2) ){
      int __temp_0__;
      __temp_0__ = __iter_2__;
      int __temp_1__;
      __temp_1__ = __iter_3__;
      __tilevar_3__[__iter_3__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__iter_2__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))] = input[__temp_1__+(M-0)*(__temp_0__)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2) + (int)(threadIdx.y) ; 
  if( __iter_4__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3))+2),(N-3))+2),(N-3)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3))+2),(M-3))+2),(M-3)) ){
      int __temp_2__;
      __temp_2__ = __iter_4__+(-2);
      int __temp_3__;
      __temp_3__ = __iter_5__+(-2);
      float __temp_4__;
      __temp_4__ = (2 * __tilevar_3__[__temp_3__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_2__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      int __temp_5__;
      __temp_5__ = __iter_4__+(-2);
      int __temp_6__;
      __temp_6__ = __iter_5__+(-1);
      float __temp_7__;
      __temp_7__ = (4 * __tilevar_3__[__temp_6__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_5__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_8__;
      __temp_8__ = (__temp_4__ + __temp_7__);
      int __temp_9__;
      __temp_9__ = __iter_4__+(-2);
      int __temp_10__;
      __temp_10__ = __iter_5__;
      float __temp_11__;
      __temp_11__ = (5 * __tilevar_3__[__temp_10__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_9__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_12__;
      __temp_12__ = (__temp_8__ + __temp_11__);
      int __temp_13__;
      __temp_13__ = __iter_4__+(-2);
      int __temp_14__;
      __temp_14__ = __iter_5__+(1);
      float __temp_15__;
      __temp_15__ = (4 * __tilevar_3__[__temp_14__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_13__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_16__;
      __temp_16__ = (__temp_12__ + __temp_15__);
      int __temp_17__;
      __temp_17__ = __iter_4__+(-2);
      int __temp_18__;
      __temp_18__ = __iter_5__+(2);
      float __temp_19__;
      __temp_19__ = (2 * __tilevar_3__[__temp_18__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_17__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_20__;
      __temp_20__ = (__temp_16__ + __temp_19__);
      int __temp_21__;
      __temp_21__ = __iter_4__+(-1);
      int __temp_22__;
      __temp_22__ = __iter_5__+(-2);
      float __temp_23__;
      __temp_23__ = (4 * __tilevar_3__[__temp_22__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_21__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_24__;
      __temp_24__ = (__temp_20__ + __temp_23__);
      int __temp_25__;
      __temp_25__ = __iter_4__+(-1);
      int __temp_26__;
      __temp_26__ = __iter_5__+(-1);
      float __temp_27__;
      __temp_27__ = (9 * __tilevar_3__[__temp_26__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_25__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_28__;
      __temp_28__ = (__temp_24__ + __temp_27__);
      int __temp_29__;
      __temp_29__ = __iter_4__+(-1);
      int __temp_30__;
      __temp_30__ = __iter_5__;
      float __temp_31__;
      __temp_31__ = (12 * __tilevar_3__[__temp_30__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_29__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_32__;
      __temp_32__ = (__temp_28__ + __temp_31__);
      int __temp_33__;
      __temp_33__ = __iter_4__+(-1);
      int __temp_34__;
      __temp_34__ = __iter_5__+(1);
      float __temp_35__;
      __temp_35__ = (9 * __tilevar_3__[__temp_34__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_33__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_36__;
      __temp_36__ = (__temp_32__ + __temp_35__);
      int __temp_37__;
      __temp_37__ = __iter_4__+(-1);
      int __temp_38__;
      __temp_38__ = __iter_5__+(2);
      float __temp_39__;
      __temp_39__ = (4 * __tilevar_3__[__temp_38__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_37__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_40__;
      __temp_40__ = (__temp_36__ + __temp_39__);
      int __temp_41__;
      __temp_41__ = __iter_4__;
      int __temp_42__;
      __temp_42__ = __iter_5__+(-2);
      float __temp_43__;
      __temp_43__ = (5 * __tilevar_3__[__temp_42__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_41__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_44__;
      __temp_44__ = (__temp_40__ + __temp_43__);
      int __temp_45__;
      __temp_45__ = __iter_4__;
      int __temp_46__;
      __temp_46__ = __iter_5__+(-1);
      float __temp_47__;
      __temp_47__ = (12 * __tilevar_3__[__temp_46__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_45__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_48__;
      __temp_48__ = (__temp_44__ + __temp_47__);
      int __temp_49__;
      __temp_49__ = __iter_4__;
      int __temp_50__;
      __temp_50__ = __iter_5__;
      float __temp_51__;
      __temp_51__ = (15 * __tilevar_3__[__temp_50__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_49__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_52__;
      __temp_52__ = (__temp_48__ + __temp_51__);
      int __temp_53__;
      __temp_53__ = __iter_4__;
      int __temp_54__;
      __temp_54__ = __iter_5__+(1);
      float __temp_55__;
      __temp_55__ = (12 * __tilevar_3__[__temp_54__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_53__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_56__;
      __temp_56__ = (__temp_52__ + __temp_55__);
      int __temp_57__;
      __temp_57__ = __iter_4__;
      int __temp_58__;
      __temp_58__ = __iter_5__+(2);
      float __temp_59__;
      __temp_59__ = (5 * __tilevar_3__[__temp_58__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_57__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_60__;
      __temp_60__ = (__temp_56__ + __temp_59__);
      int __temp_61__;
      __temp_61__ = __iter_4__+(1);
      int __temp_62__;
      __temp_62__ = __iter_5__+(-2);
      float __temp_63__;
      __temp_63__ = (4 * __tilevar_3__[__temp_62__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_61__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_64__;
      __temp_64__ = (__temp_60__ + __temp_63__);
      int __temp_65__;
      __temp_65__ = __iter_4__+(1);
      int __temp_66__;
      __temp_66__ = __iter_5__+(-1);
      float __temp_67__;
      __temp_67__ = (9 * __tilevar_3__[__temp_66__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_65__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_68__;
      __temp_68__ = (__temp_64__ + __temp_67__);
      int __temp_69__;
      __temp_69__ = __iter_4__+(1);
      int __temp_70__;
      __temp_70__ = __iter_5__;
      float __temp_71__;
      __temp_71__ = (12 * __tilevar_3__[__temp_70__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_69__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_72__;
      __temp_72__ = (__temp_68__ + __temp_71__);
      int __temp_73__;
      __temp_73__ = __iter_4__+(1);
      int __temp_74__;
      __temp_74__ = __iter_5__+(1);
      float __temp_75__;
      __temp_75__ = (9 * __tilevar_3__[__temp_74__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_73__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_76__;
      __temp_76__ = (__temp_72__ + __temp_75__);
      int __temp_77__;
      __temp_77__ = __iter_4__+(1);
      int __temp_78__;
      __temp_78__ = __iter_5__+(2);
      float __temp_79__;
      __temp_79__ = (4 * __tilevar_3__[__temp_78__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_77__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_80__;
      __temp_80__ = (__temp_76__ + __temp_79__);
      int __temp_81__;
      __temp_81__ = __iter_4__+(2);
      int __temp_82__;
      __temp_82__ = __iter_5__+(-2);
      float __temp_83__;
      __temp_83__ = (2 * __tilevar_3__[__temp_82__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_81__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_84__;
      __temp_84__ = (__temp_80__ + __temp_83__);
      int __temp_85__;
      __temp_85__ = __iter_4__+(2);
      int __temp_86__;
      __temp_86__ = __iter_5__+(-1);
      float __temp_87__;
      __temp_87__ = (4 * __tilevar_3__[__temp_86__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_85__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_88__;
      __temp_88__ = (__temp_84__ + __temp_87__);
      int __temp_89__;
      __temp_89__ = __iter_4__+(2);
      int __temp_90__;
      __temp_90__ = __iter_5__;
      float __temp_91__;
      __temp_91__ = (5 * __tilevar_3__[__temp_90__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_89__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_92__;
      __temp_92__ = (__temp_88__ + __temp_91__);
      int __temp_93__;
      __temp_93__ = __iter_4__+(2);
      int __temp_94__;
      __temp_94__ = __iter_5__+(1);
      float __temp_95__;
      __temp_95__ = (4 * __tilevar_3__[__temp_94__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_93__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_96__;
      __temp_96__ = (__temp_92__ + __temp_95__);
      int __temp_97__;
      __temp_97__ = __iter_4__+(2);
      int __temp_98__;
      __temp_98__ = __iter_5__+(2);
      float __temp_99__;
      __temp_99__ = (2 * __tilevar_3__[__temp_98__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-16))*(__temp_97__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_100__;
      __temp_100__ = (__temp_96__ + __temp_99__);
      float __temp_101__;
      __temp_101__ = (__temp_100__ / 159);
      __tilevar_2__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))] = __temp_101__;
    }
  }
  __syncthreads();
  int __iter_6__;
  __iter_6__ = FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2) + (int)(threadIdx.y) ; 
  if( __iter_6__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3))+2),(N-3)) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2) + (int)(threadIdx.x) ; 
    if( __iter_7__ <= FORMA_MIN((FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3))+2),(M-3)) ){
      int __temp_102__;
      __temp_102__ = __iter_6__+(-2);
      int __temp_103__;
      __temp_103__ = __iter_7__+(-2);
      float __temp_104__;
      __temp_104__ = (2 * __tilevar_2__[__temp_103__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_102__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      int __temp_105__;
      __temp_105__ = __iter_6__+(-2);
      int __temp_106__;
      __temp_106__ = __iter_7__+(-1);
      float __temp_107__;
      __temp_107__ = (4 * __tilevar_2__[__temp_106__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_105__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_108__;
      __temp_108__ = (__temp_104__ + __temp_107__);
      int __temp_109__;
      __temp_109__ = __iter_6__+(-2);
      int __temp_110__;
      __temp_110__ = __iter_7__;
      float __temp_111__;
      __temp_111__ = (5 * __tilevar_2__[__temp_110__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_109__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_112__;
      __temp_112__ = (__temp_108__ + __temp_111__);
      int __temp_113__;
      __temp_113__ = __iter_6__+(-2);
      int __temp_114__;
      __temp_114__ = __iter_7__+(1);
      float __temp_115__;
      __temp_115__ = (4 * __tilevar_2__[__temp_114__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_113__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_116__;
      __temp_116__ = (__temp_112__ + __temp_115__);
      int __temp_117__;
      __temp_117__ = __iter_6__+(-2);
      int __temp_118__;
      __temp_118__ = __iter_7__+(2);
      float __temp_119__;
      __temp_119__ = (2 * __tilevar_2__[__temp_118__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_117__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_120__;
      __temp_120__ = (__temp_116__ + __temp_119__);
      int __temp_121__;
      __temp_121__ = __iter_6__+(-1);
      int __temp_122__;
      __temp_122__ = __iter_7__+(-2);
      float __temp_123__;
      __temp_123__ = (4 * __tilevar_2__[__temp_122__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_121__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_124__;
      __temp_124__ = (__temp_120__ + __temp_123__);
      int __temp_125__;
      __temp_125__ = __iter_6__+(-1);
      int __temp_126__;
      __temp_126__ = __iter_7__+(-1);
      float __temp_127__;
      __temp_127__ = (9 * __tilevar_2__[__temp_126__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_125__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_128__;
      __temp_128__ = (__temp_124__ + __temp_127__);
      int __temp_129__;
      __temp_129__ = __iter_6__+(-1);
      int __temp_130__;
      __temp_130__ = __iter_7__;
      float __temp_131__;
      __temp_131__ = (12 * __tilevar_2__[__temp_130__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_129__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_132__;
      __temp_132__ = (__temp_128__ + __temp_131__);
      int __temp_133__;
      __temp_133__ = __iter_6__+(-1);
      int __temp_134__;
      __temp_134__ = __iter_7__+(1);
      float __temp_135__;
      __temp_135__ = (9 * __tilevar_2__[__temp_134__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_133__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_136__;
      __temp_136__ = (__temp_132__ + __temp_135__);
      int __temp_137__;
      __temp_137__ = __iter_6__+(-1);
      int __temp_138__;
      __temp_138__ = __iter_7__+(2);
      float __temp_139__;
      __temp_139__ = (4 * __tilevar_2__[__temp_138__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_137__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_140__;
      __temp_140__ = (__temp_136__ + __temp_139__);
      int __temp_141__;
      __temp_141__ = __iter_6__;
      int __temp_142__;
      __temp_142__ = __iter_7__+(-2);
      float __temp_143__;
      __temp_143__ = (5 * __tilevar_2__[__temp_142__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_141__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_144__;
      __temp_144__ = (__temp_140__ + __temp_143__);
      int __temp_145__;
      __temp_145__ = __iter_6__;
      int __temp_146__;
      __temp_146__ = __iter_7__+(-1);
      float __temp_147__;
      __temp_147__ = (12 * __tilevar_2__[__temp_146__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_145__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_148__;
      __temp_148__ = (__temp_144__ + __temp_147__);
      int __temp_149__;
      __temp_149__ = __iter_6__;
      int __temp_150__;
      __temp_150__ = __iter_7__;
      float __temp_151__;
      __temp_151__ = (15 * __tilevar_2__[__temp_150__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_149__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_152__;
      __temp_152__ = (__temp_148__ + __temp_151__);
      int __temp_153__;
      __temp_153__ = __iter_6__;
      int __temp_154__;
      __temp_154__ = __iter_7__+(1);
      float __temp_155__;
      __temp_155__ = (12 * __tilevar_2__[__temp_154__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_153__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_156__;
      __temp_156__ = (__temp_152__ + __temp_155__);
      int __temp_157__;
      __temp_157__ = __iter_6__;
      int __temp_158__;
      __temp_158__ = __iter_7__+(2);
      float __temp_159__;
      __temp_159__ = (5 * __tilevar_2__[__temp_158__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_157__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_160__;
      __temp_160__ = (__temp_156__ + __temp_159__);
      int __temp_161__;
      __temp_161__ = __iter_6__+(1);
      int __temp_162__;
      __temp_162__ = __iter_7__+(-2);
      float __temp_163__;
      __temp_163__ = (4 * __tilevar_2__[__temp_162__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_161__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_164__;
      __temp_164__ = (__temp_160__ + __temp_163__);
      int __temp_165__;
      __temp_165__ = __iter_6__+(1);
      int __temp_166__;
      __temp_166__ = __iter_7__+(-1);
      float __temp_167__;
      __temp_167__ = (9 * __tilevar_2__[__temp_166__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_165__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_168__;
      __temp_168__ = (__temp_164__ + __temp_167__);
      int __temp_169__;
      __temp_169__ = __iter_6__+(1);
      int __temp_170__;
      __temp_170__ = __iter_7__;
      float __temp_171__;
      __temp_171__ = (12 * __tilevar_2__[__temp_170__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_169__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_172__;
      __temp_172__ = (__temp_168__ + __temp_171__);
      int __temp_173__;
      __temp_173__ = __iter_6__+(1);
      int __temp_174__;
      __temp_174__ = __iter_7__+(1);
      float __temp_175__;
      __temp_175__ = (9 * __tilevar_2__[__temp_174__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_173__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_176__;
      __temp_176__ = (__temp_172__ + __temp_175__);
      int __temp_177__;
      __temp_177__ = __iter_6__+(1);
      int __temp_178__;
      __temp_178__ = __iter_7__+(2);
      float __temp_179__;
      __temp_179__ = (4 * __tilevar_2__[__temp_178__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_177__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_180__;
      __temp_180__ = (__temp_176__ + __temp_179__);
      int __temp_181__;
      __temp_181__ = __iter_6__+(2);
      int __temp_182__;
      __temp_182__ = __iter_7__+(-2);
      float __temp_183__;
      __temp_183__ = (2 * __tilevar_2__[__temp_182__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_181__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_184__;
      __temp_184__ = (__temp_180__ + __temp_183__);
      int __temp_185__;
      __temp_185__ = __iter_6__+(2);
      int __temp_186__;
      __temp_186__ = __iter_7__+(-1);
      float __temp_187__;
      __temp_187__ = (4 * __tilevar_2__[__temp_186__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_185__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_188__;
      __temp_188__ = (__temp_184__ + __temp_187__);
      int __temp_189__;
      __temp_189__ = __iter_6__+(2);
      int __temp_190__;
      __temp_190__ = __iter_7__;
      float __temp_191__;
      __temp_191__ = (5 * __tilevar_2__[__temp_190__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_189__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_192__;
      __temp_192__ = (__temp_188__ + __temp_191__);
      int __temp_193__;
      __temp_193__ = __iter_6__+(2);
      int __temp_194__;
      __temp_194__ = __iter_7__+(1);
      float __temp_195__;
      __temp_195__ = (4 * __tilevar_2__[__temp_194__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_193__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_196__;
      __temp_196__ = (__temp_192__ + __temp_195__);
      int __temp_197__;
      __temp_197__ = __iter_6__+(2);
      int __temp_198__;
      __temp_198__ = __iter_7__+(2);
      float __temp_199__;
      __temp_199__ = (2 * __tilevar_2__[__temp_198__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-12))*(__temp_197__+(0-(FORMA_MAX((FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)),2)-2)))]);
      float __temp_200__;
      __temp_200__ = (__temp_196__ + __temp_199__);
      float __temp_201__;
      __temp_201__ = (__temp_200__ / 159);
      __tilevar_1__[__iter_7__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_6__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))] = __temp_201__;
    }
  }
  __syncthreads();
  int __iter_8__;
  __iter_8__ = FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2) + (int)(threadIdx.y) ; 
  if( __iter_8__ <= FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3)) ){
    int __iter_9__;
    __iter_9__ = FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2) + (int)(threadIdx.x) ; 
    if( __iter_9__ <= FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3)) ){
      float __temp_202__;
      __temp_202__ = (2 * __tilevar_1__[__iter_9__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_203__;
      __temp_203__ = (4 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_204__;
      __temp_204__ = (__temp_202__ + __temp_203__);
      float __temp_205__;
      __temp_205__ = (5 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_206__;
      __temp_206__ = (__temp_204__ + __temp_205__);
      float __temp_207__;
      __temp_207__ = (4 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_208__;
      __temp_208__ = (__temp_206__ + __temp_207__);
      float __temp_209__;
      __temp_209__ = (2 * __tilevar_1__[__iter_9__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_210__;
      __temp_210__ = (__temp_208__ + __temp_209__);
      float __temp_211__;
      __temp_211__ = (4 * __tilevar_1__[__iter_9__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_212__;
      __temp_212__ = (__temp_210__ + __temp_211__);
      float __temp_213__;
      __temp_213__ = (9 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_214__;
      __temp_214__ = (__temp_212__ + __temp_213__);
      float __temp_215__;
      __temp_215__ = (12 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_216__;
      __temp_216__ = (__temp_214__ + __temp_215__);
      float __temp_217__;
      __temp_217__ = (9 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_218__;
      __temp_218__ = (__temp_216__ + __temp_217__);
      float __temp_219__;
      __temp_219__ = (4 * __tilevar_1__[__iter_9__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_220__;
      __temp_220__ = (__temp_218__ + __temp_219__);
      float __temp_221__;
      __temp_221__ = (5 * __tilevar_1__[__iter_9__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_222__;
      __temp_222__ = (__temp_220__ + __temp_221__);
      float __temp_223__;
      __temp_223__ = (12 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_224__;
      __temp_224__ = (__temp_222__ + __temp_223__);
      float __temp_225__;
      __temp_225__ = (15 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_226__;
      __temp_226__ = (__temp_224__ + __temp_225__);
      float __temp_227__;
      __temp_227__ = (12 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_228__;
      __temp_228__ = (__temp_226__ + __temp_227__);
      float __temp_229__;
      __temp_229__ = (5 * __tilevar_1__[__iter_9__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_230__;
      __temp_230__ = (__temp_228__ + __temp_229__);
      float __temp_231__;
      __temp_231__ = (4 * __tilevar_1__[__iter_9__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_232__;
      __temp_232__ = (__temp_230__ + __temp_231__);
      float __temp_233__;
      __temp_233__ = (9 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_234__;
      __temp_234__ = (__temp_232__ + __temp_233__);
      float __temp_235__;
      __temp_235__ = (12 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_236__;
      __temp_236__ = (__temp_234__ + __temp_235__);
      float __temp_237__;
      __temp_237__ = (9 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_238__;
      __temp_238__ = (__temp_236__ + __temp_237__);
      float __temp_239__;
      __temp_239__ = (4 * __tilevar_1__[__iter_9__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_240__;
      __temp_240__ = (__temp_238__ + __temp_239__);
      float __temp_241__;
      __temp_241__ = (2 * __tilevar_1__[__iter_9__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_242__;
      __temp_242__ = (__temp_240__ + __temp_241__);
      float __temp_243__;
      __temp_243__ = (4 * __tilevar_1__[__iter_9__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_244__;
      __temp_244__ = (__temp_242__ + __temp_243__);
      float __temp_245__;
      __temp_245__ = (5 * __tilevar_1__[__iter_9__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_246__;
      __temp_246__ = (__temp_244__ + __temp_245__);
      float __temp_247__;
      __temp_247__ = (4 * __tilevar_1__[__iter_9__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_248__;
      __temp_248__ = (__temp_246__ + __temp_247__);
      float __temp_249__;
      __temp_249__ = (2 * __tilevar_1__[__iter_9__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_8__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_250__;
      __temp_250__ = (__temp_248__ + __temp_249__);
      float __temp_251__;
      __temp_251__ = (__temp_250__ / 159);
      __tilevar_0__[__iter_9__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_8__+(0-(FORMA_MAX(__iter_1__,2)-2)))] = __temp_251__;
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX(__iter_1__,2) + (int)(threadIdx.y) ; 
  if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX(__iter_0__,2) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      float __temp_252__;
      __temp_252__ = (2 * __tilevar_0__[__iter_11__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_253__;
      __temp_253__ = (4 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_254__;
      __temp_254__ = (__temp_252__ + __temp_253__);
      float __temp_255__;
      __temp_255__ = (5 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_256__;
      __temp_256__ = (__temp_254__ + __temp_255__);
      float __temp_257__;
      __temp_257__ = (4 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_258__;
      __temp_258__ = (__temp_256__ + __temp_257__);
      float __temp_259__;
      __temp_259__ = (2 * __tilevar_0__[__iter_11__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_260__;
      __temp_260__ = (__temp_258__ + __temp_259__);
      float __temp_261__;
      __temp_261__ = (4 * __tilevar_0__[__iter_11__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_262__;
      __temp_262__ = (__temp_260__ + __temp_261__);
      float __temp_263__;
      __temp_263__ = (9 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_264__;
      __temp_264__ = (__temp_262__ + __temp_263__);
      float __temp_265__;
      __temp_265__ = (12 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_266__;
      __temp_266__ = (__temp_264__ + __temp_265__);
      float __temp_267__;
      __temp_267__ = (9 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_268__;
      __temp_268__ = (__temp_266__ + __temp_267__);
      float __temp_269__;
      __temp_269__ = (4 * __tilevar_0__[__iter_11__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_270__;
      __temp_270__ = (__temp_268__ + __temp_269__);
      float __temp_271__;
      __temp_271__ = (5 * __tilevar_0__[__iter_11__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_272__;
      __temp_272__ = (__temp_270__ + __temp_271__);
      float __temp_273__;
      __temp_273__ = (12 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_274__;
      __temp_274__ = (__temp_272__ + __temp_273__);
      float __temp_275__;
      __temp_275__ = (15 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_276__;
      __temp_276__ = (__temp_274__ + __temp_275__);
      float __temp_277__;
      __temp_277__ = (12 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_278__;
      __temp_278__ = (__temp_276__ + __temp_277__);
      float __temp_279__;
      __temp_279__ = (5 * __tilevar_0__[__iter_11__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_280__;
      __temp_280__ = (__temp_278__ + __temp_279__);
      float __temp_281__;
      __temp_281__ = (4 * __tilevar_0__[__iter_11__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_282__;
      __temp_282__ = (__temp_280__ + __temp_281__);
      float __temp_283__;
      __temp_283__ = (9 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_284__;
      __temp_284__ = (__temp_282__ + __temp_283__);
      float __temp_285__;
      __temp_285__ = (12 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_286__;
      __temp_286__ = (__temp_284__ + __temp_285__);
      float __temp_287__;
      __temp_287__ = (9 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_288__;
      __temp_288__ = (__temp_286__ + __temp_287__);
      float __temp_289__;
      __temp_289__ = (4 * __tilevar_0__[__iter_11__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_290__;
      __temp_290__ = (__temp_288__ + __temp_289__);
      float __temp_291__;
      __temp_291__ = (2 * __tilevar_0__[__iter_11__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_292__;
      __temp_292__ = (__temp_290__ + __temp_291__);
      float __temp_293__;
      __temp_293__ = (4 * __tilevar_0__[__iter_11__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_294__;
      __temp_294__ = (__temp_292__ + __temp_293__);
      float __temp_295__;
      __temp_295__ = (5 * __tilevar_0__[__iter_11__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_296__;
      __temp_296__ = (__temp_294__ + __temp_295__);
      float __temp_297__;
      __temp_297__ = (4 * __tilevar_0__[__iter_11__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_298__;
      __temp_298__ = (__temp_296__ + __temp_297__);
      float __temp_299__;
      __temp_299__ = (2 * __tilevar_0__[__iter_11__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_10__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_300__;
      __temp_300__ = (__temp_298__ + __temp_299__);
      float __temp_301__;
      __temp_301__ = (__temp_300__ / 159);
      __var_1__[__iter_11__+(M-0)*(__iter_10__)] = __temp_301__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (8-(-8));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (8-(-8));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-16))*(FORMA_BLOCKDIM_X-(-16))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-12))*(FORMA_BLOCKDIM_X-(-12))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void gaussian(float * h_input, int N, int M, float * __var_0__){

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
  int __size_0___kernel___forma_kernel__0__ = ((M-3) - 2 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((N-3) - 2 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int _max_occupancy_gridsize___kernel___forma_kernel__0__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__0__,&__max_occupancy_blocksize___kernel___forma_kernel__0__,(const void*)__kernel___forma_kernel__0__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__0___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__0__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__0___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__0___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___0,FORMA_MAX((__size_0___kernel___forma_kernel__0__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),17);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_0___kernel___forma_kernel__0__;
  int __max_occupancy_blocksize___kernel___forma_kernel__0___1 = __max_occupancy_blocksize___kernel___forma_kernel__0__;
  int __block_1___kernel___forma_kernel__0__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__0___1,__size_1___kernel___forma_kernel__0__),FORMA_MAX_BLOCKDIM_1),17);
  __max_occupancy_blocksize___kernel___forma_kernel__0__ /= __block_1___kernel___forma_kernel__0__;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  while( __SMemSize___kernel___forma_kernel__0__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__0__.y/2 > 17)
      __blockConfig___kernel___forma_kernel__0__.y /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
    if( __SMemSize___kernel___forma_kernel__0__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__0__.x/2 > FORMA_MIN(32,17))
      __blockConfig___kernel___forma_kernel__0__.x /= 2;
    __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  }
  __block_0___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.x-(8-(-8));
  __block_1___kernel___forma_kernel__0__ = __blockConfig___kernel___forma_kernel__0__.y-(8-(-8));
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
