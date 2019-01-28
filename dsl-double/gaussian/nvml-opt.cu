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
#define mod(x,y) ( (x) & (y-1))

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

__global__ void __kernel___forma_kernel__0__(double * __restrict__ input, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, double * __restrict__ __var_1__){
	int __FORMA_SHARED_MEM_OFFSET__ = 0;
	double * __tilevar_0__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
	__FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_X);
	double * __tilevar_1__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
	__FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_X);

	double t2_0=0.0f, t2_1=0.0f, t3_0=0.0f, t3_1=0.0f, out=0.0f;
	double b2_0=0.0f, b2_1=0.0f, b3_0=0.0f, b3_1=0.0f;
	int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X-8);
	int __iter_y__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y));

	//Initialize the values
	int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
	if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
		__tilevar_1__[__iter_3__-__iter_0__] = 0.0f;
	}
	// Initial loop 
	for (int __iter_1__ = FORMA_MAX(0,__iter_y__-4); __iter_1__ <= __iter_y__+3; __iter_1__++) {
		if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
			__tilevar_0__[__iter_3__-__iter_0__] = input[__iter_3__+M*(__iter_1__)];
		}
		__syncthreads ();
		if(__iter_3__ >= FORMA_MAX((__iter_0__+2),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3))) {
			// Bottom -2
			double __temp_2__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_5__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
			double __temp_9__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_10__ = (__temp_6__ + 5 * __temp_9__);
			double __temp_13__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_14__ = (__temp_10__ + 4 * __temp_13__);
			double __temp_17__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_18__ = (__temp_14__ + 2 * __temp_17__) / 159;
			t2_1 += __temp_18__;
			// Bottom -1	
			double __temp_21__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_25__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_26__ = (4 * __temp_21__ + 9 * __temp_25__);
			double __temp_29__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_30__ = (__temp_26__ + 12 * __temp_29__);
			double __temp_33__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_34__ = (__temp_30__ + 9 * __temp_33__);
			double __temp_37__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_38__ = (__temp_34__ + 4 * __temp_37__) / 159;
			t2_0 += __temp_38__;
			// Mid
			double __temp_41__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_45__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_46__ = (5 * __temp_41__ + 12 * __temp_45__);
			double __temp_49__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_50__ = (__temp_46__ + 15 * __temp_49__);
			double __temp_53__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_54__ = (__temp_50__ + 12 * __temp_53__);
			double __temp_57__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_58__ = (__temp_54__ + 5 * __temp_57__) / 159;
			b2_0 += __temp_58__;
			// Top +1
			double __temp_61__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_65__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_66__ = (4 * __temp_61__ + 9 * __temp_65__);
			double __temp_69__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_70__ = (__temp_66__ + 12 * __temp_69__);
			double __temp_73__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_74__ = (__temp_70__ + 9 * __temp_73__);
			double __temp_77__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_78__ = (__temp_74__ + 4 * __temp_77__) / 159;
			b2_1 += __temp_78__;
			// Top +2
			double __temp_81__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_85__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_86__ = (2 * __temp_81__ + 4 * __temp_85__);
			double __temp_89__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_90__ = (__temp_86__ + 5 * __temp_89__);
			double __temp_93__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_94__ = (__temp_90__ + 4 * __temp_93__);
			double __temp_97__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_98__ = (__temp_94__ + 2 * __temp_97__) / 159;
			__tilevar_1__[__iter_3__-__iter_0__] += __temp_98__;
		}
		__syncthreads ();
		if(__iter_3__ >= FORMA_MAX((__iter_0__+4),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3))) {
			// Bottom -2
			double __temp_2__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_5__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
			double __temp_9__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_10__ = (__temp_6__ + 5 * __temp_9__);
			double __temp_13__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_14__ = (__temp_10__ + 4 * __temp_13__);
			double __temp_17__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_18__ = (__temp_14__ + 2 * __temp_17__) / 159;
			t3_1 += __temp_18__;
			// Bottom -1	
			double __temp_21__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_25__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_26__ = (4 * __temp_21__ + 9 * __temp_25__);
			double __temp_29__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_30__ = (__temp_26__ + 12 * __temp_29__);
			double __temp_33__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_34__ = (__temp_30__ + 9 * __temp_33__);
			double __temp_37__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_38__ = (__temp_34__ + 4 * __temp_37__) / 159;
			t3_0 += __temp_38__;
			// Mid
			double __temp_41__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_45__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_46__ = (5 * __temp_41__ + 12 * __temp_45__);
			double __temp_49__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_50__ = (__temp_46__ + 15 * __temp_49__);
			double __temp_53__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_54__ = (__temp_50__ + 12 * __temp_53__);
			double __temp_57__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_58__ = (__temp_54__ + 5 * __temp_57__) / 159;
			b3_0 += __temp_58__;
			// Top +1
			double __temp_61__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_65__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_66__ = (4 * __temp_61__ + 9 * __temp_65__);
			double __temp_69__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_70__ = (__temp_66__ + 12 * __temp_69__);
			double __temp_73__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_74__ = (__temp_70__ + 9 * __temp_73__);
			double __temp_77__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_78__ = (__temp_74__ + 4 * __temp_77__) / 159;
			b3_1 += __temp_78__;
			// Top +2
			double __temp_81__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_85__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_86__ = (2 * __temp_81__ + 4 * __temp_85__);
			double __temp_89__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_90__ = (__temp_86__ + 5 * __temp_89__);
			double __temp_93__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_94__ = (__temp_90__ + 4 * __temp_93__);
			double __temp_97__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_98__ = (__temp_94__ + 2 * __temp_97__) / 159;
			out += __temp_98__;
		}
		__syncthreads();
		// Now rotate
		__tilevar_1__[__iter_3__-__iter_0__] = b2_1; b2_1 = b2_0; b2_0=t2_0; t2_0=t2_1; t2_1=0.0f; 
		out=b3_1; b3_1=b3_0; b3_0=t3_0; t3_0=t3_1; t3_1=0.0f;
	}
	// Rest of the computation
	for (int __iter_1__ = __iter_y__+4; __iter_1__ <= FORMA_MIN(N-1,__iter_y__+FORMA_BLOCKDIM_Y+3); __iter_1__++) {
		if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
			__tilevar_0__[__iter_3__-__iter_0__] = input[__iter_3__+M*(__iter_1__)];
		}
		__syncthreads ();
		if(__iter_3__ >= FORMA_MAX((__iter_0__+2),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3))) {
			// Bottom -2
			double __temp_2__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_5__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
			double __temp_9__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_10__ = (__temp_6__ + 5 * __temp_9__);
			double __temp_13__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_14__ = (__temp_10__ + 4 * __temp_13__);
			double __temp_17__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_18__ = (__temp_14__ + 2 * __temp_17__) / 159;
			t2_1 += __temp_18__;
			// Bottom -1	
			double __temp_21__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_25__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_26__ = (4 * __temp_21__ + 9 * __temp_25__);
			double __temp_29__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_30__ = (__temp_26__ + 12 * __temp_29__);
			double __temp_33__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_34__ = (__temp_30__ + 9 * __temp_33__);
			double __temp_37__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_38__ = (__temp_34__ + 4 * __temp_37__) / 159;
			t2_0 += __temp_38__;
			// Mid
			double __temp_41__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_45__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_46__ = (5 * __temp_41__ + 12 * __temp_45__);
			double __temp_49__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_50__ = (__temp_46__ + 15 * __temp_49__);
			double __temp_53__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_54__ = (__temp_50__ + 12 * __temp_53__);
			double __temp_57__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_58__ = (__temp_54__ + 5 * __temp_57__) / 159;
			b2_0 += __temp_58__;
			// Top +1
			double __temp_61__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_65__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_66__ = (4 * __temp_61__ + 9 * __temp_65__);
			double __temp_69__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_70__ = (__temp_66__ + 12 * __temp_69__);
			double __temp_73__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_74__ = (__temp_70__ + 9 * __temp_73__);
			double __temp_77__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_78__ = (__temp_74__ + 4 * __temp_77__) / 159;
			b2_1 += __temp_78__;
			// Top +2
			double __temp_81__ = (__tilevar_0__[__iter_3__-2-__iter_0__]);
			double __temp_85__ = (__tilevar_0__[__iter_3__-1-__iter_0__]);
			double __temp_86__ = (2 * __temp_81__ + 4 * __temp_85__);
			double __temp_89__ = (__tilevar_0__[__iter_3__-__iter_0__]);
			double __temp_90__ = (__temp_86__ + 5 * __temp_89__);
			double __temp_93__ = (__tilevar_0__[__iter_3__+1-__iter_0__]);
			double __temp_94__ = (__temp_90__ + 4 * __temp_93__);
			double __temp_97__ = (__tilevar_0__[__iter_3__+2-__iter_0__]);
			double __temp_98__ = (__temp_94__ + 2 * __temp_97__) / 159;
			__tilevar_1__[__iter_3__-__iter_0__] += __temp_98__;
		}
		__syncthreads ();
		if(__iter_3__ >= FORMA_MAX((__iter_0__+4),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3))) {
			// Bottom -2
			double __temp_2__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_5__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
			double __temp_9__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_10__ = (__temp_6__ + 5 * __temp_9__);
			double __temp_13__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_14__ = (__temp_10__ + 4 * __temp_13__);
			double __temp_17__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_18__ = (__temp_14__ + 2 * __temp_17__) / 159;
			t3_1 += __temp_18__;
			// Bottom -1	
			double __temp_21__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_25__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_26__ = (4 * __temp_21__ + 9 * __temp_25__);
			double __temp_29__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_30__ = (__temp_26__ + 12 * __temp_29__);
			double __temp_33__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_34__ = (__temp_30__ + 9 * __temp_33__);
			double __temp_37__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_38__ = (__temp_34__ + 4 * __temp_37__) / 159;
			t3_0 += __temp_38__;
			// Mid
			double __temp_41__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_45__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_46__ = (5 * __temp_41__ + 12 * __temp_45__);
			double __temp_49__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_50__ = (__temp_46__ + 15 * __temp_49__);
			double __temp_53__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_54__ = (__temp_50__ + 12 * __temp_53__);
			double __temp_57__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_58__ = (__temp_54__ + 5 * __temp_57__) / 159;
			b3_0 += __temp_58__;
			// Top +1
			double __temp_61__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_65__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_66__ = (4 * __temp_61__ + 9 * __temp_65__);
			double __temp_69__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_70__ = (__temp_66__ + 12 * __temp_69__);
			double __temp_73__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_74__ = (__temp_70__ + 9 * __temp_73__);
			double __temp_77__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_78__ = (__temp_74__ + 4 * __temp_77__) / 159;
			b3_1 += __temp_78__;
			// Top +2
			double __temp_81__ = (__tilevar_1__[__iter_3__-2-__iter_0__]);
			double __temp_85__ = (__tilevar_1__[__iter_3__-1-__iter_0__]);
			double __temp_86__ = (2 * __temp_81__ + 4 * __temp_85__);
			double __temp_89__ = (__tilevar_1__[__iter_3__-__iter_0__]);
			double __temp_90__ = (__temp_86__ + 5 * __temp_89__);
			double __temp_93__ = (__tilevar_1__[__iter_3__+1-__iter_0__]);
			double __temp_94__ = (__temp_90__ + 4 * __temp_93__);
			double __temp_97__ = (__tilevar_1__[__iter_3__+2-__iter_0__]);
			double __temp_98__ = (__temp_94__ + 2 * __temp_97__) / 159;
			out += __temp_98__;
			__var_1__[__iter_3__+M*FORMA_MAX(__iter_1__-4,0)] = out;
		}
		__syncthreads();
		// Now rotate
		__tilevar_1__[__iter_3__-__iter_0__] = b2_1; b2_1 = b2_0; b2_0=t2_0; t2_0=t2_1; t2_1=0.0f; 
		out=b3_1; b3_1=b3_0; b3_0=t3_0; t3_0=t3_1; t3_1=0.0f;
	}
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
	int FORMA_BLOCKDIM_X = (int)(blockDim.x);
	int SMemSize = 0;
	SMemSize += sizeof(double)*(2*FORMA_BLOCKDIM_X);
	return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void gaussian(double * h_input, int N, int M, double * __var_0__){

	/* Host allocation Begin */
	double * input;
	cudaMalloc(&input,sizeof(double)*((N)*(M)));
	Check_CUDA_Error("Allocation Error!! : input\n");
	cudaPointerAttributes ptrAttrib_h_input;
	cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
	if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
		if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
			memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
	cudaGetLastError();
	if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
		cudaMemcpy(input,h_input,sizeof(double)*((N)*(M)), memcpy_kind_h_input);
	}
	double * __var_1__;
	cudaMalloc(&__var_1__,sizeof(double)*((N)*(M)));
	Check_CUDA_Error("Allocation Error!! : __var_1__\n");
	double * __var_2__;
	cudaMalloc(&__var_2__,sizeof(double)*((N)*(M)));
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
	int __size_0___kernel___forma_kernel__0__ = M;
	int __size_1___kernel___forma_kernel__0__ = N;

	int __block_0___kernel___forma_kernel__0__ = 128;
	int __block_1___kernel___forma_kernel__0__ = 1;
	dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
	int __SMemSize___kernel___forma_kernel__0__ = 0;
	__SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
	int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-8);
	int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__size_0___kernel___forma_kernel__0__/32);
	dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);

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

	for (int x=0; x<1000; x++) {
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __size_0___kernel___forma_kernel__0__/32, __var_2__);
		__kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __size_0___kernel___forma_kernel__0__/32, __var_1__);
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
	cudaMemcpy(__var_0__,__var_1__, sizeof(double)*((N)*(M)), memcpy_kind___var_0__);
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
