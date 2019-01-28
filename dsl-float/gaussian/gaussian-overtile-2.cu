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
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (4-(-4));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (4-(-4));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 2;
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 2;
  int __iter_2__;
  __iter_2__ = (FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)+(-2)) + (int)(threadIdx.y) ; 
  if( __iter_2__ <= (FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3))+2) ){
    int __iter_3__;
    __iter_3__ = (FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)+(-2)) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= (FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3))+2) ){
      int __temp_0__;
      __temp_0__ = __iter_2__;
      int __temp_1__;
      __temp_1__ = __iter_3__;
      __tilevar_1__[__iter_3__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_2__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))] = input[__temp_1__+(M-0)*(__temp_0__)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2) + (int)(threadIdx.y) ; 
  if( __iter_4__ <= FORMA_MIN((FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN((FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3)) ){
      float __temp_2__;
      __temp_2__ = (2 * __tilevar_1__[__iter_5__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_3__;
      __temp_3__ = (4 * __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_4__;
      __temp_4__ = (__temp_2__ + __temp_3__);
      float __temp_5__;
      __temp_5__ = (5 * __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_6__;
      __temp_6__ = (__temp_4__ + __temp_5__);
      float __temp_7__;
      __temp_7__ = (4 * __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_8__;
      __temp_8__ = (__temp_6__ + __temp_7__);
      float __temp_9__;
      __temp_9__ = (2 * __tilevar_1__[__iter_5__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_10__;
      __temp_10__ = (__temp_8__ + __temp_9__);
      float __temp_11__;
      __temp_11__ = (4 * __tilevar_1__[__iter_5__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_12__;
      __temp_12__ = (__temp_10__ + __temp_11__);
      float __temp_13__;
      __temp_13__ = (9 * __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_14__;
      __temp_14__ = (__temp_12__ + __temp_13__);
      float __temp_15__;
      __temp_15__ = (12 * __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_16__;
      __temp_16__ = (__temp_14__ + __temp_15__);
      float __temp_17__;
      __temp_17__ = (9 * __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_18__;
      __temp_18__ = (__temp_16__ + __temp_17__);
      float __temp_19__;
      __temp_19__ = (4 * __tilevar_1__[__iter_5__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_20__;
      __temp_20__ = (__temp_18__ + __temp_19__);
      float __temp_21__;
      __temp_21__ = (5 * __tilevar_1__[__iter_5__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_22__;
      __temp_22__ = (__temp_20__ + __temp_21__);
      float __temp_23__;
      __temp_23__ = (12 * __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_24__;
      __temp_24__ = (__temp_22__ + __temp_23__);
      float __temp_25__;
      __temp_25__ = (15 * __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_26__;
      __temp_26__ = (__temp_24__ + __temp_25__);
      float __temp_27__;
      __temp_27__ = (12 * __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_28__;
      __temp_28__ = (__temp_26__ + __temp_27__);
      float __temp_29__;
      __temp_29__ = (5 * __tilevar_1__[__iter_5__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_30__;
      __temp_30__ = (__temp_28__ + __temp_29__);
      float __temp_31__;
      __temp_31__ = (4 * __tilevar_1__[__iter_5__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_32__;
      __temp_32__ = (__temp_30__ + __temp_31__);
      float __temp_33__;
      __temp_33__ = (9 * __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_34__;
      __temp_34__ = (__temp_32__ + __temp_33__);
      float __temp_35__;
      __temp_35__ = (12 * __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_36__;
      __temp_36__ = (__temp_34__ + __temp_35__);
      float __temp_37__;
      __temp_37__ = (9 * __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_38__;
      __temp_38__ = (__temp_36__ + __temp_37__);
      float __temp_39__;
      __temp_39__ = (4 * __tilevar_1__[__iter_5__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_40__;
      __temp_40__ = (__temp_38__ + __temp_39__);
      float __temp_41__;
      __temp_41__ = (2 * __tilevar_1__[__iter_5__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_42__;
      __temp_42__ = (__temp_40__ + __temp_41__);
      float __temp_43__;
      __temp_43__ = (4 * __tilevar_1__[__iter_5__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_44__;
      __temp_44__ = (__temp_42__ + __temp_43__);
      float __temp_45__;
      __temp_45__ = (5 * __tilevar_1__[__iter_5__+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_46__;
      __temp_46__ = (__temp_44__ + __temp_45__);
      float __temp_47__;
      __temp_47__ = (4 * __tilevar_1__[__iter_5__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_48__;
      __temp_48__ = (__temp_46__ + __temp_47__);
      float __temp_49__;
      __temp_49__ = (2 * __tilevar_1__[__iter_5__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_0__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_4__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_1__,2)+(-2)),2)-2)))]);
      float __temp_50__;
      __temp_50__ = (__temp_48__ + __temp_49__);
      float __temp_51__;
      __temp_51__ = (__temp_50__ / 159);
      __tilevar_0__[__iter_5__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_4__+(0-(FORMA_MAX(__iter_1__,2)-2)))] = __temp_51__;
    }
  }
  __syncthreads();
  int __iter_6__;
  __iter_6__ = FORMA_MAX(__iter_1__,2) + (int)(threadIdx.y) ; 
  if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3)) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX(__iter_0__,2) + (int)(threadIdx.x) ; 
    if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      float __temp_52__;
      __temp_52__ = (2 * __tilevar_0__[__iter_7__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_53__;
      __temp_53__ = (4 * __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_54__;
      __temp_54__ = (__temp_52__ + __temp_53__);
      float __temp_55__;
      __temp_55__ = (5 * __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_56__;
      __temp_56__ = (__temp_54__ + __temp_55__);
      float __temp_57__;
      __temp_57__ = (4 * __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_58__;
      __temp_58__ = (__temp_56__ + __temp_57__);
      float __temp_59__;
      __temp_59__ = (2 * __tilevar_0__[__iter_7__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_60__;
      __temp_60__ = (__temp_58__ + __temp_59__);
      float __temp_61__;
      __temp_61__ = (4 * __tilevar_0__[__iter_7__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_62__;
      __temp_62__ = (__temp_60__ + __temp_61__);
      float __temp_63__;
      __temp_63__ = (9 * __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_64__;
      __temp_64__ = (__temp_62__ + __temp_63__);
      float __temp_65__;
      __temp_65__ = (12 * __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_66__;
      __temp_66__ = (__temp_64__ + __temp_65__);
      float __temp_67__;
      __temp_67__ = (9 * __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_68__;
      __temp_68__ = (__temp_66__ + __temp_67__);
      float __temp_69__;
      __temp_69__ = (4 * __tilevar_0__[__iter_7__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(-1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_70__;
      __temp_70__ = (__temp_68__ + __temp_69__);
      float __temp_71__;
      __temp_71__ = (5 * __tilevar_0__[__iter_7__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_72__;
      __temp_72__ = (__temp_70__ + __temp_71__);
      float __temp_73__;
      __temp_73__ = (12 * __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_74__;
      __temp_74__ = (__temp_72__ + __temp_73__);
      float __temp_75__;
      __temp_75__ = (15 * __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_76__;
      __temp_76__ = (__temp_74__ + __temp_75__);
      float __temp_77__;
      __temp_77__ = (12 * __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_78__;
      __temp_78__ = (__temp_76__ + __temp_77__);
      float __temp_79__;
      __temp_79__ = (5 * __tilevar_0__[__iter_7__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_80__;
      __temp_80__ = (__temp_78__ + __temp_79__);
      float __temp_81__;
      __temp_81__ = (4 * __tilevar_0__[__iter_7__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_82__;
      __temp_82__ = (__temp_80__ + __temp_81__);
      float __temp_83__;
      __temp_83__ = (9 * __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_84__;
      __temp_84__ = (__temp_82__ + __temp_83__);
      float __temp_85__;
      __temp_85__ = (12 * __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_86__;
      __temp_86__ = (__temp_84__ + __temp_85__);
      float __temp_87__;
      __temp_87__ = (9 * __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_88__;
      __temp_88__ = (__temp_86__ + __temp_87__);
      float __temp_89__;
      __temp_89__ = (4 * __tilevar_0__[__iter_7__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(1)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_90__;
      __temp_90__ = (__temp_88__ + __temp_89__);
      float __temp_91__;
      __temp_91__ = (2 * __tilevar_0__[__iter_7__+(-2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_92__;
      __temp_92__ = (__temp_90__ + __temp_91__);
      float __temp_93__;
      __temp_93__ = (4 * __tilevar_0__[__iter_7__+(-1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_94__;
      __temp_94__ = (__temp_92__ + __temp_93__);
      float __temp_95__;
      __temp_95__ = (5 * __tilevar_0__[__iter_7__+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_96__;
      __temp_96__ = (__temp_94__ + __temp_95__);
      float __temp_97__;
      __temp_97__ = (4 * __tilevar_0__[__iter_7__+(1)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_98__;
      __temp_98__ = (__temp_96__ + __temp_97__);
      float __temp_99__;
      __temp_99__ = (2 * __tilevar_0__[__iter_7__+(2)+(0-(FORMA_MAX(__iter_0__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_6__+(2)+(0-(FORMA_MAX(__iter_1__,2)-2)))]);
      float __temp_100__;
      __temp_100__ = (__temp_98__ + __temp_99__);
      float __temp_101__;
      __temp_101__ = (__temp_100__ / 159);
      __var_2__[__iter_7__+(M-0)*(__iter_6__)] = __temp_101__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (4-(-4));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (4-(-4));
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  return SMemSize;
}

__global__ void __kernel___forma_kernel__1__(float * __restrict__ __var_2__, int N, int M, float * __restrict__ __var_1__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (4-(-4));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (4-(-4));
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-8))*(FORMA_BLOCKDIM_X-(-8))));
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y-(-4))*(FORMA_BLOCKDIM_X-(-4))));
  int __iter_8__;
  __iter_8__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + 2;
  int __iter_9__;
  __iter_9__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + 2;
  int __iter_10__;
  __iter_10__ = (FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)+(-2)) + (int)(threadIdx.y) ; 
  if( __iter_10__ <= (FORMA_MIN((FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3))+2) ){
    int __iter_11__;
    __iter_11__ = (FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)+(-2)) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= (FORMA_MIN((FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3))+2) ){
      int __temp_102__;
      __temp_102__ = __iter_10__;
      int __temp_103__;
      __temp_103__ = __iter_11__;
      __tilevar_3__[__iter_11__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_10__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))] = __var_2__[__temp_103__+(M-0)*(__temp_102__)];
    }
  }
  __syncthreads();
  int __iter_12__;
  __iter_12__ = FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2) + (int)(threadIdx.y) ; 
  if( __iter_12__ <= FORMA_MIN((FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-3))+2),(N-3)) ){
    int __iter_13__;
    __iter_13__ = FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2) + (int)(threadIdx.x) ; 
    if( __iter_13__ <= FORMA_MIN((FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-3))+2),(M-3)) ){
      float __temp_104__;
      __temp_104__ = (2 * __tilevar_3__[__iter_13__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_105__;
      __temp_105__ = (4 * __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_106__;
      __temp_106__ = (__temp_104__ + __temp_105__);
      float __temp_107__;
      __temp_107__ = (5 * __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_108__;
      __temp_108__ = (__temp_106__ + __temp_107__);
      float __temp_109__;
      __temp_109__ = (4 * __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_110__;
      __temp_110__ = (__temp_108__ + __temp_109__);
      float __temp_111__;
      __temp_111__ = (2 * __tilevar_3__[__iter_13__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_112__;
      __temp_112__ = (__temp_110__ + __temp_111__);
      float __temp_113__;
      __temp_113__ = (4 * __tilevar_3__[__iter_13__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_114__;
      __temp_114__ = (__temp_112__ + __temp_113__);
      float __temp_115__;
      __temp_115__ = (9 * __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_116__;
      __temp_116__ = (__temp_114__ + __temp_115__);
      float __temp_117__;
      __temp_117__ = (12 * __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_118__;
      __temp_118__ = (__temp_116__ + __temp_117__);
      float __temp_119__;
      __temp_119__ = (9 * __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_120__;
      __temp_120__ = (__temp_118__ + __temp_119__);
      float __temp_121__;
      __temp_121__ = (4 * __tilevar_3__[__iter_13__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_122__;
      __temp_122__ = (__temp_120__ + __temp_121__);
      float __temp_123__;
      __temp_123__ = (5 * __tilevar_3__[__iter_13__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_124__;
      __temp_124__ = (__temp_122__ + __temp_123__);
      float __temp_125__;
      __temp_125__ = (12 * __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_126__;
      __temp_126__ = (__temp_124__ + __temp_125__);
      float __temp_127__;
      __temp_127__ = (15 * __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_128__;
      __temp_128__ = (__temp_126__ + __temp_127__);
      float __temp_129__;
      __temp_129__ = (12 * __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_130__;
      __temp_130__ = (__temp_128__ + __temp_129__);
      float __temp_131__;
      __temp_131__ = (5 * __tilevar_3__[__iter_13__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_132__;
      __temp_132__ = (__temp_130__ + __temp_131__);
      float __temp_133__;
      __temp_133__ = (4 * __tilevar_3__[__iter_13__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_134__;
      __temp_134__ = (__temp_132__ + __temp_133__);
      float __temp_135__;
      __temp_135__ = (9 * __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_136__;
      __temp_136__ = (__temp_134__ + __temp_135__);
      float __temp_137__;
      __temp_137__ = (12 * __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_138__;
      __temp_138__ = (__temp_136__ + __temp_137__);
      float __temp_139__;
      __temp_139__ = (9 * __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_140__;
      __temp_140__ = (__temp_138__ + __temp_139__);
      float __temp_141__;
      __temp_141__ = (4 * __tilevar_3__[__iter_13__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_142__;
      __temp_142__ = (__temp_140__ + __temp_141__);
      float __temp_143__;
      __temp_143__ = (2 * __tilevar_3__[__iter_13__+(-2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_144__;
      __temp_144__ = (__temp_142__ + __temp_143__);
      float __temp_145__;
      __temp_145__ = (4 * __tilevar_3__[__iter_13__+(-1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_146__;
      __temp_146__ = (__temp_144__ + __temp_145__);
      float __temp_147__;
      __temp_147__ = (5 * __tilevar_3__[__iter_13__+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_148__;
      __temp_148__ = (__temp_146__ + __temp_147__);
      float __temp_149__;
      __temp_149__ = (4 * __tilevar_3__[__iter_13__+(1)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_150__;
      __temp_150__ = (__temp_148__ + __temp_149__);
      float __temp_151__;
      __temp_151__ = (2 * __tilevar_3__[__iter_13__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_8__,2)+(-2)),2)-2))+(FORMA_BLOCKDIM_X-(-8))*(__iter_12__+(2)+(0-(FORMA_MAX((FORMA_MAX(__iter_9__,2)+(-2)),2)-2)))]);
      float __temp_152__;
      __temp_152__ = (__temp_150__ + __temp_151__);
      float __temp_153__;
      __temp_153__ = (__temp_152__ / 159);
      __tilevar_2__[__iter_13__+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_12__+(0-(FORMA_MAX(__iter_9__,2)-2)))] = __temp_153__;
    }
  }
  __syncthreads();
  int __iter_14__;
  __iter_14__ = FORMA_MAX(__iter_9__,2) + (int)(threadIdx.y) ; 
  if( __iter_14__ <= FORMA_MIN(((__iter_9__+FORMA_BLOCKDIM_Y)-1),(N-3)) ){
    int __iter_15__;
    __iter_15__ = FORMA_MAX(__iter_8__,2) + (int)(threadIdx.x) ; 
    if( __iter_15__ <= FORMA_MIN(((__iter_8__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      float __temp_154__;
      __temp_154__ = (2 * __tilevar_2__[__iter_15__+(-2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_155__;
      __temp_155__ = (4 * __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_156__;
      __temp_156__ = (__temp_154__ + __temp_155__);
      float __temp_157__;
      __temp_157__ = (5 * __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_158__;
      __temp_158__ = (__temp_156__ + __temp_157__);
      float __temp_159__;
      __temp_159__ = (4 * __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_160__;
      __temp_160__ = (__temp_158__ + __temp_159__);
      float __temp_161__;
      __temp_161__ = (2 * __tilevar_2__[__iter_15__+(2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_162__;
      __temp_162__ = (__temp_160__ + __temp_161__);
      float __temp_163__;
      __temp_163__ = (4 * __tilevar_2__[__iter_15__+(-2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_164__;
      __temp_164__ = (__temp_162__ + __temp_163__);
      float __temp_165__;
      __temp_165__ = (9 * __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_166__;
      __temp_166__ = (__temp_164__ + __temp_165__);
      float __temp_167__;
      __temp_167__ = (12 * __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_168__;
      __temp_168__ = (__temp_166__ + __temp_167__);
      float __temp_169__;
      __temp_169__ = (9 * __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_170__;
      __temp_170__ = (__temp_168__ + __temp_169__);
      float __temp_171__;
      __temp_171__ = (4 * __tilevar_2__[__iter_15__+(2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(-1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_172__;
      __temp_172__ = (__temp_170__ + __temp_171__);
      float __temp_173__;
      __temp_173__ = (5 * __tilevar_2__[__iter_15__+(-2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_174__;
      __temp_174__ = (__temp_172__ + __temp_173__);
      float __temp_175__;
      __temp_175__ = (12 * __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_176__;
      __temp_176__ = (__temp_174__ + __temp_175__);
      float __temp_177__;
      __temp_177__ = (15 * __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_178__;
      __temp_178__ = (__temp_176__ + __temp_177__);
      float __temp_179__;
      __temp_179__ = (12 * __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_180__;
      __temp_180__ = (__temp_178__ + __temp_179__);
      float __temp_181__;
      __temp_181__ = (5 * __tilevar_2__[__iter_15__+(2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_182__;
      __temp_182__ = (__temp_180__ + __temp_181__);
      float __temp_183__;
      __temp_183__ = (4 * __tilevar_2__[__iter_15__+(-2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_184__;
      __temp_184__ = (__temp_182__ + __temp_183__);
      float __temp_185__;
      __temp_185__ = (9 * __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_186__;
      __temp_186__ = (__temp_184__ + __temp_185__);
      float __temp_187__;
      __temp_187__ = (12 * __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_188__;
      __temp_188__ = (__temp_186__ + __temp_187__);
      float __temp_189__;
      __temp_189__ = (9 * __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_190__;
      __temp_190__ = (__temp_188__ + __temp_189__);
      float __temp_191__;
      __temp_191__ = (4 * __tilevar_2__[__iter_15__+(2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(1)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_192__;
      __temp_192__ = (__temp_190__ + __temp_191__);
      float __temp_193__;
      __temp_193__ = (2 * __tilevar_2__[__iter_15__+(-2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_194__;
      __temp_194__ = (__temp_192__ + __temp_193__);
      float __temp_195__;
      __temp_195__ = (4 * __tilevar_2__[__iter_15__+(-1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_196__;
      __temp_196__ = (__temp_194__ + __temp_195__);
      float __temp_197__;
      __temp_197__ = (5 * __tilevar_2__[__iter_15__+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_198__;
      __temp_198__ = (__temp_196__ + __temp_197__);
      float __temp_199__;
      __temp_199__ = (4 * __tilevar_2__[__iter_15__+(1)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_200__;
      __temp_200__ = (__temp_198__ + __temp_199__);
      float __temp_201__;
      __temp_201__ = (2 * __tilevar_2__[__iter_15__+(2)+(0-(FORMA_MAX(__iter_8__,2)-2))+(FORMA_BLOCKDIM_X-(-4))*(__iter_14__+(2)+(0-(FORMA_MAX(__iter_9__,2)-2)))]);
      float __temp_202__;
      __temp_202__ = (__temp_200__ + __temp_201__);
      float __temp_203__;
      __temp_203__ = (__temp_202__ / 159);
      __var_1__[__iter_15__+(M-0)*(__iter_14__)] = __temp_203__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__1__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y)- (4-(-4));
  int FORMA_BLOCKDIM_X = (int)(blockDim.x)- (4-(-4));
  int SMemSize = 0;
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
  int __size_0___kernel___forma_kernel__0__ = ((M-3) - 2 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((N-3) - 2 ) + 1;
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
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  int __size_0___kernel___forma_kernel__1__ = ((M-3) - 2 ) + 1;
  int __size_1___kernel___forma_kernel__1__ = ((N-3) - 2 ) + 1;
  int __max_occupancy_blocksize___kernel___forma_kernel__1__;
  int _max_occupancy_gridsize___kernel___forma_kernel__1__;
  cudaOccupancyMaxPotentialBlockSize(&_max_occupancy_gridsize___kernel___forma_kernel__1__,&__max_occupancy_blocksize___kernel___forma_kernel__1__,(const void*)__kernel___forma_kernel__1__,0,0);
  int __max_occupancy_blocksize___kernel___forma_kernel__1___0 = pow((double)__max_occupancy_blocksize___kernel___forma_kernel__1__, (double)(1.0/(double)2));
  __max_occupancy_blocksize___kernel___forma_kernel__1___0 = FORMA_MAX(__max_occupancy_blocksize___kernel___forma_kernel__1___0/32, 1)*32;
  int __block_0___kernel___forma_kernel__1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__1___0,FORMA_MAX((__size_0___kernel___forma_kernel__1__)/32,1)*32),FORMA_MAX_BLOCKDIM_0),9);
  __max_occupancy_blocksize___kernel___forma_kernel__1__ /= __block_0___kernel___forma_kernel__1__;
  int __max_occupancy_blocksize___kernel___forma_kernel__1___1 = __max_occupancy_blocksize___kernel___forma_kernel__1__;
  int __block_1___kernel___forma_kernel__1__ = FORMA_MAX(FORMA_MIN(FORMA_MIN(__max_occupancy_blocksize___kernel___forma_kernel__1___1,__size_1___kernel___forma_kernel__1__),FORMA_MAX_BLOCKDIM_1),9);
  __max_occupancy_blocksize___kernel___forma_kernel__1__ /= __block_1___kernel___forma_kernel__1__;
  dim3 __blockConfig___kernel___forma_kernel__1__(__block_0___kernel___forma_kernel__1__,__block_1___kernel___forma_kernel__1__);
  int __SMemSize___kernel___forma_kernel__1__ = 0;
  __SMemSize___kernel___forma_kernel__1__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__1__);
  while( __SMemSize___kernel___forma_kernel__1__ > __FORMA_MAX_SHARED_MEM__){
    if( __blockConfig___kernel___forma_kernel__1__.y/2 > 9)
      __blockConfig___kernel___forma_kernel__1__.y /= 2;
    __SMemSize___kernel___forma_kernel__1__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__1__);
    if( __SMemSize___kernel___forma_kernel__1__ <= __FORMA_MAX_SHARED_MEM__)
      break;
    if( __blockConfig___kernel___forma_kernel__1__.x/2 > FORMA_MIN(32,9))
      __blockConfig___kernel___forma_kernel__1__.x /= 2;
    __SMemSize___kernel___forma_kernel__1__ = __blockSizeToSMemSize___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__1__);
  }
  __block_0___kernel___forma_kernel__1__ = __blockConfig___kernel___forma_kernel__1__.x-(4-(-4));
  __block_1___kernel___forma_kernel__1__ = __blockConfig___kernel___forma_kernel__1__.y-(4-(-4));
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
