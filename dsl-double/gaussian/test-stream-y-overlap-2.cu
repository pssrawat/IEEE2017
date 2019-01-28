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

__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float * __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*((FORMA_BLOCKDIM_Y+16)*FORMA_BLOCKDIM_X);
  float * __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*((FORMA_BLOCKDIM_Y+16)*FORMA_BLOCKDIM_X);
  int rowy = FORMA_BLOCKDIM_Y+16;

  int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X-8);
  for (int __iter_1__ = 0; __iter_1__ <= N-1; __iter_1__ += FORMA_BLOCKDIM_Y) {
    int __iter_2__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
    int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
    if(__iter_2__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-1)) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){
      __tilevar_0__[__iter_3__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_2__,rowy)] = input[__iter_3__+M*__iter_2__];
    }
    __syncthreads();
    int __iter_4__ = FORMA_MAX((__iter_1__-2),2) + (int)(threadIdx.y) ; 
    if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
      int __iter_5__ = FORMA_MAX((__iter_0__+2),2) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3)) ){
        float __temp_2__ = (__tilevar_0__[__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-2,rowy)]);
        float __temp_5__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-2,rowy)]);
        float __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
        float __temp_9__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-2,rowy)]);
        float __temp_10__ = (__temp_6__ + 5 * __temp_9__);
        float __temp_13__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-2,rowy)]);
        float __temp_14__ = (__temp_10__ + 4 * __temp_13__);
        float __temp_17__ = (__tilevar_0__[__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-2,rowy)]);
        float __temp_18__ = (__temp_14__ + 2 * __temp_17__);
        float __temp_21__ = (__tilevar_0__[__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-1,rowy)]);
        float __temp_22__ = (__temp_18__ + 4 * __temp_21__);
        float __temp_25__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-1,rowy)]);
        float __temp_26__ = (__temp_22__ + 9 * __temp_25__);
        float __temp_29__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-1,rowy)]);
        float __temp_30__ = (__temp_26__ + 12 * __temp_29__);
        float __temp_33__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-1,rowy)]);
        float __temp_34__ = (__temp_30__ + 9 * __temp_33__);
        float __temp_37__ = (__tilevar_0__[__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__-1,rowy)]);
        float __temp_38__ = (__temp_34__ + 4 * __temp_37__);
        float __temp_41__ = (__tilevar_0__[__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_42__ = (__temp_38__ + 5 * __temp_41__);
        float __temp_45__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_46__ = (__temp_42__ + 12 * __temp_45__);
        float __temp_49__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_50__ = (__temp_46__ + 15 * __temp_49__);
        float __temp_53__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_54__ = (__temp_50__ + 12 * __temp_53__);
        float __temp_57__ = (__tilevar_0__[__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_58__ = (__temp_54__ + 5 * __temp_57__);
        float __temp_61__ = (__tilevar_0__[__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+1,rowy)]);
        float __temp_62__ = (__temp_58__ + 4 * __temp_61__);
        float __temp_65__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+1,rowy)]);
        float __temp_66__ = (__temp_62__ + 9 * __temp_65__);
        float __temp_69__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+1,rowy)]);
        float __temp_70__ = (__temp_66__ + 12 * __temp_69__);
        float __temp_73__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+1,rowy)]);
        float __temp_74__ = (__temp_70__ + 9 * __temp_73__);
        float __temp_77__ = (__tilevar_0__[__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+1,rowy)]);
        float __temp_78__ = (__temp_74__ + 4 * __temp_77__);
        float __temp_81__ = (__tilevar_0__[__iter_5__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+2,rowy)]);
        float __temp_82__ = (__temp_78__ + 2 * __temp_81__);
        float __temp_85__ = (__tilevar_0__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+2,rowy)]);
        float __temp_86__ = (__temp_82__ + 4 * __temp_85__);
        float __temp_89__ = (__tilevar_0__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+2,rowy)]);
        float __temp_90__ = (__temp_86__ + 5 * __temp_89__);
        float __temp_93__ = (__tilevar_0__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+2,rowy)]);
        float __temp_94__ = (__temp_90__ + 4 * __temp_93__);
        float __temp_97__ = (__tilevar_0__[__iter_5__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__+2,rowy)]);
        float __temp_98__ = (__temp_94__ + 2 * __temp_97__);
        float __temp_99__ = (__temp_98__ / 159);
        __tilevar_1__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)] = __temp_99__;
      }
    }
    __syncthreads();
    int __iter_10__ = FORMA_MAX((__iter_1__-4),2) + (int)(threadIdx.y) ; 
    if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-3)) ){
      int __iter_11__ = FORMA_MAX((__iter_0__+4),2) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3)) ){
        float __temp_2__ = (__tilevar_1__[__iter_11__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-2,rowy)]);
        float __temp_5__ = (__tilevar_1__[__iter_11__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-2,rowy)]);
        float __temp_6__ = (2 * __temp_2__ + 4 * __temp_5__);
        float __temp_9__ = (__tilevar_1__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-2,rowy)]);
        float __temp_10__ = (__temp_6__ + 5 * __temp_9__);
        float __temp_13__ = (__tilevar_1__[__iter_11__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-2,rowy)]);
        float __temp_14__ = (__temp_10__ + 4 * __temp_13__);
        float __temp_17__ = (__tilevar_1__[__iter_11__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-2,rowy)]);
        float __temp_18__ = (__temp_14__ + 2 * __temp_17__);
        float __temp_21__ = (__tilevar_1__[__iter_11__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-1,rowy)]);
        float __temp_22__ = (__temp_18__ + 4 * __temp_21__);
        float __temp_25__ = (__tilevar_1__[__iter_11__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-1,rowy)]);
        float __temp_26__ = (__temp_22__ + 9 * __temp_25__);
        float __temp_29__ = (__tilevar_1__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-1,rowy)]);
        float __temp_30__ = (__temp_26__ + 12 * __temp_29__);
        float __temp_33__ = (__tilevar_1__[__iter_11__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-1,rowy)]);
        float __temp_34__ = (__temp_30__ + 9 * __temp_33__);
        float __temp_37__ = (__tilevar_1__[__iter_11__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__-1,rowy)]);
        float __temp_38__ = (__temp_34__ + 4 * __temp_37__);
        float __temp_41__ = (__tilevar_1__[__iter_11__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_42__ = (__temp_38__ + 5 * __temp_41__);
        float __temp_45__ = (__tilevar_1__[__iter_11__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_46__ = (__temp_42__ + 12 * __temp_45__);
        float __temp_49__ = (__tilevar_1__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_50__ = (__temp_46__ + 15 * __temp_49__);
        float __temp_53__ = (__tilevar_1__[__iter_11__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_54__ = (__temp_50__ + 12 * __temp_53__);
        float __temp_57__ = (__tilevar_1__[__iter_11__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_58__ = (__temp_54__ + 5 * __temp_57__);
        float __temp_61__ = (__tilevar_1__[__iter_11__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+1,rowy)]);
        float __temp_62__ = (__temp_58__ + 4 * __temp_61__);
        float __temp_65__ = (__tilevar_1__[__iter_11__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+1,rowy)]);
        float __temp_66__ = (__temp_62__ + 9 * __temp_65__);
        float __temp_69__ = (__tilevar_1__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+1,rowy)]);
        float __temp_70__ = (__temp_66__ + 12 * __temp_69__);
        float __temp_73__ = (__tilevar_1__[__iter_11__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+1,rowy)]);
        float __temp_74__ = (__temp_70__ + 9 * __temp_73__);
        float __temp_77__ = (__tilevar_1__[__iter_11__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+1,rowy)]);
        float __temp_78__ = (__temp_74__ + 4 * __temp_77__);
        float __temp_81__ = (__tilevar_1__[__iter_11__-2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+2,rowy)]);
        float __temp_82__ = (__temp_78__ + 2 * __temp_81__);
        float __temp_85__ = (__tilevar_1__[__iter_11__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+2,rowy)]);
        float __temp_86__ = (__temp_82__ + 4 * __temp_85__);
        float __temp_89__ = (__tilevar_1__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+2,rowy)]);
        float __temp_90__ = (__temp_86__ + 5 * __temp_89__);
        float __temp_93__ = (__tilevar_1__[__iter_11__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+2,rowy)]);
        float __temp_94__ = (__temp_90__ + 4 * __temp_93__);
        float __temp_97__ = (__tilevar_1__[__iter_11__+2-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__+2,rowy)]);
        float __temp_98__ = (__temp_94__ + 2 * __temp_97__);
        float __temp_99__ = (__temp_98__ / 159);
        __var_1__[__iter_11__+(M)*(__iter_10__)] = __temp_99__;
      }
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(2*(FORMA_BLOCKDIM_Y+16)*FORMA_BLOCKDIM_X);
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void gaussian(float * h_input, int N, int M, float * __var_0__){

/* Host allocation Begin */
  float * input;
  cudaMalloc(&input,sizeof(float)*((N)*(M)));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(float)*((N)*(M)), memcpy_kind_h_input);
  }
  float * __var_1__;
  cudaMalloc(&__var_1__,sizeof(float)*((N)*(M)));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  float * __var_2__;
  cudaMalloc(&__var_2__,sizeof(float)*((N)*(M)));
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
  int __size_0___kernel___forma_kernel__0__ = ((M-1) - 0 ) + 1;
  int __block_0___kernel___forma_kernel__0__ = 32;
  int __block_1___kernel___forma_kernel__0__ = 16;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-8);
  int __grid_1___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_2__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (__var_2__, N, M, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(float)*((N)*(M)), memcpy_kind___var_0__);
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
