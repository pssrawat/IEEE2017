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
/* X, Y, Z */
__global__ void __kernel___forma_kernel__0__(double * __restrict__ input, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, double * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  double* __tilevar_0__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  double* __tilevar_1__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)-4);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)-4);
  double t2=0.0f, t3=0.0f, out = 0.0f;
  double b2=0.0f, b3=0.0f;

  // Initialize the values
  int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
      __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = 0.0f;
  }
  // Rest of the computation
  for (int __iter_2__ = 0; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1))){
        __tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = input[__iter_5__+N*(__iter_4__+M*(__iter_2__))]; 
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))){
	// Bottom 
	double __temp_3__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_7__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_8__ = (0.5f * __temp_3__ + 0.7f *__temp_7__);
        double __temp_12__ = (__tilevar_0__[ __iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_13__ = (__temp_8__ + 0.9f * __temp_12__);
        double __temp_17__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_18__ = (__temp_13__ + 1.2f * __temp_17__);
        double __temp_22__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_23__ = (__temp_18__ + 1.5f * __temp_22__);
        double __temp_27__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_28__ = (__temp_23__ + 1.2f * __temp_27__);
        double __temp_32__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_33__ = (__temp_28__ + 0.9f * __temp_32__);
        double __temp_37__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_38__ = (__temp_33__ + 0.7f * __temp_37__);
        double __temp_42__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_43__ = (__temp_38__ + 0.5f * __temp_42__) / 159;
	t2 += __temp_43__;
	//Mid 
        double __temp_47__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_52__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_53__ = (0.51f * __temp_47__ + 0.71f * __temp_52__);
        double __temp_57__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_58__ = (__temp_53__ + 0.91f * __temp_57__);
        double __temp_62__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_63__ = (__temp_58__ + 1.21f * __temp_62__);
        double __temp_67__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_68__ = (__temp_63__ + 1.51f * __temp_67__);
        double __temp_72__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_73__ = (__temp_68__ + 1.21f * __temp_72__);
        double __temp_77__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_78__ = (__temp_73__ + 0.91f * __temp_77__);
        double __temp_82__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_83__ = (__temp_78__ + 0.71f * __temp_82__);
        double __temp_87__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_88__ = (__temp_83__ + 0.51f * __temp_87__) / 159;
	b2 += __temp_88__;	
	// Top
        double __temp_92__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_97__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_98__ = (0.52f * __temp_92__ + 0.72f * __temp_97__);
        double __temp_102__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_103__ = (__temp_98__ + 0.92f * __temp_102__);
        double __temp_107__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_108__ = (__temp_103__ + 1.22f * __temp_107__);
        double __temp_112__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_113__ = (__temp_108__ + 1.52f * __temp_112__);
        double __temp_117__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_118__ = (__temp_113__ + 1.22f * __temp_117__);
        double __temp_122__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_123__ = (__temp_118__ + 0.92f * __temp_122__);
        double __temp_127__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_128__ = (__temp_123__ + 0.72f * __temp_127__);
        double __temp_132__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_133__ = (__temp_128__ + 0.52f * __temp_132__) / 159;
        __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] += __temp_133__;
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+2),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))){
	double __temp_3__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_7__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_8__ = (0.5f * __temp_3__ + 0.7f *__temp_7__);
        double __temp_12__ = (__tilevar_1__[ __iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_13__ = (__temp_8__ + 0.9f * __temp_12__);
        double __temp_17__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_18__ = (__temp_13__ + 1.2f * __temp_17__);
        double __temp_22__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_23__ = (__temp_18__ + 1.5f * __temp_22__);
        double __temp_27__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_28__ = (__temp_23__ + 1.2f * __temp_27__);
        double __temp_32__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_33__ = (__temp_28__ + 0.9f * __temp_32__);
        double __temp_37__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_38__ = (__temp_33__ + 0.7f * __temp_37__);
        double __temp_42__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_43__ = (__temp_38__ + 0.5f * __temp_42__) / 159;
	t3 += __temp_43__;
	//Mid 
        double __temp_47__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_52__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_53__ = (0.51f * __temp_47__ + 0.71f * __temp_52__);
        double __temp_57__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_58__ = (__temp_53__ + 0.91f * __temp_57__);
        double __temp_62__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_63__ = (__temp_58__ + 1.21f * __temp_62__);
        double __temp_67__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_68__ = (__temp_63__ + 1.51f * __temp_67__);
        double __temp_72__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_73__ = (__temp_68__ + 1.21f * __temp_72__);
        double __temp_77__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_78__ = (__temp_73__ + 0.91f * __temp_77__);
        double __temp_82__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_83__ = (__temp_78__ + 0.71f * __temp_82__);
        double __temp_87__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_88__ = (__temp_83__ + 0.51f * __temp_87__) / 159;
	b3 += __temp_88__;	
	// Top
        double __temp_92__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_97__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_98__ = (0.52f * __temp_92__ + 0.72f * __temp_97__);
        double __temp_102__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        double __temp_103__ = (__temp_98__ + 0.92f * __temp_102__);
        double __temp_107__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_108__ = (__temp_103__ + 1.22f * __temp_107__);
        double __temp_112__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_113__ = (__temp_108__ + 1.52f * __temp_112__);
        double __temp_117__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        double __temp_118__ = (__temp_113__ + 1.22f * __temp_117__);
        double __temp_122__ = (__tilevar_1__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_123__ = (__temp_118__ + 0.92f * __temp_122__);
        double __temp_127__ = (__tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_128__ = (__temp_123__ + 0.72f * __temp_127__);
        double __temp_132__ = (__tilevar_1__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        double __temp_133__ = (__temp_128__ + 0.52f * __temp_132__) / 159;
	out += __temp_133__;
        __var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-2,0))] = out;
    }
    __syncthreads ();
    // Now rotate 
    __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = b2;
    b2 = t2;
    t2 = 0.0;
    out= b3; 
    b3 = t3;
    t3 = 0.0;
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(double)*(2*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d27pt(double * h_input, int L, int M, int N, double * __var_0__){

/* Host allocation Begin */
  double * input;
  cudaMalloc(&input,sizeof(double)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(double)*(L*M*N), memcpy_kind_h_input);
  }

  double * __var_1__;
  cudaMalloc(&__var_1__,sizeof(double)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  double * __var_2__;
  cudaMalloc(&__var_2__,sizeof(double)*(L*M*N));
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
  int __size_0___kernel___forma_kernel__0__ = N;
  int __size_1___kernel___forma_kernel__0__ = M;
  int __block_0___kernel___forma_kernel__0__ = 32;
  int __block_1___kernel___forma_kernel__0__ = 16;
  int __block_2___kernel___forma_kernel__0__ = 1;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-4);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y-4);
  int __grid_2___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  dim3 unrollConfig (__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(double)*(L*M*N), memcpy_kind___var_0__);
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
