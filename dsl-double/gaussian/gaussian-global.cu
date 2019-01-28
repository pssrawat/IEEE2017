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
  __iter_4__ = FORMA_MAX((__iter_1__+2),2) + (int)(threadIdx.y) ; 
  if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__+2),2) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3)) ){

      float __temp_2__ = (__tilevar_2__[__iter_5__-2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-2-__iter_1__)]);
      float __temp_5__ = (__tilevar_2__[__iter_5__-1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-2-__iter_1__)]);
      float __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
      float __temp_9__ = (__tilevar_2__[__iter_5__-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-2-__iter_1__)]);
      float __temp_10__ = (__temp_6__ + 5 * __temp_9__);
      float __temp_13__ = (__tilevar_2__[__iter_5__+1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-2-__iter_1__)]);
      float __temp_14__ = (__temp_10__ + 4 * __temp_13__);
      float __temp_17__ = (__tilevar_2__[__iter_5__+2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-2-__iter_1__)]);
      float __temp_18__ = (__temp_14__ + 2 * __temp_17__);
      float __temp_21__ = (__tilevar_2__[__iter_5__-2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-1-__iter_1__)]);
      float __temp_22__ = (__temp_18__ + 4 * __temp_21__);
      float __temp_25__ = (__tilevar_2__[__iter_5__-1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-1-__iter_1__)]);
      float __temp_26__ = (__temp_22__ + 9 * __temp_25__);
      float __temp_29__ = (__tilevar_2__[__iter_5__-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-1-__iter_1__)]);
      float __temp_30__ = (__temp_26__ + 12 * __temp_29__);
      float __temp_33__ = (__tilevar_2__[__iter_5__+1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-1-__iter_1__)]);
      float __temp_34__ = (__temp_30__ + 9 * __temp_33__);
      float __temp_37__ = (__tilevar_2__[__iter_5__+2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-1-__iter_1__)]);
      float __temp_38__ = (__temp_34__ + 4 * __temp_37__);
      float __temp_41__ = (__tilevar_2__[__iter_5__-2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-__iter_1__)]);
      float __temp_42__ = (__temp_38__ + 5 * __temp_41__);
      float __temp_45__ = (__tilevar_2__[__iter_5__-1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-__iter_1__)]);
      float __temp_46__ = (__temp_42__ + 12 * __temp_45__);
      float __temp_49__ = (__tilevar_2__[__iter_5__-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-__iter_1__)]);
      float __temp_50__ = (__temp_46__ + 15 * __temp_49__);
      float __temp_53__ = (__tilevar_2__[__iter_5__+1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-__iter_1__)]);
      float __temp_54__ = (__temp_50__ + 12 * __temp_53__);
      float __temp_57__ = (__tilevar_2__[__iter_5__+2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__-__iter_1__)]);
      float __temp_58__ = (__temp_54__ + 5 * __temp_57__);
      float __temp_61__ = (__tilevar_2__[__iter_5__-2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+1-__iter_1__)]);
      float __temp_62__ = (__temp_58__ + 4 * __temp_61__);
      float __temp_65__ = (__tilevar_2__[__iter_5__-1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+1-__iter_1__)]);
      float __temp_66__ = (__temp_62__ + 9 * __temp_65__);
      float __temp_69__ = (__tilevar_2__[__iter_5__-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+1-__iter_1__)]);
      float __temp_70__ = (__temp_66__ + 12 * __temp_69__);
      float __temp_73__ = (__tilevar_2__[__iter_5__+1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+1-__iter_1__)]);
      float __temp_74__ = (__temp_70__ + 9 * __temp_73__);
      float __temp_77__ = (__tilevar_2__[__iter_5__+2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+1-__iter_1__)]);
      float __temp_78__ = (__temp_74__ + 4 * __temp_77__);
      float __temp_81__ = (__tilevar_2__[__iter_5__-2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+2-__iter_1__)]);
      float __temp_82__ = (__temp_78__ + 2 * __temp_81__);
      float __temp_85__ = (__tilevar_2__[__iter_5__-1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+2-__iter_1__)]);
      float __temp_86__ = (__temp_82__ + 4 * __temp_85__);
      float __temp_89__ = (__tilevar_2__[__iter_5__-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+2-__iter_1__)]);
      float __temp_90__ = (__temp_86__ + 5 * __temp_89__);
      float __temp_93__ = (__tilevar_2__[__iter_5__+1-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+2-__iter_1__)]);
      float __temp_94__ = (__temp_90__ + 4 * __temp_93__);
      float __temp_97__ = (__tilevar_2__[__iter_5__+2-__iter_0__+(FORMA_BLOCKDIM_X-0)*(__iter_4__+2-__iter_1__)]);
      float __temp_98__ = (__temp_94__ + 2 * __temp_97__);
      float __temp_99__ = (__temp_98__ / 159);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+2)))] = __temp_99__;
 
      //int __temp_0__;
      //__temp_0__ = __iter_4__+(-2);
      //int __temp_1__;
      //__temp_1__ = __iter_5__+(-2);
      //float __temp_2__;
      //__temp_2__ = (2 * __tilevar_2__[__temp_1__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_0__+(0-(__iter_1__+0)))]);
      //int __temp_3__;
      //__temp_3__ = __iter_4__+(-2);
      //int __temp_4__;
      //__temp_4__ = __iter_5__+(-1);
      //float __temp_5__;
      //__temp_5__ = (4 * __tilevar_2__[__temp_4__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_3__+(0-(__iter_1__+0)))]);
      //float __temp_6__;
      //__temp_6__ = (__temp_2__ + __temp_5__);
      //int __temp_7__;
      //__temp_7__ = __iter_4__+(-2);
      //int __temp_8__;
      //__temp_8__ = __iter_5__;
      //float __temp_9__;
      //__temp_9__ = (5 * __tilevar_2__[__temp_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_7__+(0-(__iter_1__+0)))]);
      //float __temp_10__;
      //__temp_10__ = (__temp_6__ + __temp_9__);
      //int __temp_11__;
      //__temp_11__ = __iter_4__+(-2);
      //int __temp_12__;
      //__temp_12__ = __iter_5__+(1);
      //float __temp_13__;
      //__temp_13__ = (4 * __tilevar_2__[__temp_12__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_11__+(0-(__iter_1__+0)))]);
      //float __temp_14__;
      //__temp_14__ = (__temp_10__ + __temp_13__);
      //int __temp_15__;
      //__temp_15__ = __iter_4__+(-2);
      //int __temp_16__;
      //__temp_16__ = __iter_5__+(2);
      //float __temp_17__;
      //__temp_17__ = (2 * __tilevar_2__[__temp_16__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_15__+(0-(__iter_1__+0)))]);
      //float __temp_18__;
      //__temp_18__ = (__temp_14__ + __temp_17__);
      //int __temp_19__;
      //__temp_19__ = __iter_4__+(-1);
      //int __temp_20__;
      //__temp_20__ = __iter_5__+(-2);
      //float __temp_21__;
      //__temp_21__ = (4 * __tilevar_2__[__temp_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_19__+(0-(__iter_1__+0)))]);
      //float __temp_22__;
      //__temp_22__ = (__temp_18__ + __temp_21__);
      //int __temp_23__;
      //__temp_23__ = __iter_4__+(-1);
      //int __temp_24__;
      //__temp_24__ = __iter_5__+(-1);
      //float __temp_25__;
      //__temp_25__ = (9 * __tilevar_2__[__temp_24__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_23__+(0-(__iter_1__+0)))]);
      //float __temp_26__;
      //__temp_26__ = (__temp_22__ + __temp_25__);
      //int __temp_27__;
      //__temp_27__ = __iter_4__+(-1);
      //int __temp_28__;
      //__temp_28__ = __iter_5__;
      //float __temp_29__;
      //__temp_29__ = (12 * __tilevar_2__[__temp_28__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_27__+(0-(__iter_1__+0)))]);
      //float __temp_30__;
      //__temp_30__ = (__temp_26__ + __temp_29__);
      //int __temp_31__;
      //__temp_31__ = __iter_4__+(-1);
      //int __temp_32__;
      //__temp_32__ = __iter_5__+(1);
      //float __temp_33__;
      //__temp_33__ = (9 * __tilevar_2__[__temp_32__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_31__+(0-(__iter_1__+0)))]);
      //float __temp_34__;
      //__temp_34__ = (__temp_30__ + __temp_33__);
      //int __temp_35__;
      //__temp_35__ = __iter_4__+(-1);
      //int __temp_36__;
      //__temp_36__ = __iter_5__+(2);
      //float __temp_37__;
      //__temp_37__ = (4 * __tilevar_2__[__temp_36__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_35__+(0-(__iter_1__+0)))]);
      //float __temp_38__;
      //__temp_38__ = (__temp_34__ + __temp_37__);
      //int __temp_39__;
      //__temp_39__ = __iter_4__;
      //int __temp_40__;
      //__temp_40__ = __iter_5__+(-2);
      //float __temp_41__;
      //__temp_41__ = (5 * __tilevar_2__[__temp_40__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_39__+(0-(__iter_1__+0)))]);
      //float __temp_42__;
      //__temp_42__ = (__temp_38__ + __temp_41__);
      //int __temp_43__;
      //__temp_43__ = __iter_4__;
      //int __temp_44__;
      //__temp_44__ = __iter_5__+(-1);
      //float __temp_45__;
      //__temp_45__ = (12 * __tilevar_2__[__temp_44__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_43__+(0-(__iter_1__+0)))]);
      //float __temp_46__;
      //__temp_46__ = (__temp_42__ + __temp_45__);
      //int __temp_47__;
      //__temp_47__ = __iter_4__;
      //int __temp_48__;
      //__temp_48__ = __iter_5__;
      //float __temp_49__;
      //__temp_49__ = (15 * __tilevar_2__[__temp_48__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_47__+(0-(__iter_1__+0)))]);
      //float __temp_50__;
      //__temp_50__ = (__temp_46__ + __temp_49__);
      //int __temp_51__;
      //__temp_51__ = __iter_4__;
      //int __temp_52__;
      //__temp_52__ = __iter_5__+(1);
      //float __temp_53__;
      //__temp_53__ = (12 * __tilevar_2__[__temp_52__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_51__+(0-(__iter_1__+0)))]);
      //float __temp_54__;
      //__temp_54__ = (__temp_50__ + __temp_53__);
      //int __temp_55__;
      //__temp_55__ = __iter_4__;
      //int __temp_56__;
      //__temp_56__ = __iter_5__+(2);
      //float __temp_57__;
      //__temp_57__ = (5 * __tilevar_2__[__temp_56__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_55__+(0-(__iter_1__+0)))]);
      //float __temp_58__;
      //__temp_58__ = (__temp_54__ + __temp_57__);
      //int __temp_59__;
      //__temp_59__ = __iter_4__+(1);
      //int __temp_60__;
      //__temp_60__ = __iter_5__+(-2);
      //float __temp_61__;
      //__temp_61__ = (4 * __tilevar_2__[__temp_60__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_59__+(0-(__iter_1__+0)))]);
      //float __temp_62__;
      //__temp_62__ = (__temp_58__ + __temp_61__);
      //int __temp_63__;
      //__temp_63__ = __iter_4__+(1);
      //int __temp_64__;
      //__temp_64__ = __iter_5__+(-1);
      //float __temp_65__;
      //__temp_65__ = (9 * __tilevar_2__[__temp_64__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_63__+(0-(__iter_1__+0)))]);
      //float __temp_66__;
      //__temp_66__ = (__temp_62__ + __temp_65__);
      //int __temp_67__;
      //__temp_67__ = __iter_4__+(1);
      //int __temp_68__;
      //__temp_68__ = __iter_5__;
      //float __temp_69__;
      //__temp_69__ = (12 * __tilevar_2__[__temp_68__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_67__+(0-(__iter_1__+0)))]);
      //float __temp_70__;
      //__temp_70__ = (__temp_66__ + __temp_69__);
      //int __temp_71__;
      //__temp_71__ = __iter_4__+(1);
      //int __temp_72__;
      //__temp_72__ = __iter_5__+(1);
      //float __temp_73__;
      //__temp_73__ = (9 * __tilevar_2__[__temp_72__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_71__+(0-(__iter_1__+0)))]);
      //float __temp_74__;
      //__temp_74__ = (__temp_70__ + __temp_73__);
      //int __temp_75__;
      //__temp_75__ = __iter_4__+(1);
      //int __temp_76__;
      //__temp_76__ = __iter_5__+(2);
      //float __temp_77__;
      //__temp_77__ = (4 * __tilevar_2__[__temp_76__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_75__+(0-(__iter_1__+0)))]);
      //float __temp_78__;
      //__temp_78__ = (__temp_74__ + __temp_77__);
      //int __temp_79__;
      //__temp_79__ = __iter_4__+(2);
      //int __temp_80__;
      //__temp_80__ = __iter_5__+(-2);
      //float __temp_81__;
      //__temp_81__ = (2 * __tilevar_2__[__temp_80__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_79__+(0-(__iter_1__+0)))]);
      //float __temp_82__;
      //__temp_82__ = (__temp_78__ + __temp_81__);
      //int __temp_83__;
      //__temp_83__ = __iter_4__+(2);
      //int __temp_84__;
      //__temp_84__ = __iter_5__+(-1);
      //float __temp_85__;
      //__temp_85__ = (4 * __tilevar_2__[__temp_84__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_83__+(0-(__iter_1__+0)))]);
      //float __temp_86__;
      //__temp_86__ = (__temp_82__ + __temp_85__);
      //int __temp_87__;
      //__temp_87__ = __iter_4__+(2);
      //int __temp_88__;
      //__temp_88__ = __iter_5__;
      //float __temp_89__;
      //__temp_89__ = (5 * __tilevar_2__[__temp_88__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_87__+(0-(__iter_1__+0)))]);
      //float __temp_90__;
      //__temp_90__ = (__temp_86__ + __temp_89__);
      //int __temp_91__;
      //__temp_91__ = __iter_4__+(2);
      //int __temp_92__;
      //__temp_92__ = __iter_5__+(1);
      //float __temp_93__;
      //__temp_93__ = (4 * __tilevar_2__[__temp_92__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_91__+(0-(__iter_1__+0)))]);
      //float __temp_94__;
      //__temp_94__ = (__temp_90__ + __temp_93__);
      //int __temp_95__;
      //__temp_95__ = __iter_4__+(2);
      //int __temp_96__;
      //__temp_96__ = __iter_5__+(2);
      //float __temp_97__;
      //__temp_97__ = (2 * __tilevar_2__[__temp_96__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__temp_95__+(0-(__iter_1__+0)))]);
      //float __temp_98__;
      //__temp_98__ = (__temp_94__ + __temp_97__);
      //float __temp_99__;
      //__temp_99__ = (__temp_98__ / 159);
      //__tilevar_3__[__iter_5__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+2)))] = __temp_99__;
    }
  }
  int __iter_6__;
  __iter_6__ = FORMA_MAX((__iter_1__+2),2) + (int)(threadIdx.y) ; 
  if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
    int __iter_7__;
    __iter_7__ = FORMA_MAX((__iter_0__+2),2) + (int)(threadIdx.x) ; 
    if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3)) ){
      if (__iter_6__ < (FORMA_MAX((__iter_1__+2),2)+4) || __iter_6__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3))-4) || __iter_7__ < (FORMA_MAX((__iter_0__+2),2)+4) || __iter_7__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3))-4)) {
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+2)))];
      }
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX((__iter_1__+4),2) + (int)(threadIdx.y) ; 
  if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-3)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__+4),2) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3)) ){
      int __temp_150__;
      __temp_150__ = __iter_10__+(-2);
      int __temp_151__;
      __temp_151__ = __iter_11__+(-2);
      float __temp_152__;
      __temp_152__ = (2 * __tilevar_3__[__temp_151__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_150__+(0-(__iter_1__+2)))]);
      int __temp_153__;
      __temp_153__ = __iter_10__+(-2);
      int __temp_154__;
      __temp_154__ = __iter_11__+(-1);
      float __temp_155__;
      __temp_155__ = (4 * __tilevar_3__[__temp_154__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_153__+(0-(__iter_1__+2)))]);
      float __temp_156__;
      __temp_156__ = (__temp_152__ + __temp_155__);
      int __temp_157__;
      __temp_157__ = __iter_10__+(-2);
      int __temp_158__;
      __temp_158__ = __iter_11__;
      float __temp_159__;
      __temp_159__ = (5 * __tilevar_3__[__temp_158__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_157__+(0-(__iter_1__+2)))]);
      float __temp_160__;
      __temp_160__ = (__temp_156__ + __temp_159__);
      int __temp_161__;
      __temp_161__ = __iter_10__+(-2);
      int __temp_162__;
      __temp_162__ = __iter_11__+(1);
      float __temp_163__;
      __temp_163__ = (4 * __tilevar_3__[__temp_162__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_161__+(0-(__iter_1__+2)))]);
      float __temp_164__;
      __temp_164__ = (__temp_160__ + __temp_163__);
      int __temp_165__;
      __temp_165__ = __iter_10__+(-2);
      int __temp_166__;
      __temp_166__ = __iter_11__+(2);
      float __temp_167__;
      __temp_167__ = (2 * __tilevar_3__[__temp_166__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_165__+(0-(__iter_1__+2)))]);
      float __temp_168__;
      __temp_168__ = (__temp_164__ + __temp_167__);
      int __temp_169__;
      __temp_169__ = __iter_10__+(-1);
      int __temp_170__;
      __temp_170__ = __iter_11__+(-2);
      float __temp_171__;
      __temp_171__ = (4 * __tilevar_3__[__temp_170__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_169__+(0-(__iter_1__+2)))]);
      float __temp_172__;
      __temp_172__ = (__temp_168__ + __temp_171__);
      int __temp_173__;
      __temp_173__ = __iter_10__+(-1);
      int __temp_174__;
      __temp_174__ = __iter_11__+(-1);
      float __temp_175__;
      __temp_175__ = (9 * __tilevar_3__[__temp_174__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_173__+(0-(__iter_1__+2)))]);
      float __temp_176__;
      __temp_176__ = (__temp_172__ + __temp_175__);
      int __temp_177__;
      __temp_177__ = __iter_10__+(-1);
      int __temp_178__;
      __temp_178__ = __iter_11__;
      float __temp_179__;
      __temp_179__ = (12 * __tilevar_3__[__temp_178__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_177__+(0-(__iter_1__+2)))]);
      float __temp_180__;
      __temp_180__ = (__temp_176__ + __temp_179__);
      int __temp_181__;
      __temp_181__ = __iter_10__+(-1);
      int __temp_182__;
      __temp_182__ = __iter_11__+(1);
      float __temp_183__;
      __temp_183__ = (9 * __tilevar_3__[__temp_182__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_181__+(0-(__iter_1__+2)))]);
      float __temp_184__;
      __temp_184__ = (__temp_180__ + __temp_183__);
      int __temp_185__;
      __temp_185__ = __iter_10__+(-1);
      int __temp_186__;
      __temp_186__ = __iter_11__+(2);
      float __temp_187__;
      __temp_187__ = (4 * __tilevar_3__[__temp_186__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_185__+(0-(__iter_1__+2)))]);
      float __temp_188__;
      __temp_188__ = (__temp_184__ + __temp_187__);
      int __temp_189__;
      __temp_189__ = __iter_10__;
      int __temp_190__;
      __temp_190__ = __iter_11__+(-2);
      float __temp_191__;
      __temp_191__ = (5 * __tilevar_3__[__temp_190__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_189__+(0-(__iter_1__+2)))]);
      float __temp_192__;
      __temp_192__ = (__temp_188__ + __temp_191__);
      int __temp_193__;
      __temp_193__ = __iter_10__;
      int __temp_194__;
      __temp_194__ = __iter_11__+(-1);
      float __temp_195__;
      __temp_195__ = (12 * __tilevar_3__[__temp_194__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_193__+(0-(__iter_1__+2)))]);
      float __temp_196__;
      __temp_196__ = (__temp_192__ + __temp_195__);
      int __temp_197__;
      __temp_197__ = __iter_10__;
      int __temp_198__;
      __temp_198__ = __iter_11__;
      float __temp_199__;
      __temp_199__ = (15 * __tilevar_3__[__temp_198__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_197__+(0-(__iter_1__+2)))]);
      float __temp_200__;
      __temp_200__ = (__temp_196__ + __temp_199__);
      int __temp_201__;
      __temp_201__ = __iter_10__;
      int __temp_202__;
      __temp_202__ = __iter_11__+(1);
      float __temp_203__;
      __temp_203__ = (12 * __tilevar_3__[__temp_202__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_201__+(0-(__iter_1__+2)))]);
      float __temp_204__;
      __temp_204__ = (__temp_200__ + __temp_203__);
      int __temp_205__;
      __temp_205__ = __iter_10__;
      int __temp_206__;
      __temp_206__ = __iter_11__+(2);
      float __temp_207__;
      __temp_207__ = (5 * __tilevar_3__[__temp_206__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_205__+(0-(__iter_1__+2)))]);
      float __temp_208__;
      __temp_208__ = (__temp_204__ + __temp_207__);
      int __temp_209__;
      __temp_209__ = __iter_10__+(1);
      int __temp_210__;
      __temp_210__ = __iter_11__+(-2);
      float __temp_211__;
      __temp_211__ = (4 * __tilevar_3__[__temp_210__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_209__+(0-(__iter_1__+2)))]);
      float __temp_212__;
      __temp_212__ = (__temp_208__ + __temp_211__);
      int __temp_213__;
      __temp_213__ = __iter_10__+(1);
      int __temp_214__;
      __temp_214__ = __iter_11__+(-1);
      float __temp_215__;
      __temp_215__ = (9 * __tilevar_3__[__temp_214__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_213__+(0-(__iter_1__+2)))]);
      float __temp_216__;
      __temp_216__ = (__temp_212__ + __temp_215__);
      int __temp_217__;
      __temp_217__ = __iter_10__+(1);
      int __temp_218__;
      __temp_218__ = __iter_11__;
      float __temp_219__;
      __temp_219__ = (12 * __tilevar_3__[__temp_218__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_217__+(0-(__iter_1__+2)))]);
      float __temp_220__;
      __temp_220__ = (__temp_216__ + __temp_219__);
      int __temp_221__;
      __temp_221__ = __iter_10__+(1);
      int __temp_222__;
      __temp_222__ = __iter_11__+(1);
      float __temp_223__;
      __temp_223__ = (9 * __tilevar_3__[__temp_222__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_221__+(0-(__iter_1__+2)))]);
      float __temp_224__;
      __temp_224__ = (__temp_220__ + __temp_223__);
      int __temp_225__;
      __temp_225__ = __iter_10__+(1);
      int __temp_226__;
      __temp_226__ = __iter_11__+(2);
      float __temp_227__;
      __temp_227__ = (4 * __tilevar_3__[__temp_226__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_225__+(0-(__iter_1__+2)))]);
      float __temp_228__;
      __temp_228__ = (__temp_224__ + __temp_227__);
      int __temp_229__;
      __temp_229__ = __iter_10__+(2);
      int __temp_230__;
      __temp_230__ = __iter_11__+(-2);
      float __temp_231__;
      __temp_231__ = (2 * __tilevar_3__[__temp_230__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_229__+(0-(__iter_1__+2)))]);
      float __temp_232__;
      __temp_232__ = (__temp_228__ + __temp_231__);
      int __temp_233__;
      __temp_233__ = __iter_10__+(2);
      int __temp_234__;
      __temp_234__ = __iter_11__+(-1);
      float __temp_235__;
      __temp_235__ = (4 * __tilevar_3__[__temp_234__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_233__+(0-(__iter_1__+2)))]);
      float __temp_236__;
      __temp_236__ = (__temp_232__ + __temp_235__);
      int __temp_237__;
      __temp_237__ = __iter_10__+(2);
      int __temp_238__;
      __temp_238__ = __iter_11__;
      float __temp_239__;
      __temp_239__ = (5 * __tilevar_3__[__temp_238__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_237__+(0-(__iter_1__+2)))]);
      float __temp_240__;
      __temp_240__ = (__temp_236__ + __temp_239__);
      int __temp_241__;
      __temp_241__ = __iter_10__+(2);
      int __temp_242__;
      __temp_242__ = __iter_11__+(1);
      float __temp_243__;
      __temp_243__ = (4 * __tilevar_3__[__temp_242__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_241__+(0-(__iter_1__+2)))]);
      float __temp_244__;
      __temp_244__ = (__temp_240__ + __temp_243__);
      int __temp_245__;
      __temp_245__ = __iter_10__+(2);
      int __temp_246__;
      __temp_246__ = __iter_11__+(2);
      float __temp_247__;
      __temp_247__ = (2 * __tilevar_3__[__temp_246__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__temp_245__+(0-(__iter_1__+2)))]);
      float __temp_248__;
      __temp_248__ = (__temp_244__ + __temp_247__);
      float __temp_249__;
      __temp_249__ = (__temp_248__ / 159);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+4)))] = __temp_249__;
    }
  }
  int __iter_12__;
  __iter_12__ = FORMA_MAX((__iter_1__+4),2) + (int)(threadIdx.y) ; 
  if( __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-3)) ){
    int __iter_13__;
    __iter_13__ = FORMA_MAX((__iter_0__+4),2) + (int)(threadIdx.x) ; 
    if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3)) ){
      if (__iter_12__ < (FORMA_MAX((__iter_1__+4),2)+4) || __iter_12__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-3))-4) || __iter_13__ < (FORMA_MAX((__iter_0__+4),2)+4) || __iter_13__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3))-4)) {
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+4)))];
      }
    }
  }
  __syncthreads();
  int __iter_16__;
  __iter_16__ = FORMA_MAX((__iter_1__+6),2) + (int)(threadIdx.y) ; 
  if( __iter_16__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-7),(N-3)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__+6),2) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-7),(M-3)) ){
      float __temp_300__;
      __temp_300__ = (2 * __tilevar_4__[__iter_17__+(-2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-2)+(0-(__iter_1__+4)))]);
      float __temp_301__;
      __temp_301__ = (4 * __tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-2)+(0-(__iter_1__+4)))]);
      float __temp_302__;
      __temp_302__ = (__temp_300__ + __temp_301__);
      float __temp_303__;
      __temp_303__ = (5 * __tilevar_4__[__iter_17__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-2)+(0-(__iter_1__+4)))]);
      float __temp_304__;
      __temp_304__ = (__temp_302__ + __temp_303__);
      float __temp_305__;
      __temp_305__ = (4 * __tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-2)+(0-(__iter_1__+4)))]);
      float __temp_306__;
      __temp_306__ = (__temp_304__ + __temp_305__);
      float __temp_307__;
      __temp_307__ = (2 * __tilevar_4__[__iter_17__+(2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-2)+(0-(__iter_1__+4)))]);
      float __temp_308__;
      __temp_308__ = (__temp_306__ + __temp_307__);
      float __temp_309__;
      __temp_309__ = (4 * __tilevar_4__[__iter_17__+(-2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+4)))]);
      float __temp_310__;
      __temp_310__ = (__temp_308__ + __temp_309__);
      float __temp_311__;
      __temp_311__ = (9 * __tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+4)))]);
      float __temp_312__;
      __temp_312__ = (__temp_310__ + __temp_311__);
      float __temp_313__;
      __temp_313__ = (12 * __tilevar_4__[__iter_17__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+4)))]);
      float __temp_314__;
      __temp_314__ = (__temp_312__ + __temp_313__);
      float __temp_315__;
      __temp_315__ = (9 * __tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+4)))]);
      float __temp_316__;
      __temp_316__ = (__temp_314__ + __temp_315__);
      float __temp_317__;
      __temp_317__ = (4 * __tilevar_4__[__iter_17__+(2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+4)))]);
      float __temp_318__;
      __temp_318__ = (__temp_316__ + __temp_317__);
      float __temp_319__;
      __temp_319__ = (5 * __tilevar_4__[__iter_17__+(-2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+4)))]);
      float __temp_320__;
      __temp_320__ = (__temp_318__ + __temp_319__);
      float __temp_321__;
      __temp_321__ = (12 * __tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+4)))]);
      float __temp_322__;
      __temp_322__ = (__temp_320__ + __temp_321__);
      float __temp_323__;
      __temp_323__ = (15 * __tilevar_4__[__iter_17__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+4)))]);
      float __temp_324__;
      __temp_324__ = (__temp_322__ + __temp_323__);
      float __temp_325__;
      __temp_325__ = (12 * __tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+4)))]);
      float __temp_326__;
      __temp_326__ = (__temp_324__ + __temp_325__);
      float __temp_327__;
      __temp_327__ = (5 * __tilevar_4__[__iter_17__+(2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+4)))]);
      float __temp_328__;
      __temp_328__ = (__temp_326__ + __temp_327__);
      float __temp_329__;
      __temp_329__ = (4 * __tilevar_4__[__iter_17__+(-2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+4)))]);
      float __temp_330__;
      __temp_330__ = (__temp_328__ + __temp_329__);
      float __temp_331__;
      __temp_331__ = (9 * __tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+4)))]);
      float __temp_332__;
      __temp_332__ = (__temp_330__ + __temp_331__);
      float __temp_333__;
      __temp_333__ = (12 * __tilevar_4__[__iter_17__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+4)))]);
      float __temp_334__;
      __temp_334__ = (__temp_332__ + __temp_333__);
      float __temp_335__;
      __temp_335__ = (9 * __tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+4)))]);
      float __temp_336__;
      __temp_336__ = (__temp_334__ + __temp_335__);
      float __temp_337__;
      __temp_337__ = (4 * __tilevar_4__[__iter_17__+(2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+4)))]);
      float __temp_338__;
      __temp_338__ = (__temp_336__ + __temp_337__);
      float __temp_339__;
      __temp_339__ = (2 * __tilevar_4__[__iter_17__+(-2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+4)))]);
      float __temp_340__;
      __temp_340__ = (__temp_338__ + __temp_339__);
      float __temp_341__;
      __temp_341__ = (4 * __tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+4)))]);
      float __temp_342__;
      __temp_342__ = (__temp_340__ + __temp_341__);
      float __temp_343__;
      __temp_343__ = (5 * __tilevar_4__[__iter_17__+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+4)))]);
      float __temp_344__;
      __temp_344__ = (__temp_342__ + __temp_343__);
      float __temp_345__;
      __temp_345__ = (4 * __tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+4)))]);
      float __temp_346__;
      __temp_346__ = (__temp_344__ + __temp_345__);
      float __temp_347__;
      __temp_347__ = (2 * __tilevar_4__[__iter_17__+(2)+(0-(__iter_0__+4))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+4)))]);
      float __temp_348__;
      __temp_348__ = (__temp_346__ + __temp_347__);
      float __temp_349__;
      __temp_349__ = (__temp_348__ / 159);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+6)))] = __temp_349__;
    }
  }
  int __iter_18__;
  __iter_18__ = FORMA_MAX((__iter_1__+6),2) + (int)(threadIdx.y) ; 
  if( __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-7),(N-3)) ){
    int __iter_19__;
    __iter_19__ = FORMA_MAX((__iter_0__+6),2) + (int)(threadIdx.x) ; 
    if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-7),(M-3)) ){
      if (__iter_18__ < (FORMA_MAX((__iter_1__+6),2)+4) || __iter_18__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-7),(N-3))-4) || __iter_19__ < (FORMA_MAX((__iter_0__+6),2)+4) || __iter_19__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-7),(M-3))-4)) {
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+6)))];
      }
    }
  }
  __syncthreads();
  int __iter_22__;
  __iter_22__ = FORMA_MAX((__iter_1__+8),2) + (int)(threadIdx.y) ; 
  if( __iter_22__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-9),(N-3)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__+8),2) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-9),(M-3)) ){
      float __temp_400__;
      __temp_400__ = (2 * __tilevar_5__[__iter_23__+(-2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-2)+(0-(__iter_1__+6)))]);
      float __temp_401__;
      __temp_401__ = (4 * __tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-2)+(0-(__iter_1__+6)))]);
      float __temp_402__;
      __temp_402__ = (__temp_400__ + __temp_401__);
      float __temp_403__;
      __temp_403__ = (5 * __tilevar_5__[__iter_23__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-2)+(0-(__iter_1__+6)))]);
      float __temp_404__;
      __temp_404__ = (__temp_402__ + __temp_403__);
      float __temp_405__;
      __temp_405__ = (4 * __tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-2)+(0-(__iter_1__+6)))]);
      float __temp_406__;
      __temp_406__ = (__temp_404__ + __temp_405__);
      float __temp_407__;
      __temp_407__ = (2 * __tilevar_5__[__iter_23__+(2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-2)+(0-(__iter_1__+6)))]);
      float __temp_408__;
      __temp_408__ = (__temp_406__ + __temp_407__);
      float __temp_409__;
      __temp_409__ = (4 * __tilevar_5__[__iter_23__+(-2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+6)))]);
      float __temp_410__;
      __temp_410__ = (__temp_408__ + __temp_409__);
      float __temp_411__;
      __temp_411__ = (9 * __tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+6)))]);
      float __temp_412__;
      __temp_412__ = (__temp_410__ + __temp_411__);
      float __temp_413__;
      __temp_413__ = (12 * __tilevar_5__[__iter_23__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+6)))]);
      float __temp_414__;
      __temp_414__ = (__temp_412__ + __temp_413__);
      float __temp_415__;
      __temp_415__ = (9 * __tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+6)))]);
      float __temp_416__;
      __temp_416__ = (__temp_414__ + __temp_415__);
      float __temp_417__;
      __temp_417__ = (4 * __tilevar_5__[__iter_23__+(2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+6)))]);
      float __temp_418__;
      __temp_418__ = (__temp_416__ + __temp_417__);
      float __temp_419__;
      __temp_419__ = (5 * __tilevar_5__[__iter_23__+(-2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+6)))]);
      float __temp_420__;
      __temp_420__ = (__temp_418__ + __temp_419__);
      float __temp_421__;
      __temp_421__ = (12 * __tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+6)))]);
      float __temp_422__;
      __temp_422__ = (__temp_420__ + __temp_421__);
      float __temp_423__;
      __temp_423__ = (15 * __tilevar_5__[__iter_23__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+6)))]);
      float __temp_424__;
      __temp_424__ = (__temp_422__ + __temp_423__);
      float __temp_425__;
      __temp_425__ = (12 * __tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+6)))]);
      float __temp_426__;
      __temp_426__ = (__temp_424__ + __temp_425__);
      float __temp_427__;
      __temp_427__ = (5 * __tilevar_5__[__iter_23__+(2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+6)))]);
      float __temp_428__;
      __temp_428__ = (__temp_426__ + __temp_427__);
      float __temp_429__;
      __temp_429__ = (4 * __tilevar_5__[__iter_23__+(-2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+6)))]);
      float __temp_430__;
      __temp_430__ = (__temp_428__ + __temp_429__);
      float __temp_431__;
      __temp_431__ = (9 * __tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+6)))]);
      float __temp_432__;
      __temp_432__ = (__temp_430__ + __temp_431__);
      float __temp_433__;
      __temp_433__ = (12 * __tilevar_5__[__iter_23__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+6)))]);
      float __temp_434__;
      __temp_434__ = (__temp_432__ + __temp_433__);
      float __temp_435__;
      __temp_435__ = (9 * __tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+6)))]);
      float __temp_436__;
      __temp_436__ = (__temp_434__ + __temp_435__);
      float __temp_437__;
      __temp_437__ = (4 * __tilevar_5__[__iter_23__+(2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+6)))]);
      float __temp_438__;
      __temp_438__ = (__temp_436__ + __temp_437__);
      float __temp_439__;
      __temp_439__ = (2 * __tilevar_5__[__iter_23__+(-2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+6)))]);
      float __temp_440__;
      __temp_440__ = (__temp_438__ + __temp_439__);
      float __temp_441__;
      __temp_441__ = (4 * __tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+6)))]);
      float __temp_442__;
      __temp_442__ = (__temp_440__ + __temp_441__);
      float __temp_443__;
      __temp_443__ = (5 * __tilevar_5__[__iter_23__+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+6)))]);
      float __temp_444__;
      __temp_444__ = (__temp_442__ + __temp_443__);
      float __temp_445__;
      __temp_445__ = (4 * __tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+6)))]);
      float __temp_446__;
      __temp_446__ = (__temp_444__ + __temp_445__);
      float __temp_447__;
      __temp_447__ = (2 * __tilevar_5__[__iter_23__+(2)+(0-(__iter_0__+6))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+6)))]);
      float __temp_448__;
      __temp_448__ = (__temp_446__ + __temp_447__);
      float __temp_449__;
      __temp_449__ = (__temp_448__ / 159);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_449__;
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
  __iter_8__ = FORMA_MAX(__iter_1__,2) + (int)(threadIdx.y) ; 
  for( ; __iter_8__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3)) ; __iter_8__ += (int)(blockDim.y) ){
    int __iter_9__;
    __iter_9__ = FORMA_MAX(__iter_0__,2) + (int)(threadIdx.x) ; 
    if( __iter_9__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      if (__iter_8__ < FORMA_MAX((__iter_1__+2),2) || __iter_8__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) || __iter_9__ < FORMA_MAX((__iter_0__+2),2) || __iter_9__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3))) {
        float __temp_100__;
        __temp_100__ = (2 * input[__iter_9__+(-2)+(M-0)*(__iter_8__+(-2))]);
        float __temp_101__;
        __temp_101__ = (4 * input[__iter_9__+(-1)+(M-0)*(__iter_8__+(-2))]);
        float __temp_102__;
        __temp_102__ = (__temp_100__ + __temp_101__);
        float __temp_103__;
        __temp_103__ = (5 * input[__iter_9__+(M-0)*(__iter_8__+(-2))]);
        float __temp_104__;
        __temp_104__ = (__temp_102__ + __temp_103__);
        float __temp_105__;
        __temp_105__ = (4 * input[__iter_9__+(1)+(M-0)*(__iter_8__+(-2))]);
        float __temp_106__;
        __temp_106__ = (__temp_104__ + __temp_105__);
        float __temp_107__;
        __temp_107__ = (2 * input[__iter_9__+(2)+(M-0)*(__iter_8__+(-2))]);
        float __temp_108__;
        __temp_108__ = (__temp_106__ + __temp_107__);
        float __temp_109__;
        __temp_109__ = (4 * input[__iter_9__+(-2)+(M-0)*(__iter_8__+(-1))]);
        float __temp_110__;
        __temp_110__ = (__temp_108__ + __temp_109__);
        float __temp_111__;
        __temp_111__ = (9 * input[__iter_9__+(-1)+(M-0)*(__iter_8__+(-1))]);
        float __temp_112__;
        __temp_112__ = (__temp_110__ + __temp_111__);
        float __temp_113__;
        __temp_113__ = (12 * input[__iter_9__+(M-0)*(__iter_8__+(-1))]);
        float __temp_114__;
        __temp_114__ = (__temp_112__ + __temp_113__);
        float __temp_115__;
        __temp_115__ = (9 * input[__iter_9__+(1)+(M-0)*(__iter_8__+(-1))]);
        float __temp_116__;
        __temp_116__ = (__temp_114__ + __temp_115__);
        float __temp_117__;
        __temp_117__ = (4 * input[__iter_9__+(2)+(M-0)*(__iter_8__+(-1))]);
        float __temp_118__;
        __temp_118__ = (__temp_116__ + __temp_117__);
        float __temp_119__;
        __temp_119__ = (5 * input[__iter_9__+(-2)+(M-0)*(__iter_8__)]);
        float __temp_120__;
        __temp_120__ = (__temp_118__ + __temp_119__);
        float __temp_121__;
        __temp_121__ = (12 * input[__iter_9__+(-1)+(M-0)*(__iter_8__)]);
        float __temp_122__;
        __temp_122__ = (__temp_120__ + __temp_121__);
        float __temp_123__;
        __temp_123__ = (15 * input[__iter_9__+(M-0)*(__iter_8__)]);
        float __temp_124__;
        __temp_124__ = (__temp_122__ + __temp_123__);
        float __temp_125__;
        __temp_125__ = (12 * input[__iter_9__+(1)+(M-0)*(__iter_8__)]);
        float __temp_126__;
        __temp_126__ = (__temp_124__ + __temp_125__);
        float __temp_127__;
        __temp_127__ = (5 * input[__iter_9__+(2)+(M-0)*(__iter_8__)]);
        float __temp_128__;
        __temp_128__ = (__temp_126__ + __temp_127__);
        float __temp_129__;
        __temp_129__ = (4 * input[__iter_9__+(-2)+(M-0)*(__iter_8__+(1))]);
        float __temp_130__;
        __temp_130__ = (__temp_128__ + __temp_129__);
        float __temp_131__;
        __temp_131__ = (9 * input[__iter_9__+(-1)+(M-0)*(__iter_8__+(1))]);
        float __temp_132__;
        __temp_132__ = (__temp_130__ + __temp_131__);
        float __temp_133__;
        __temp_133__ = (12 * input[__iter_9__+(M-0)*(__iter_8__+(1))]);
        float __temp_134__;
        __temp_134__ = (__temp_132__ + __temp_133__);
        float __temp_135__;
        __temp_135__ = (9 * input[__iter_9__+(1)+(M-0)*(__iter_8__+(1))]);
        float __temp_136__;
        __temp_136__ = (__temp_134__ + __temp_135__);
        float __temp_137__;
        __temp_137__ = (4 * input[__iter_9__+(2)+(M-0)*(__iter_8__+(1))]);
        float __temp_138__;
        __temp_138__ = (__temp_136__ + __temp_137__);
        float __temp_139__;
        __temp_139__ = (2 * input[__iter_9__+(-2)+(M-0)*(__iter_8__+(2))]);
        float __temp_140__;
        __temp_140__ = (__temp_138__ + __temp_139__);
        float __temp_141__;
        __temp_141__ = (4 * input[__iter_9__+(-1)+(M-0)*(__iter_8__+(2))]);
        float __temp_142__;
        __temp_142__ = (__temp_140__ + __temp_141__);
        float __temp_143__;
        __temp_143__ = (5 * input[__iter_9__+(M-0)*(__iter_8__+(2))]);
        float __temp_144__;
        __temp_144__ = (__temp_142__ + __temp_143__);
        float __temp_145__;
        __temp_145__ = (4 * input[__iter_9__+(1)+(M-0)*(__iter_8__+(2))]);
        float __temp_146__;
        __temp_146__ = (__temp_144__ + __temp_145__);
        float __temp_147__;
        __temp_147__ = (2 * input[__iter_9__+(2)+(M-0)*(__iter_8__+(2))]);
        float __temp_148__;
        __temp_148__ = (__temp_146__ + __temp_147__);
        float __temp_149__;
        __temp_149__ = (__temp_148__ / 159);
        __copy_arr_0__[__iter_9__+(M-0)*(__iter_8__)] = __temp_149__;
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
  __iter_14__ = FORMA_MAX(__iter_1__,2) + (int)(threadIdx.y) ; 
  for( ; __iter_14__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3)) ; __iter_14__ += (int)(blockDim.y) ){
    int __iter_15__;
    __iter_15__ = FORMA_MAX(__iter_0__,2) + (int)(threadIdx.x) ; 
    if( __iter_15__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      if (__iter_14__ < FORMA_MAX((__iter_1__+4),2) || __iter_14__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-3)) || __iter_15__ < FORMA_MAX((__iter_0__+4),2) || __iter_15__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3))) {
        float __temp_250__;
        __temp_250__ = (2 * __copy_arr_0__[__iter_15__+(-2)+(M-0)*(__iter_14__+(-2))]);
        float __temp_251__;
        __temp_251__ = (4 * __copy_arr_0__[__iter_15__+(-1)+(M-0)*(__iter_14__+(-2))]);
        float __temp_252__;
        __temp_252__ = (__temp_250__ + __temp_251__);
        float __temp_253__;
        __temp_253__ = (5 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__+(-2))]);
        float __temp_254__;
        __temp_254__ = (__temp_252__ + __temp_253__);
        float __temp_255__;
        __temp_255__ = (4 * __copy_arr_0__[__iter_15__+(1)+(M-0)*(__iter_14__+(-2))]);
        float __temp_256__;
        __temp_256__ = (__temp_254__ + __temp_255__);
        float __temp_257__;
        __temp_257__ = (2 * __copy_arr_0__[__iter_15__+(2)+(M-0)*(__iter_14__+(-2))]);
        float __temp_258__;
        __temp_258__ = (__temp_256__ + __temp_257__);
        float __temp_259__;
        __temp_259__ = (4 * __copy_arr_0__[__iter_15__+(-2)+(M-0)*(__iter_14__+(-1))]);
        float __temp_260__;
        __temp_260__ = (__temp_258__ + __temp_259__);
        float __temp_261__;
        __temp_261__ = (9 * __copy_arr_0__[__iter_15__+(-1)+(M-0)*(__iter_14__+(-1))]);
        float __temp_262__;
        __temp_262__ = (__temp_260__ + __temp_261__);
        float __temp_263__;
        __temp_263__ = (12 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__+(-1))]);
        float __temp_264__;
        __temp_264__ = (__temp_262__ + __temp_263__);
        float __temp_265__;
        __temp_265__ = (9 * __copy_arr_0__[__iter_15__+(1)+(M-0)*(__iter_14__+(-1))]);
        float __temp_266__;
        __temp_266__ = (__temp_264__ + __temp_265__);
        float __temp_267__;
        __temp_267__ = (4 * __copy_arr_0__[__iter_15__+(2)+(M-0)*(__iter_14__+(-1))]);
        float __temp_268__;
        __temp_268__ = (__temp_266__ + __temp_267__);
        float __temp_269__;
        __temp_269__ = (5 * __copy_arr_0__[__iter_15__+(-2)+(M-0)*(__iter_14__)]);
        float __temp_270__;
        __temp_270__ = (__temp_268__ + __temp_269__);
        float __temp_271__;
        __temp_271__ = (12 * __copy_arr_0__[__iter_15__+(-1)+(M-0)*(__iter_14__)]);
        float __temp_272__;
        __temp_272__ = (__temp_270__ + __temp_271__);
        float __temp_273__;
        __temp_273__ = (15 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__)]);
        float __temp_274__;
        __temp_274__ = (__temp_272__ + __temp_273__);
        float __temp_275__;
        __temp_275__ = (12 * __copy_arr_0__[__iter_15__+(1)+(M-0)*(__iter_14__)]);
        float __temp_276__;
        __temp_276__ = (__temp_274__ + __temp_275__);
        float __temp_277__;
        __temp_277__ = (5 * __copy_arr_0__[__iter_15__+(2)+(M-0)*(__iter_14__)]);
        float __temp_278__;
        __temp_278__ = (__temp_276__ + __temp_277__);
        float __temp_279__;
        __temp_279__ = (4 * __copy_arr_0__[__iter_15__+(-2)+(M-0)*(__iter_14__+(1))]);
        float __temp_280__;
        __temp_280__ = (__temp_278__ + __temp_279__);
        float __temp_281__;
        __temp_281__ = (9 * __copy_arr_0__[__iter_15__+(-1)+(M-0)*(__iter_14__+(1))]);
        float __temp_282__;
        __temp_282__ = (__temp_280__ + __temp_281__);
        float __temp_283__;
        __temp_283__ = (12 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__+(1))]);
        float __temp_284__;
        __temp_284__ = (__temp_282__ + __temp_283__);
        float __temp_285__;
        __temp_285__ = (9 * __copy_arr_0__[__iter_15__+(1)+(M-0)*(__iter_14__+(1))]);
        float __temp_286__;
        __temp_286__ = (__temp_284__ + __temp_285__);
        float __temp_287__;
        __temp_287__ = (4 * __copy_arr_0__[__iter_15__+(2)+(M-0)*(__iter_14__+(1))]);
        float __temp_288__;
        __temp_288__ = (__temp_286__ + __temp_287__);
        float __temp_289__;
        __temp_289__ = (2 * __copy_arr_0__[__iter_15__+(-2)+(M-0)*(__iter_14__+(2))]);
        float __temp_290__;
        __temp_290__ = (__temp_288__ + __temp_289__);
        float __temp_291__;
        __temp_291__ = (4 * __copy_arr_0__[__iter_15__+(-1)+(M-0)*(__iter_14__+(2))]);
        float __temp_292__;
        __temp_292__ = (__temp_290__ + __temp_291__);
        float __temp_293__;
        __temp_293__ = (5 * __copy_arr_0__[__iter_15__+(M-0)*(__iter_14__+(2))]);
        float __temp_294__;
        __temp_294__ = (__temp_292__ + __temp_293__);
        float __temp_295__;
        __temp_295__ = (4 * __copy_arr_0__[__iter_15__+(1)+(M-0)*(__iter_14__+(2))]);
        float __temp_296__;
        __temp_296__ = (__temp_294__ + __temp_295__);
        float __temp_297__;
        __temp_297__ = (2 * __copy_arr_0__[__iter_15__+(2)+(M-0)*(__iter_14__+(2))]);
        float __temp_298__;
        __temp_298__ = (__temp_296__ + __temp_297__);
        float __temp_299__;
        __temp_299__ = (__temp_298__ / 159);
        __copy_arr_1__[__iter_15__+(M-0)*(__iter_14__)] = __temp_299__;
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
  __iter_20__ = FORMA_MAX(__iter_1__,2) + (int)(threadIdx.y) ; 
  for( ; __iter_20__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3)) ; __iter_20__ += (int)(blockDim.y) ){
    int __iter_21__;
    __iter_21__ = FORMA_MAX(__iter_0__,2) + (int)(threadIdx.x) ; 
    if( __iter_21__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      if (__iter_20__ < FORMA_MAX((__iter_1__+6),2) || __iter_20__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-7),(N-3)) || __iter_21__ < FORMA_MAX((__iter_0__+6),2) || __iter_21__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-7),(M-3))) {
        float __temp_350__;
        __temp_350__ = (2 * __copy_arr_1__[__iter_21__+(-2)+(M-0)*(__iter_20__+(-2))]);
        float __temp_351__;
        __temp_351__ = (4 * __copy_arr_1__[__iter_21__+(-1)+(M-0)*(__iter_20__+(-2))]);
        float __temp_352__;
        __temp_352__ = (__temp_350__ + __temp_351__);
        float __temp_353__;
        __temp_353__ = (5 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__+(-2))]);
        float __temp_354__;
        __temp_354__ = (__temp_352__ + __temp_353__);
        float __temp_355__;
        __temp_355__ = (4 * __copy_arr_1__[__iter_21__+(1)+(M-0)*(__iter_20__+(-2))]);
        float __temp_356__;
        __temp_356__ = (__temp_354__ + __temp_355__);
        float __temp_357__;
        __temp_357__ = (2 * __copy_arr_1__[__iter_21__+(2)+(M-0)*(__iter_20__+(-2))]);
        float __temp_358__;
        __temp_358__ = (__temp_356__ + __temp_357__);
        float __temp_359__;
        __temp_359__ = (4 * __copy_arr_1__[__iter_21__+(-2)+(M-0)*(__iter_20__+(-1))]);
        float __temp_360__;
        __temp_360__ = (__temp_358__ + __temp_359__);
        float __temp_361__;
        __temp_361__ = (9 * __copy_arr_1__[__iter_21__+(-1)+(M-0)*(__iter_20__+(-1))]);
        float __temp_362__;
        __temp_362__ = (__temp_360__ + __temp_361__);
        float __temp_363__;
        __temp_363__ = (12 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__+(-1))]);
        float __temp_364__;
        __temp_364__ = (__temp_362__ + __temp_363__);
        float __temp_365__;
        __temp_365__ = (9 * __copy_arr_1__[__iter_21__+(1)+(M-0)*(__iter_20__+(-1))]);
        float __temp_366__;
        __temp_366__ = (__temp_364__ + __temp_365__);
        float __temp_367__;
        __temp_367__ = (4 * __copy_arr_1__[__iter_21__+(2)+(M-0)*(__iter_20__+(-1))]);
        float __temp_368__;
        __temp_368__ = (__temp_366__ + __temp_367__);
        float __temp_369__;
        __temp_369__ = (5 * __copy_arr_1__[__iter_21__+(-2)+(M-0)*(__iter_20__)]);
        float __temp_370__;
        __temp_370__ = (__temp_368__ + __temp_369__);
        float __temp_371__;
        __temp_371__ = (12 * __copy_arr_1__[__iter_21__+(-1)+(M-0)*(__iter_20__)]);
        float __temp_372__;
        __temp_372__ = (__temp_370__ + __temp_371__);
        float __temp_373__;
        __temp_373__ = (15 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__)]);
        float __temp_374__;
        __temp_374__ = (__temp_372__ + __temp_373__);
        float __temp_375__;
        __temp_375__ = (12 * __copy_arr_1__[__iter_21__+(1)+(M-0)*(__iter_20__)]);
        float __temp_376__;
        __temp_376__ = (__temp_374__ + __temp_375__);
        float __temp_377__;
        __temp_377__ = (5 * __copy_arr_1__[__iter_21__+(2)+(M-0)*(__iter_20__)]);
        float __temp_378__;
        __temp_378__ = (__temp_376__ + __temp_377__);
        float __temp_379__;
        __temp_379__ = (4 * __copy_arr_1__[__iter_21__+(-2)+(M-0)*(__iter_20__+(1))]);
        float __temp_380__;
        __temp_380__ = (__temp_378__ + __temp_379__);
        float __temp_381__;
        __temp_381__ = (9 * __copy_arr_1__[__iter_21__+(-1)+(M-0)*(__iter_20__+(1))]);
        float __temp_382__;
        __temp_382__ = (__temp_380__ + __temp_381__);
        float __temp_383__;
        __temp_383__ = (12 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__+(1))]);
        float __temp_384__;
        __temp_384__ = (__temp_382__ + __temp_383__);
        float __temp_385__;
        __temp_385__ = (9 * __copy_arr_1__[__iter_21__+(1)+(M-0)*(__iter_20__+(1))]);
        float __temp_386__;
        __temp_386__ = (__temp_384__ + __temp_385__);
        float __temp_387__;
        __temp_387__ = (4 * __copy_arr_1__[__iter_21__+(2)+(M-0)*(__iter_20__+(1))]);
        float __temp_388__;
        __temp_388__ = (__temp_386__ + __temp_387__);
        float __temp_389__;
        __temp_389__ = (2 * __copy_arr_1__[__iter_21__+(-2)+(M-0)*(__iter_20__+(2))]);
        float __temp_390__;
        __temp_390__ = (__temp_388__ + __temp_389__);
        float __temp_391__;
        __temp_391__ = (4 * __copy_arr_1__[__iter_21__+(-1)+(M-0)*(__iter_20__+(2))]);
        float __temp_392__;
        __temp_392__ = (__temp_390__ + __temp_391__);
        float __temp_393__;
        __temp_393__ = (5 * __copy_arr_1__[__iter_21__+(M-0)*(__iter_20__+(2))]);
        float __temp_394__;
        __temp_394__ = (__temp_392__ + __temp_393__);
        float __temp_395__;
        __temp_395__ = (4 * __copy_arr_1__[__iter_21__+(1)+(M-0)*(__iter_20__+(2))]);
        float __temp_396__;
        __temp_396__ = (__temp_394__ + __temp_395__);
        float __temp_397__;
        __temp_397__ = (2 * __copy_arr_1__[__iter_21__+(2)+(M-0)*(__iter_20__+(2))]);
        float __temp_398__;
        __temp_398__ = (__temp_396__ + __temp_397__);
        float __temp_399__;
        __temp_399__ = (__temp_398__ / 159);
        __copy_arr_2__[__iter_21__+(M-0)*(__iter_20__)] = __temp_399__;
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
  __iter_24__ = FORMA_MAX(__iter_1__,2) + (int)(threadIdx.y) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-3)) ; __iter_24__ += (int)(blockDim.y) ){
    int __iter_25__;
    __iter_25__ = FORMA_MAX(__iter_0__,2) + (int)(threadIdx.x) ; 
    if( __iter_25__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-3)) ){
      if (__iter_24__ < FORMA_MAX((__iter_1__+8),2) || __iter_24__ > FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-9),(N-3)) || __iter_25__ < FORMA_MAX((__iter_0__+8),2) || __iter_25__ > FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-9),(M-3))) {
        float __temp_450__;
        __temp_450__ = (2 * __copy_arr_2__[__iter_25__+(-2)+(M-0)*(__iter_24__+(-2))]);
        float __temp_451__;
        __temp_451__ = (4 * __copy_arr_2__[__iter_25__+(-1)+(M-0)*(__iter_24__+(-2))]);
        float __temp_452__;
        __temp_452__ = (__temp_450__ + __temp_451__);
        float __temp_453__;
        __temp_453__ = (5 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__+(-2))]);
        float __temp_454__;
        __temp_454__ = (__temp_452__ + __temp_453__);
        float __temp_455__;
        __temp_455__ = (4 * __copy_arr_2__[__iter_25__+(1)+(M-0)*(__iter_24__+(-2))]);
        float __temp_456__;
        __temp_456__ = (__temp_454__ + __temp_455__);
        float __temp_457__;
        __temp_457__ = (2 * __copy_arr_2__[__iter_25__+(2)+(M-0)*(__iter_24__+(-2))]);
        float __temp_458__;
        __temp_458__ = (__temp_456__ + __temp_457__);
        float __temp_459__;
        __temp_459__ = (4 * __copy_arr_2__[__iter_25__+(-2)+(M-0)*(__iter_24__+(-1))]);
        float __temp_460__;
        __temp_460__ = (__temp_458__ + __temp_459__);
        float __temp_461__;
        __temp_461__ = (9 * __copy_arr_2__[__iter_25__+(-1)+(M-0)*(__iter_24__+(-1))]);
        float __temp_462__;
        __temp_462__ = (__temp_460__ + __temp_461__);
        float __temp_463__;
        __temp_463__ = (12 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__+(-1))]);
        float __temp_464__;
        __temp_464__ = (__temp_462__ + __temp_463__);
        float __temp_465__;
        __temp_465__ = (9 * __copy_arr_2__[__iter_25__+(1)+(M-0)*(__iter_24__+(-1))]);
        float __temp_466__;
        __temp_466__ = (__temp_464__ + __temp_465__);
        float __temp_467__;
        __temp_467__ = (4 * __copy_arr_2__[__iter_25__+(2)+(M-0)*(__iter_24__+(-1))]);
        float __temp_468__;
        __temp_468__ = (__temp_466__ + __temp_467__);
        float __temp_469__;
        __temp_469__ = (5 * __copy_arr_2__[__iter_25__+(-2)+(M-0)*(__iter_24__)]);
        float __temp_470__;
        __temp_470__ = (__temp_468__ + __temp_469__);
        float __temp_471__;
        __temp_471__ = (12 * __copy_arr_2__[__iter_25__+(-1)+(M-0)*(__iter_24__)]);
        float __temp_472__;
        __temp_472__ = (__temp_470__ + __temp_471__);
        float __temp_473__;
        __temp_473__ = (15 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__)]);
        float __temp_474__;
        __temp_474__ = (__temp_472__ + __temp_473__);
        float __temp_475__;
        __temp_475__ = (12 * __copy_arr_2__[__iter_25__+(1)+(M-0)*(__iter_24__)]);
        float __temp_476__;
        __temp_476__ = (__temp_474__ + __temp_475__);
        float __temp_477__;
        __temp_477__ = (5 * __copy_arr_2__[__iter_25__+(2)+(M-0)*(__iter_24__)]);
        float __temp_478__;
        __temp_478__ = (__temp_476__ + __temp_477__);
        float __temp_479__;
        __temp_479__ = (4 * __copy_arr_2__[__iter_25__+(-2)+(M-0)*(__iter_24__+(1))]);
        float __temp_480__;
        __temp_480__ = (__temp_478__ + __temp_479__);
        float __temp_481__;
        __temp_481__ = (9 * __copy_arr_2__[__iter_25__+(-1)+(M-0)*(__iter_24__+(1))]);
        float __temp_482__;
        __temp_482__ = (__temp_480__ + __temp_481__);
        float __temp_483__;
        __temp_483__ = (12 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__+(1))]);
        float __temp_484__;
        __temp_484__ = (__temp_482__ + __temp_483__);
        float __temp_485__;
        __temp_485__ = (9 * __copy_arr_2__[__iter_25__+(1)+(M-0)*(__iter_24__+(1))]);
        float __temp_486__;
        __temp_486__ = (__temp_484__ + __temp_485__);
        float __temp_487__;
        __temp_487__ = (4 * __copy_arr_2__[__iter_25__+(2)+(M-0)*(__iter_24__+(1))]);
        float __temp_488__;
        __temp_488__ = (__temp_486__ + __temp_487__);
        float __temp_489__;
        __temp_489__ = (2 * __copy_arr_2__[__iter_25__+(-2)+(M-0)*(__iter_24__+(2))]);
        float __temp_490__;
        __temp_490__ = (__temp_488__ + __temp_489__);
        float __temp_491__;
        __temp_491__ = (4 * __copy_arr_2__[__iter_25__+(-1)+(M-0)*(__iter_24__+(2))]);
        float __temp_492__;
        __temp_492__ = (__temp_490__ + __temp_491__);
        float __temp_493__;
        __temp_493__ = (5 * __copy_arr_2__[__iter_25__+(M-0)*(__iter_24__+(2))]);
        float __temp_494__;
        __temp_494__ = (__temp_492__ + __temp_493__);
        float __temp_495__;
        __temp_495__ = (4 * __copy_arr_2__[__iter_25__+(1)+(M-0)*(__iter_24__+(2))]);
        float __temp_496__;
        __temp_496__ = (__temp_494__ + __temp_495__);
        float __temp_497__;
        __temp_497__ = (2 * __copy_arr_2__[__iter_25__+(2)+(M-0)*(__iter_24__+(2))]);
        float __temp_498__;
        __temp_498__ = (__temp_496__ + __temp_497__);
        float __temp_499__;
        __temp_499__ = (__temp_498__ / 159);
        __var_1__[__iter_25__+(M-0)*(__iter_24__)] = __temp_499__;
      }
    }
  }
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
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  dim3 __blockConfig___kernel___forma_kernel__1__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/4);
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__1__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __copy_arr_0__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");

  dim3 __blockConfig___kernel___forma_kernel__2__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/4);
  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__2__>>> (__copy_arr_0__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __copy_arr_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");

  dim3 __blockConfig___kernel___forma_kernel__3__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/4);
  __kernel___forma_kernel__3__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__3__>>> (__copy_arr_1__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __copy_arr_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__3__\n");

  dim3 __blockConfig___kernel___forma_kernel__4__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/4);
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
