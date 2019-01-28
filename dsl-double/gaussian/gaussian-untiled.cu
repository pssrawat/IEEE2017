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
/* Device code Begin */
__global__ void __kernel___forma_kernel__0__(double * __restrict__ input, int N, int M, double * __restrict__ __var_4__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_0__;
  __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 2;
  if(__iter_0__ <= (M-3)){
    int __iter_1__;
    __iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 2;
    if(__iter_1__ <= (N-3)){
      double __temp_0__;
      __temp_0__ = (2 * input[__iter_0__+(-2)+(M-0)*(__iter_1__+(-2))]);
      double __temp_1__;
      __temp_1__ = (4 * input[__iter_0__+(-1)+(M-0)*(__iter_1__+(-2))]);
      double __temp_2__;
      __temp_2__ = (__temp_0__ + __temp_1__);
      double __temp_3__;
      __temp_3__ = (5 * input[__iter_0__+(M-0)*(__iter_1__+(-2))]);
      double __temp_4__;
      __temp_4__ = (__temp_2__ + __temp_3__);
      double __temp_5__;
      __temp_5__ = (4 * input[__iter_0__+(1)+(M-0)*(__iter_1__+(-2))]);
      double __temp_6__;
      __temp_6__ = (__temp_4__ + __temp_5__);
      double __temp_7__;
      __temp_7__ = (2 * input[__iter_0__+(2)+(M-0)*(__iter_1__+(-2))]);
      double __temp_8__;
      __temp_8__ = (__temp_6__ + __temp_7__);
      double __temp_9__;
      __temp_9__ = (4 * input[__iter_0__+(-2)+(M-0)*(__iter_1__+(-1))]);
      double __temp_10__;
      __temp_10__ = (__temp_8__ + __temp_9__);
      double __temp_11__;
      __temp_11__ = (9 * input[__iter_0__+(-1)+(M-0)*(__iter_1__+(-1))]);
      double __temp_12__;
      __temp_12__ = (__temp_10__ + __temp_11__);
      double __temp_13__;
      __temp_13__ = (12 * input[__iter_0__+(M-0)*(__iter_1__+(-1))]);
      double __temp_14__;
      __temp_14__ = (__temp_12__ + __temp_13__);
      double __temp_15__;
      __temp_15__ = (9 * input[__iter_0__+(1)+(M-0)*(__iter_1__+(-1))]);
      double __temp_16__;
      __temp_16__ = (__temp_14__ + __temp_15__);
      double __temp_17__;
      __temp_17__ = (4 * input[__iter_0__+(2)+(M-0)*(__iter_1__+(-1))]);
      double __temp_18__;
      __temp_18__ = (__temp_16__ + __temp_17__);
      double __temp_19__;
      __temp_19__ = (5 * input[__iter_0__+(-2)+(M-0)*(__iter_1__)]);
      double __temp_20__;
      __temp_20__ = (__temp_18__ + __temp_19__);
      double __temp_21__;
      __temp_21__ = (12 * input[__iter_0__+(-1)+(M-0)*(__iter_1__)]);
      double __temp_22__;
      __temp_22__ = (__temp_20__ + __temp_21__);
      double __temp_23__;
      __temp_23__ = (15 * input[__iter_0__+(M-0)*(__iter_1__)]);
      double __temp_24__;
      __temp_24__ = (__temp_22__ + __temp_23__);
      double __temp_25__;
      __temp_25__ = (12 * input[__iter_0__+(1)+(M-0)*(__iter_1__)]);
      double __temp_26__;
      __temp_26__ = (__temp_24__ + __temp_25__);
      double __temp_27__;
      __temp_27__ = (5 * input[__iter_0__+(2)+(M-0)*(__iter_1__)]);
      double __temp_28__;
      __temp_28__ = (__temp_26__ + __temp_27__);
      double __temp_29__;
      __temp_29__ = (4 * input[__iter_0__+(-2)+(M-0)*(__iter_1__+(1))]);
      double __temp_30__;
      __temp_30__ = (__temp_28__ + __temp_29__);
      double __temp_31__;
      __temp_31__ = (9 * input[__iter_0__+(-1)+(M-0)*(__iter_1__+(1))]);
      double __temp_32__;
      __temp_32__ = (__temp_30__ + __temp_31__);
      double __temp_33__;
      __temp_33__ = (12 * input[__iter_0__+(M-0)*(__iter_1__+(1))]);
      double __temp_34__;
      __temp_34__ = (__temp_32__ + __temp_33__);
      double __temp_35__;
      __temp_35__ = (9 * input[__iter_0__+(1)+(M-0)*(__iter_1__+(1))]);
      double __temp_36__;
      __temp_36__ = (__temp_34__ + __temp_35__);
      double __temp_37__;
      __temp_37__ = (4 * input[__iter_0__+(2)+(M-0)*(__iter_1__+(1))]);
      double __temp_38__;
      __temp_38__ = (__temp_36__ + __temp_37__);
      double __temp_39__;
      __temp_39__ = (2 * input[__iter_0__+(-2)+(M-0)*(__iter_1__+(2))]);
      double __temp_40__;
      __temp_40__ = (__temp_38__ + __temp_39__);
      double __temp_41__;
      __temp_41__ = (4 * input[__iter_0__+(-1)+(M-0)*(__iter_1__+(2))]);
      double __temp_42__;
      __temp_42__ = (__temp_40__ + __temp_41__);
      double __temp_43__;
      __temp_43__ = (5 * input[__iter_0__+(M-0)*(__iter_1__+(2))]);
      double __temp_44__;
      __temp_44__ = (__temp_42__ + __temp_43__);
      double __temp_45__;
      __temp_45__ = (4 * input[__iter_0__+(1)+(M-0)*(__iter_1__+(2))]);
      double __temp_46__;
      __temp_46__ = (__temp_44__ + __temp_45__);
      double __temp_47__;
      __temp_47__ = (2 * input[__iter_0__+(2)+(M-0)*(__iter_1__+(2))]);
      double __temp_48__;
      __temp_48__ = (__temp_46__ + __temp_47__);
      double __temp_49__;
      __temp_49__ = (__temp_48__ / 159);
      __var_4__[__iter_0__+(M-0)*(__iter_1__)] = __temp_49__;
    }
  }
}
__global__ void __kernel___forma_kernel__1__(double * __restrict__ __var_4__, int N, int M, double * __restrict__ __var_3__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_2__;
  __iter_2__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 2;
  if(__iter_2__ <= (M-3)){
    int __iter_3__;
    __iter_3__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 2;
    if(__iter_3__ <= (N-3)){
      double __temp_50__;
      __temp_50__ = (2 * __var_4__[__iter_2__+(-2)+(M-0)*(__iter_3__+(-2))]);
      double __temp_51__;
      __temp_51__ = (4 * __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__+(-2))]);
      double __temp_52__;
      __temp_52__ = (__temp_50__ + __temp_51__);
      double __temp_53__;
      __temp_53__ = (5 * __var_4__[__iter_2__+(M-0)*(__iter_3__+(-2))]);
      double __temp_54__;
      __temp_54__ = (__temp_52__ + __temp_53__);
      double __temp_55__;
      __temp_55__ = (4 * __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__+(-2))]);
      double __temp_56__;
      __temp_56__ = (__temp_54__ + __temp_55__);
      double __temp_57__;
      __temp_57__ = (2 * __var_4__[__iter_2__+(2)+(M-0)*(__iter_3__+(-2))]);
      double __temp_58__;
      __temp_58__ = (__temp_56__ + __temp_57__);
      double __temp_59__;
      __temp_59__ = (4 * __var_4__[__iter_2__+(-2)+(M-0)*(__iter_3__+(-1))]);
      double __temp_60__;
      __temp_60__ = (__temp_58__ + __temp_59__);
      double __temp_61__;
      __temp_61__ = (9 * __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__+(-1))]);
      double __temp_62__;
      __temp_62__ = (__temp_60__ + __temp_61__);
      double __temp_63__;
      __temp_63__ = (12 * __var_4__[__iter_2__+(M-0)*(__iter_3__+(-1))]);
      double __temp_64__;
      __temp_64__ = (__temp_62__ + __temp_63__);
      double __temp_65__;
      __temp_65__ = (9 * __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__+(-1))]);
      double __temp_66__;
      __temp_66__ = (__temp_64__ + __temp_65__);
      double __temp_67__;
      __temp_67__ = (4 * __var_4__[__iter_2__+(2)+(M-0)*(__iter_3__+(-1))]);
      double __temp_68__;
      __temp_68__ = (__temp_66__ + __temp_67__);
      double __temp_69__;
      __temp_69__ = (5 * __var_4__[__iter_2__+(-2)+(M-0)*(__iter_3__)]);
      double __temp_70__;
      __temp_70__ = (__temp_68__ + __temp_69__);
      double __temp_71__;
      __temp_71__ = (12 * __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__)]);
      double __temp_72__;
      __temp_72__ = (__temp_70__ + __temp_71__);
      double __temp_73__;
      __temp_73__ = (15 * __var_4__[__iter_2__+(M-0)*(__iter_3__)]);
      double __temp_74__;
      __temp_74__ = (__temp_72__ + __temp_73__);
      double __temp_75__;
      __temp_75__ = (12 * __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__)]);
      double __temp_76__;
      __temp_76__ = (__temp_74__ + __temp_75__);
      double __temp_77__;
      __temp_77__ = (5 * __var_4__[__iter_2__+(2)+(M-0)*(__iter_3__)]);
      double __temp_78__;
      __temp_78__ = (__temp_76__ + __temp_77__);
      double __temp_79__;
      __temp_79__ = (4 * __var_4__[__iter_2__+(-2)+(M-0)*(__iter_3__+(1))]);
      double __temp_80__;
      __temp_80__ = (__temp_78__ + __temp_79__);
      double __temp_81__;
      __temp_81__ = (9 * __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__+(1))]);
      double __temp_82__;
      __temp_82__ = (__temp_80__ + __temp_81__);
      double __temp_83__;
      __temp_83__ = (12 * __var_4__[__iter_2__+(M-0)*(__iter_3__+(1))]);
      double __temp_84__;
      __temp_84__ = (__temp_82__ + __temp_83__);
      double __temp_85__;
      __temp_85__ = (9 * __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__+(1))]);
      double __temp_86__;
      __temp_86__ = (__temp_84__ + __temp_85__);
      double __temp_87__;
      __temp_87__ = (4 * __var_4__[__iter_2__+(2)+(M-0)*(__iter_3__+(1))]);
      double __temp_88__;
      __temp_88__ = (__temp_86__ + __temp_87__);
      double __temp_89__;
      __temp_89__ = (2 * __var_4__[__iter_2__+(-2)+(M-0)*(__iter_3__+(2))]);
      double __temp_90__;
      __temp_90__ = (__temp_88__ + __temp_89__);
      double __temp_91__;
      __temp_91__ = (4 * __var_4__[__iter_2__+(-1)+(M-0)*(__iter_3__+(2))]);
      double __temp_92__;
      __temp_92__ = (__temp_90__ + __temp_91__);
      double __temp_93__;
      __temp_93__ = (5 * __var_4__[__iter_2__+(M-0)*(__iter_3__+(2))]);
      double __temp_94__;
      __temp_94__ = (__temp_92__ + __temp_93__);
      double __temp_95__;
      __temp_95__ = (4 * __var_4__[__iter_2__+(1)+(M-0)*(__iter_3__+(2))]);
      double __temp_96__;
      __temp_96__ = (__temp_94__ + __temp_95__);
      double __temp_97__;
      __temp_97__ = (2 * __var_4__[__iter_2__+(2)+(M-0)*(__iter_3__+(2))]);
      double __temp_98__;
      __temp_98__ = (__temp_96__ + __temp_97__);
      double __temp_99__;
      __temp_99__ = (__temp_98__ / 159);
      __var_3__[__iter_2__+(M-0)*(__iter_3__)] = __temp_99__;
    }
  }
}
__global__ void __kernel___forma_kernel__2__(double * __restrict__ __var_3__, int N, int M, double * __restrict__ __var_2__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_4__;
  __iter_4__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 2;
  if(__iter_4__ <= (M-3)){
    int __iter_5__;
    __iter_5__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 2;
    if(__iter_5__ <= (N-3)){
      double __temp_100__;
      __temp_100__ = (2 * __var_3__[__iter_4__+(-2)+(M-0)*(__iter_5__+(-2))]);
      double __temp_101__;
      __temp_101__ = (4 * __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__+(-2))]);
      double __temp_102__;
      __temp_102__ = (__temp_100__ + __temp_101__);
      double __temp_103__;
      __temp_103__ = (5 * __var_3__[__iter_4__+(M-0)*(__iter_5__+(-2))]);
      double __temp_104__;
      __temp_104__ = (__temp_102__ + __temp_103__);
      double __temp_105__;
      __temp_105__ = (4 * __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__+(-2))]);
      double __temp_106__;
      __temp_106__ = (__temp_104__ + __temp_105__);
      double __temp_107__;
      __temp_107__ = (2 * __var_3__[__iter_4__+(2)+(M-0)*(__iter_5__+(-2))]);
      double __temp_108__;
      __temp_108__ = (__temp_106__ + __temp_107__);
      double __temp_109__;
      __temp_109__ = (4 * __var_3__[__iter_4__+(-2)+(M-0)*(__iter_5__+(-1))]);
      double __temp_110__;
      __temp_110__ = (__temp_108__ + __temp_109__);
      double __temp_111__;
      __temp_111__ = (9 * __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__+(-1))]);
      double __temp_112__;
      __temp_112__ = (__temp_110__ + __temp_111__);
      double __temp_113__;
      __temp_113__ = (12 * __var_3__[__iter_4__+(M-0)*(__iter_5__+(-1))]);
      double __temp_114__;
      __temp_114__ = (__temp_112__ + __temp_113__);
      double __temp_115__;
      __temp_115__ = (9 * __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__+(-1))]);
      double __temp_116__;
      __temp_116__ = (__temp_114__ + __temp_115__);
      double __temp_117__;
      __temp_117__ = (4 * __var_3__[__iter_4__+(2)+(M-0)*(__iter_5__+(-1))]);
      double __temp_118__;
      __temp_118__ = (__temp_116__ + __temp_117__);
      double __temp_119__;
      __temp_119__ = (5 * __var_3__[__iter_4__+(-2)+(M-0)*(__iter_5__)]);
      double __temp_120__;
      __temp_120__ = (__temp_118__ + __temp_119__);
      double __temp_121__;
      __temp_121__ = (12 * __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__)]);
      double __temp_122__;
      __temp_122__ = (__temp_120__ + __temp_121__);
      double __temp_123__;
      __temp_123__ = (15 * __var_3__[__iter_4__+(M-0)*(__iter_5__)]);
      double __temp_124__;
      __temp_124__ = (__temp_122__ + __temp_123__);
      double __temp_125__;
      __temp_125__ = (12 * __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__)]);
      double __temp_126__;
      __temp_126__ = (__temp_124__ + __temp_125__);
      double __temp_127__;
      __temp_127__ = (5 * __var_3__[__iter_4__+(2)+(M-0)*(__iter_5__)]);
      double __temp_128__;
      __temp_128__ = (__temp_126__ + __temp_127__);
      double __temp_129__;
      __temp_129__ = (4 * __var_3__[__iter_4__+(-2)+(M-0)*(__iter_5__+(1))]);
      double __temp_130__;
      __temp_130__ = (__temp_128__ + __temp_129__);
      double __temp_131__;
      __temp_131__ = (9 * __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__+(1))]);
      double __temp_132__;
      __temp_132__ = (__temp_130__ + __temp_131__);
      double __temp_133__;
      __temp_133__ = (12 * __var_3__[__iter_4__+(M-0)*(__iter_5__+(1))]);
      double __temp_134__;
      __temp_134__ = (__temp_132__ + __temp_133__);
      double __temp_135__;
      __temp_135__ = (9 * __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__+(1))]);
      double __temp_136__;
      __temp_136__ = (__temp_134__ + __temp_135__);
      double __temp_137__;
      __temp_137__ = (4 * __var_3__[__iter_4__+(2)+(M-0)*(__iter_5__+(1))]);
      double __temp_138__;
      __temp_138__ = (__temp_136__ + __temp_137__);
      double __temp_139__;
      __temp_139__ = (2 * __var_3__[__iter_4__+(-2)+(M-0)*(__iter_5__+(2))]);
      double __temp_140__;
      __temp_140__ = (__temp_138__ + __temp_139__);
      double __temp_141__;
      __temp_141__ = (4 * __var_3__[__iter_4__+(-1)+(M-0)*(__iter_5__+(2))]);
      double __temp_142__;
      __temp_142__ = (__temp_140__ + __temp_141__);
      double __temp_143__;
      __temp_143__ = (5 * __var_3__[__iter_4__+(M-0)*(__iter_5__+(2))]);
      double __temp_144__;
      __temp_144__ = (__temp_142__ + __temp_143__);
      double __temp_145__;
      __temp_145__ = (4 * __var_3__[__iter_4__+(1)+(M-0)*(__iter_5__+(2))]);
      double __temp_146__;
      __temp_146__ = (__temp_144__ + __temp_145__);
      double __temp_147__;
      __temp_147__ = (2 * __var_3__[__iter_4__+(2)+(M-0)*(__iter_5__+(2))]);
      double __temp_148__;
      __temp_148__ = (__temp_146__ + __temp_147__);
      double __temp_149__;
      __temp_149__ = (__temp_148__ / 159);
      __var_2__[__iter_4__+(M-0)*(__iter_5__)] = __temp_149__;
    }
  }
}
__global__ void __kernel___forma_kernel__3__(double * __restrict__ __var_2__, int N, int M, double * __restrict__ __var_1__){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int __iter_6__;
  __iter_6__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 2;
  if(__iter_6__ <= (M-3)){
    int __iter_7__;
    __iter_7__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 2;
    if(__iter_7__ <= (N-3)){
      double __temp_150__;
      __temp_150__ = (2 * __var_2__[__iter_6__+(-2)+(M-0)*(__iter_7__+(-2))]);
      double __temp_151__;
      __temp_151__ = (4 * __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__+(-2))]);
      double __temp_152__;
      __temp_152__ = (__temp_150__ + __temp_151__);
      double __temp_153__;
      __temp_153__ = (5 * __var_2__[__iter_6__+(M-0)*(__iter_7__+(-2))]);
      double __temp_154__;
      __temp_154__ = (__temp_152__ + __temp_153__);
      double __temp_155__;
      __temp_155__ = (4 * __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__+(-2))]);
      double __temp_156__;
      __temp_156__ = (__temp_154__ + __temp_155__);
      double __temp_157__;
      __temp_157__ = (2 * __var_2__[__iter_6__+(2)+(M-0)*(__iter_7__+(-2))]);
      double __temp_158__;
      __temp_158__ = (__temp_156__ + __temp_157__);
      double __temp_159__;
      __temp_159__ = (4 * __var_2__[__iter_6__+(-2)+(M-0)*(__iter_7__+(-1))]);
      double __temp_160__;
      __temp_160__ = (__temp_158__ + __temp_159__);
      double __temp_161__;
      __temp_161__ = (9 * __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__+(-1))]);
      double __temp_162__;
      __temp_162__ = (__temp_160__ + __temp_161__);
      double __temp_163__;
      __temp_163__ = (12 * __var_2__[__iter_6__+(M-0)*(__iter_7__+(-1))]);
      double __temp_164__;
      __temp_164__ = (__temp_162__ + __temp_163__);
      double __temp_165__;
      __temp_165__ = (9 * __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__+(-1))]);
      double __temp_166__;
      __temp_166__ = (__temp_164__ + __temp_165__);
      double __temp_167__;
      __temp_167__ = (4 * __var_2__[__iter_6__+(2)+(M-0)*(__iter_7__+(-1))]);
      double __temp_168__;
      __temp_168__ = (__temp_166__ + __temp_167__);
      double __temp_169__;
      __temp_169__ = (5 * __var_2__[__iter_6__+(-2)+(M-0)*(__iter_7__)]);
      double __temp_170__;
      __temp_170__ = (__temp_168__ + __temp_169__);
      double __temp_171__;
      __temp_171__ = (12 * __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__)]);
      double __temp_172__;
      __temp_172__ = (__temp_170__ + __temp_171__);
      double __temp_173__;
      __temp_173__ = (15 * __var_2__[__iter_6__+(M-0)*(__iter_7__)]);
      double __temp_174__;
      __temp_174__ = (__temp_172__ + __temp_173__);
      double __temp_175__;
      __temp_175__ = (12 * __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__)]);
      double __temp_176__;
      __temp_176__ = (__temp_174__ + __temp_175__);
      double __temp_177__;
      __temp_177__ = (5 * __var_2__[__iter_6__+(2)+(M-0)*(__iter_7__)]);
      double __temp_178__;
      __temp_178__ = (__temp_176__ + __temp_177__);
      double __temp_179__;
      __temp_179__ = (4 * __var_2__[__iter_6__+(-2)+(M-0)*(__iter_7__+(1))]);
      double __temp_180__;
      __temp_180__ = (__temp_178__ + __temp_179__);
      double __temp_181__;
      __temp_181__ = (9 * __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__+(1))]);
      double __temp_182__;
      __temp_182__ = (__temp_180__ + __temp_181__);
      double __temp_183__;
      __temp_183__ = (12 * __var_2__[__iter_6__+(M-0)*(__iter_7__+(1))]);
      double __temp_184__;
      __temp_184__ = (__temp_182__ + __temp_183__);
      double __temp_185__;
      __temp_185__ = (9 * __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__+(1))]);
      double __temp_186__;
      __temp_186__ = (__temp_184__ + __temp_185__);
      double __temp_187__;
      __temp_187__ = (4 * __var_2__[__iter_6__+(2)+(M-0)*(__iter_7__+(1))]);
      double __temp_188__;
      __temp_188__ = (__temp_186__ + __temp_187__);
      double __temp_189__;
      __temp_189__ = (2 * __var_2__[__iter_6__+(-2)+(M-0)*(__iter_7__+(2))]);
      double __temp_190__;
      __temp_190__ = (__temp_188__ + __temp_189__);
      double __temp_191__;
      __temp_191__ = (4 * __var_2__[__iter_6__+(-1)+(M-0)*(__iter_7__+(2))]);
      double __temp_192__;
      __temp_192__ = (__temp_190__ + __temp_191__);
      double __temp_193__;
      __temp_193__ = (5 * __var_2__[__iter_6__+(M-0)*(__iter_7__+(2))]);
      double __temp_194__;
      __temp_194__ = (__temp_192__ + __temp_193__);
      double __temp_195__;
      __temp_195__ = (4 * __var_2__[__iter_6__+(1)+(M-0)*(__iter_7__+(2))]);
      double __temp_196__;
      __temp_196__ = (__temp_194__ + __temp_195__);
      double __temp_197__;
      __temp_197__ = (2 * __var_2__[__iter_6__+(2)+(M-0)*(__iter_7__+(2))]);
      double __temp_198__;
      __temp_198__ = (__temp_196__ + __temp_197__);
      double __temp_199__;
      __temp_199__ = (__temp_198__ / 159);
      __var_1__[__iter_6__+(M-0)*(__iter_7__)] = __temp_199__;
    }
  }
}
/*Device code End */
/* Host Code Begin */
extern "C" void gaussian(double * h_input, int N, int M, double * __var_0__){

/* Host allocation Begin */
  double * input;
  cudaMalloc(&input,sizeof(double)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(double)*((N-0)*(M-0)), memcpy_kind_h_input);
  }
  double * __var_1__;
  cudaMalloc(&__var_1__,sizeof(double)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  double * __var_2__;
  cudaMalloc(&__var_2__,sizeof(double)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_2__\n");
  double * __var_3__;
  cudaMalloc(&__var_3__,sizeof(double)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_3__\n");
  double * __var_4__;
  cudaMalloc(&__var_4__,sizeof(double)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __var_4__\n");
/*Host Allocation End */
/* Kernel Launch Begin */
#ifdef _TIMER_
  cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
  cudaEventCreate(&_forma_timer_start_);
  cudaEventCreate(&_forma_timer_stop_);
  cudaEventRecord(_forma_timer_start_,0);
#endif
  int __size_0___kernel___forma_kernel__0__ = ((M-3) - 2 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((N-3) - 2 ) + 1;
  int __block_0___kernel___forma_kernel__0__ = 16;
  int __block_1___kernel___forma_kernel__0__ = 32;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __var_4__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_4__, N, M, __var_3__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_3__, N, M, __var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, N, M, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(double)*((N-0)*(M-0)), memcpy_kind___var_0__);
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
  cudaFree(__var_3__);
  cudaFree(__var_4__);
}
/*Host Free End*/
