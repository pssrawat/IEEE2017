#include "cuda.h"
#ifdef _TIMER_
#include "cuda_profiler_api.h"
#endif
#include "stdio.h"
#include <nvml.h>
#include <assert.h>


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
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __var_4__){
	int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_0__;
	__iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_0__ <= (N-2)){
		int __iter_1__;
		__iter_1__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_1__ <= (M-2)){
			int __iter_2__;
			__iter_2__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 1;
			if(__iter_2__ <= (L-2)){
				float __temp_0__;
				__temp_0__ = (input[__iter_0__+(-1)+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__+(-1)))] + input[__iter_0__+(1)+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__+(-1)))]);
				float __temp_1__;
				__temp_1__ = (__temp_0__ + input[__iter_0__+(-1)+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__+(-1)))]);
				float __temp_2__;
				__temp_2__ = (__temp_1__ + input[__iter_0__+(1)+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__+(-1)))]);
				float __temp_3__;
				__temp_3__ = (0.500000f * __temp_2__);
				float __temp_4__;
				__temp_4__ = (0.510000f * input[__iter_0__+(-1)+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__))]);
				float __temp_5__;
				__temp_5__ = (__temp_3__ + __temp_4__);
				float __temp_6__;
				__temp_6__ = (0.710000f * input[__iter_0__+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__))]);
				float __temp_7__;
				__temp_7__ = (__temp_5__ + __temp_6__);
				float __temp_8__;
				__temp_8__ = (0.910000f * input[__iter_0__+(1)+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__))]);
				float __temp_9__;
				__temp_9__ = (__temp_7__ + __temp_8__);
				float __temp_10__;
				__temp_10__ = (1.210000f * input[__iter_0__+(-1)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				float __temp_11__;
				__temp_11__ = (__temp_9__ + __temp_10__);
				float __temp_12__;
				__temp_12__ = (1.510000f * input[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				float __temp_13__;
				__temp_13__ = (__temp_11__ + __temp_12__);
				float __temp_14__;
				__temp_14__ = (1.210000f * input[__iter_0__+(1)+(N-0)*(__iter_1__+(M-0)*(__iter_2__))]);
				float __temp_15__;
				__temp_15__ = (__temp_13__ + __temp_14__);
				float __temp_16__;
				__temp_16__ = (0.910000f * input[__iter_0__+(-1)+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__))]);
				float __temp_17__;
				__temp_17__ = (__temp_15__ + __temp_16__);
				float __temp_18__;
				__temp_18__ = (0.710000f * input[__iter_0__+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__))]);
				float __temp_19__;
				__temp_19__ = (__temp_17__ + __temp_18__);
				float __temp_20__;
				__temp_20__ = (0.510000f * input[__iter_0__+(1)+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__))]);
				float __temp_21__;
				__temp_21__ = (__temp_19__ + __temp_20__);
				float __temp_22__;
				__temp_22__ = (input[__iter_0__+(-1)+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__+(1)))] + input[__iter_0__+(1)+(N-0)*(__iter_1__+(-1)+(M-0)*(__iter_2__+(1)))]);
				float __temp_23__;
				__temp_23__ = (__temp_22__ + input[__iter_0__+(-1)+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__+(1)))]);
				float __temp_24__;
				__temp_24__ = (__temp_23__ + input[__iter_0__+(1)+(N-0)*(__iter_1__+(1)+(M-0)*(__iter_2__+(1)))]);
				float __temp_25__;
				__temp_25__ = (0.520000f * __temp_24__);
				float __temp_26__;
				__temp_26__ = (__temp_21__ + __temp_25__);
				float __temp_27__;
				__temp_27__ = (__temp_26__ / 159);
				__var_4__[__iter_0__+(N-0)*(__iter_1__+(M-0)*(__iter_2__))] = __temp_27__;
			}
		}
	}
}
__global__ void __kernel___forma_kernel__1__(float * __restrict__ __var_4__, int L, int M, int N, float * __restrict__ __var_3__){
	int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_3__;
	__iter_3__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_3__ <= (N-2)){
		int __iter_4__;
		__iter_4__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_4__ <= (M-2)){
			int __iter_5__;
			__iter_5__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 1;
			if(__iter_5__ <= (L-2)){
				float __temp_28__;
				__temp_28__ = (__var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__+(-1)))] + __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__+(-1)))]);
				float __temp_29__;
				__temp_29__ = (__temp_28__ + __var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__+(-1)))]);
				float __temp_30__;
				__temp_30__ = (__temp_29__ + __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__+(-1)))]);
				float __temp_31__;
				__temp_31__ = (0.500000f * __temp_30__);
				float __temp_32__;
				__temp_32__ = (0.510000f * __var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__))]);
				float __temp_33__;
				__temp_33__ = (__temp_31__ + __temp_32__);
				float __temp_34__;
				__temp_34__ = (0.710000f * __var_4__[__iter_3__+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__))]);
				float __temp_35__;
				__temp_35__ = (__temp_33__ + __temp_34__);
				float __temp_36__;
				__temp_36__ = (0.910000f * __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__))]);
				float __temp_37__;
				__temp_37__ = (__temp_35__ + __temp_36__);
				float __temp_38__;
				__temp_38__ = (1.210000f * __var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(M-0)*(__iter_5__))]);
				float __temp_39__;
				__temp_39__ = (__temp_37__ + __temp_38__);
				float __temp_40__;
				__temp_40__ = (1.510000f * __var_4__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))]);
				float __temp_41__;
				__temp_41__ = (__temp_39__ + __temp_40__);
				float __temp_42__;
				__temp_42__ = (1.210000f * __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(M-0)*(__iter_5__))]);
				float __temp_43__;
				__temp_43__ = (__temp_41__ + __temp_42__);
				float __temp_44__;
				__temp_44__ = (0.910000f * __var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__))]);
				float __temp_45__;
				__temp_45__ = (__temp_43__ + __temp_44__);
				float __temp_46__;
				__temp_46__ = (0.710000f * __var_4__[__iter_3__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__))]);
				float __temp_47__;
				__temp_47__ = (__temp_45__ + __temp_46__);
				float __temp_48__;
				__temp_48__ = (0.510000f * __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__))]);
				float __temp_49__;
				__temp_49__ = (__temp_47__ + __temp_48__);
				float __temp_50__;
				__temp_50__ = (__var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__+(1)))] + __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(-1)+(M-0)*(__iter_5__+(1)))]);
				float __temp_51__;
				__temp_51__ = (__temp_50__ + __var_4__[__iter_3__+(-1)+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__+(1)))]);
				float __temp_52__;
				__temp_52__ = (__temp_51__ + __var_4__[__iter_3__+(1)+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_5__+(1)))]);
				float __temp_53__;
				__temp_53__ = (0.520000f * __temp_52__);
				float __temp_54__;
				__temp_54__ = (__temp_49__ + __temp_53__);
				float __temp_55__;
				__temp_55__ = (__temp_54__ / 159);
				__var_3__[__iter_3__+(N-0)*(__iter_4__+(M-0)*(__iter_5__))] = __temp_55__;
			}
		}
	}
}
__global__ void __kernel___forma_kernel__2__(float * __restrict__ __var_3__, int L, int M, int N, float * __restrict__ __var_2__){
	int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_6__;
	__iter_6__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_6__ <= (N-2)){
		int __iter_7__;
		__iter_7__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_7__ <= (M-2)){
			int __iter_8__;
			__iter_8__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 1;
			if(__iter_8__ <= (L-2)){
				float __temp_56__;
				__temp_56__ = (__var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__+(-1)))] + __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__+(-1)))]);
				float __temp_57__;
				__temp_57__ = (__temp_56__ + __var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__+(-1)))]);
				float __temp_58__;
				__temp_58__ = (__temp_57__ + __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__+(-1)))]);
				float __temp_59__;
				__temp_59__ = (0.500000f * __temp_58__);
				float __temp_60__;
				__temp_60__ = (0.510000f * __var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__))]);
				float __temp_61__;
				__temp_61__ = (__temp_59__ + __temp_60__);
				float __temp_62__;
				__temp_62__ = (0.710000f * __var_3__[__iter_6__+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__))]);
				float __temp_63__;
				__temp_63__ = (__temp_61__ + __temp_62__);
				float __temp_64__;
				__temp_64__ = (0.910000f * __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__))]);
				float __temp_65__;
				__temp_65__ = (__temp_63__ + __temp_64__);
				float __temp_66__;
				__temp_66__ = (1.210000f * __var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(M-0)*(__iter_8__))]);
				float __temp_67__;
				__temp_67__ = (__temp_65__ + __temp_66__);
				float __temp_68__;
				__temp_68__ = (1.510000f * __var_3__[__iter_6__+(N-0)*(__iter_7__+(M-0)*(__iter_8__))]);
				float __temp_69__;
				__temp_69__ = (__temp_67__ + __temp_68__);
				float __temp_70__;
				__temp_70__ = (1.210000f * __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(M-0)*(__iter_8__))]);
				float __temp_71__;
				__temp_71__ = (__temp_69__ + __temp_70__);
				float __temp_72__;
				__temp_72__ = (0.910000f * __var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__))]);
				float __temp_73__;
				__temp_73__ = (__temp_71__ + __temp_72__);
				float __temp_74__;
				__temp_74__ = (0.710000f * __var_3__[__iter_6__+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__))]);
				float __temp_75__;
				__temp_75__ = (__temp_73__ + __temp_74__);
				float __temp_76__;
				__temp_76__ = (0.510000f * __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__))]);
				float __temp_77__;
				__temp_77__ = (__temp_75__ + __temp_76__);
				float __temp_78__;
				__temp_78__ = (__var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__+(1)))] + __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(-1)+(M-0)*(__iter_8__+(1)))]);
				float __temp_79__;
				__temp_79__ = (__temp_78__ + __var_3__[__iter_6__+(-1)+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__+(1)))]);
				float __temp_80__;
				__temp_80__ = (__temp_79__ + __var_3__[__iter_6__+(1)+(N-0)*(__iter_7__+(1)+(M-0)*(__iter_8__+(1)))]);
				float __temp_81__;
				__temp_81__ = (0.520000f * __temp_80__);
				float __temp_82__;
				__temp_82__ = (__temp_77__ + __temp_81__);
				float __temp_83__;
				__temp_83__ = (__temp_82__ / 159);
				__var_2__[__iter_6__+(N-0)*(__iter_7__+(M-0)*(__iter_8__))] = __temp_83__;
			}
		}
	}
}
__global__ void __kernel___forma_kernel__3__(float * __restrict__ __var_2__, int L, int M, int N, float * __restrict__ __var_1__){
	int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
	int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int __iter_9__;
	__iter_9__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X) + (int)(threadIdx.x) + 1;
	if(__iter_9__ <= (N-2)){
		int __iter_10__;
		__iter_10__ = (int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y) + (int)(threadIdx.y) + 1;
		if(__iter_10__ <= (M-2)){
			int __iter_11__;
			__iter_11__ = (int)(blockIdx.z)*(int)(FORMA_BLOCKDIM_Z) + (int)(threadIdx.z) + 1;
			if(__iter_11__ <= (L-2)){
				float __temp_84__;
				__temp_84__ = (__var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__+(-1)))] + __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__+(-1)))]);
				float __temp_85__;
				__temp_85__ = (__temp_84__ + __var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__+(-1)))]);
				float __temp_86__;
				__temp_86__ = (__temp_85__ + __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__+(-1)))]);
				float __temp_87__;
				__temp_87__ = (0.500000f * __temp_86__);
				float __temp_88__;
				__temp_88__ = (0.510000f * __var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__))]);
				float __temp_89__;
				__temp_89__ = (__temp_87__ + __temp_88__);
				float __temp_90__;
				__temp_90__ = (0.710000f * __var_2__[__iter_9__+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__))]);
				float __temp_91__;
				__temp_91__ = (__temp_89__ + __temp_90__);
				float __temp_92__;
				__temp_92__ = (0.910000f * __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__))]);
				float __temp_93__;
				__temp_93__ = (__temp_91__ + __temp_92__);
				float __temp_94__;
				__temp_94__ = (1.210000f * __var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(M-0)*(__iter_11__))]);
				float __temp_95__;
				__temp_95__ = (__temp_93__ + __temp_94__);
				float __temp_96__;
				__temp_96__ = (1.510000f * __var_2__[__iter_9__+(N-0)*(__iter_10__+(M-0)*(__iter_11__))]);
				float __temp_97__;
				__temp_97__ = (__temp_95__ + __temp_96__);
				float __temp_98__;
				__temp_98__ = (1.210000f * __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(M-0)*(__iter_11__))]);
				float __temp_99__;
				__temp_99__ = (__temp_97__ + __temp_98__);
				float __temp_100__;
				__temp_100__ = (0.910000f * __var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__))]);
				float __temp_101__;
				__temp_101__ = (__temp_99__ + __temp_100__);
				float __temp_102__;
				__temp_102__ = (0.710000f * __var_2__[__iter_9__+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__))]);
				float __temp_103__;
				__temp_103__ = (__temp_101__ + __temp_102__);
				float __temp_104__;
				__temp_104__ = (0.510000f * __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__))]);
				float __temp_105__;
				__temp_105__ = (__temp_103__ + __temp_104__);
				float __temp_106__;
				__temp_106__ = (__var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__+(1)))] + __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(-1)+(M-0)*(__iter_11__+(1)))]);
				float __temp_107__;
				__temp_107__ = (__temp_106__ + __var_2__[__iter_9__+(-1)+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__+(1)))]);
				float __temp_108__;
				__temp_108__ = (__temp_107__ + __var_2__[__iter_9__+(1)+(N-0)*(__iter_10__+(1)+(M-0)*(__iter_11__+(1)))]);
				float __temp_109__;
				__temp_109__ = (0.520000f * __temp_108__);
				float __temp_110__;
				__temp_110__ = (__temp_105__ + __temp_109__);
				float __temp_111__;
				__temp_111__ = (__temp_110__ / 159);
				__var_1__[__iter_9__+(N-0)*(__iter_10__+(M-0)*(__iter_11__))] = __temp_111__;
			}
		}
	}
}
/*Device code End */
/* Host Code Begin */
extern "C" void j3d17pt(float * h_input, int L, int M, int N, float * __var_0__){

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
	float * __var_3__;
	cudaMalloc(&__var_3__,sizeof(float)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : __var_3__\n");
	float * __var_4__;
	cudaMalloc(&__var_4__,sizeof(float)*((L-0)*(M-0)*(N-0)));
	Check_CUDA_Error("Allocation Error!! : __var_4__\n");
	/*Host Allocation End */
	/* Kernel Launch Begin */
#ifdef _TIMER_
	cudaEvent_t _forma_timer_start_,_forma_timer_stop_;
	cudaEventCreate(&_forma_timer_start_);
	cudaEventCreate(&_forma_timer_stop_);
	cudaEventRecord(_forma_timer_start_,0);
#endif
	int __size_0___kernel___forma_kernel__0__ = ((N-2) - 1 ) + 1;
	int __size_1___kernel___forma_kernel__0__ = ((M-2) - 1 ) + 1;
	int __size_2___kernel___forma_kernel__0__ = ((L-2) - 1 ) + 1;
	int __block_0___kernel___forma_kernel__0__ = 16;
	int __block_1___kernel___forma_kernel__0__ = 4;
	int __block_2___kernel___forma_kernel__0__ = 4;
	dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
	int __SMemSize___kernel___forma_kernel__0__ = 0;
	int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__block_0___kernel___forma_kernel__0__);
	int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
	int __grid_2___kernel___forma_kernel__0__ = FORMA_CEIL(__size_2___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
	dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);

	unsigned int power1, power2;
	nvmlReturn_t result;
	nvmlDevice_t device;
	nvmlEnableState_t mode;
	result=nvmlInit();
	result = nvmlDeviceGetHandleByIndex(0, &device);
	assert(NVML_SUCCESS == result);
	result=nvmlDeviceGetPowerManagementMode(device, &mode);
	printf("enabled = %d\n", mode);
	result=nvmlDeviceGetPowerUsage(device,&power1);
	assert(NVML_SUCCESS == result);
	cudaDeviceSynchronize();

	for (int x=0; x<500; x++) {

		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __var_4__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_4__, L, M, N, __var_3__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_3__, L, M, N, __var_2__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, L, M, N, __var_1__);
		Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
	}

	cudaDeviceSynchronize();
	result=nvmlDeviceGetPowerUsage(device,&power2);
	assert(NVML_SUCCESS == result);
	power2 -= power1;
	printf("%u\n", power2);
	nvmlShutdown();


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
	cudaFree(__var_3__);
	cudaFree(__var_4__);
}
/*Host Free End*/
