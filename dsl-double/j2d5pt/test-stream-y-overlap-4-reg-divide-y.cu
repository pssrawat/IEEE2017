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

void Check_CUDA_Error(const char* message);
/*Texture references */
/*Shared Memory Variable */
extern __shared__ char __FORMA_SHARED_MEM__[];
/* Device code Begin */

__global__ void __kernel___forma_kernel__0__(double * __restrict__ input, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, double * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  double * __tilevar_2__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_X);
  double * __tilevar_3__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_X);
  double * __tilevar_4__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_X);
  double * __tilevar_5__ = (double*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(double)*(FORMA_BLOCKDIM_X);
  double t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  double b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;
  int __iter_0__ = (int)(blockIdx.x)*(int)(FORMA_BLOCKDIM_X-8);
  int __iter_y__ = FORMA_MAX((int)(blockIdx.y)*(int)(FORMA_BLOCKDIM_Y)-4, 0);
  // Initialize the values
  int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
    __tilevar_2__[__iter_3__-__iter_0__] = input[__iter_3__+M*__iter_y__];
    t2 = input[__iter_3__+M*(__iter_y__+1)]; 
  }

  // Initial computation
  for (int __iter_1__ = FORMA_MAX(1,__iter_y__+1); __iter_1__ < FORMA_MIN(N-1,__iter_y__+7); __iter_1__++) {
    if(__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){
      b2 = __tilevar_2__[__iter_3__-__iter_0__];
      __tilevar_2__[__iter_3__-__iter_0__] = t2;
      t2 = input[__iter_3__+M*(__iter_1__+1)];  
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+1),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      double __temp_2__ = b2;
      double __temp_5__ = (__tilevar_2__[__iter_3__-1-__iter_0__]);
      double __temp_6__ = (5 * __temp_2__ + 12 * __temp_5__);
      double __temp_9__ = (__tilevar_2__[__iter_3__-__iter_0__]);
      double __temp_10__ = (__temp_6__ + 15 * __temp_9__);
      double __temp_13__ = (__tilevar_2__[__iter_3__+1-__iter_0__]);
      double __temp_14__ = (__temp_10__ + 12 * __temp_13__);
      double __temp_17__ = t2;
      double __temp_18__ = (__temp_14__ + 5 * __temp_17__);
      double __temp_19__ = (__temp_18__ / 118);
      b3 = __tilevar_3__[__iter_3__-__iter_0__];
      __tilevar_3__[__iter_3__-__iter_0__] = t3;
      t3 = __temp_19__;
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+2),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      double __temp_32__ = b3;
      double __temp_35__ = (__tilevar_3__[__iter_3__+(-1)-__iter_0__]);
      double __temp_36__ = (5 * __temp_32__ + 12 * __temp_35__);
      double __temp_39__ = (__tilevar_3__[__iter_3__-__iter_0__]);
      double __temp_40__ = (__temp_36__ + 15 * __temp_39__);
      double __temp_43__ = (__tilevar_3__[__iter_3__+1-__iter_0__]);
      double __temp_44__ = (__temp_40__ + 12 * __temp_43__);
      double __temp_47__ = t3;
      double __temp_48__ = (__temp_44__ + 5 * __temp_47__);
      double __temp_49__ = (__temp_48__ / 118);
      b4 = __tilevar_4__[__iter_3__-__iter_0__];
      __tilevar_4__[__iter_3__-__iter_0__] = t4;
      t4 = __temp_49__;
    }
    __syncthreads ();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+3),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      double __temp_60__ = b4;
      double __temp_61__ = (__tilevar_4__[__iter_3__+(-1)-__iter_0__]);
      double __temp_62__ = (5 * __temp_60__ + 12 * __temp_61__);
      double __temp_63__ = (__tilevar_4__[__iter_3__-__iter_0__]);
      double __temp_64__ = (__temp_62__ + 15 * __temp_63__);
      double __temp_65__ = (__tilevar_4__[__iter_3__+1-__iter_0__]);
      double __temp_66__ = (__temp_64__ + 12 * __temp_65__);
      double __temp_67__ = t4;
      double __temp_68__ = (__temp_66__ + 5 * __temp_67__);
      double __temp_69__ = (__temp_68__ / 118);
      b5 = __tilevar_5__[__iter_3__-__iter_0__];
      __tilevar_5__[__iter_3__-__iter_0__] = t5;
      t5 = __temp_69__;
    }
  }
  // Rest of the computation
  for (int __iter_1__ = FORMA_MAX(1,__iter_y__+7); __iter_1__ < FORMA_MIN(N-1,__iter_y__+FORMA_BLOCKDIM_Y+8); __iter_1__++) {
    if(__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){
      b2 = __tilevar_2__[__iter_3__-__iter_0__];
      __tilevar_2__[__iter_3__-__iter_0__] = t2;
      t2 = input[__iter_3__+M*(__iter_1__+1)];  
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+1),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      double __temp_2__ = b2;
      double __temp_5__ = (__tilevar_2__[__iter_3__-1-__iter_0__]);
      double __temp_6__ = (5 * __temp_2__ + 12 * __temp_5__);
      double __temp_9__ = (__tilevar_2__[__iter_3__-__iter_0__]);
      double __temp_10__ = (__temp_6__ + 15 * __temp_9__);
      double __temp_13__ = (__tilevar_2__[__iter_3__+1-__iter_0__]);
      double __temp_14__ = (__temp_10__ + 12 * __temp_13__);
      double __temp_17__ = t2;
      double __temp_18__ = (__temp_14__ + 5 * __temp_17__);
      double __temp_19__ = (__temp_18__ / 118);
      b3 = __tilevar_3__[__iter_3__-__iter_0__];
      __tilevar_3__[__iter_3__-__iter_0__] = t3;
      t3 = __temp_19__;
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+2),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      double __temp_32__ = b3;
      double __temp_35__ = (__tilevar_3__[__iter_3__+(-1)-__iter_0__]);
      double __temp_36__ = (5 * __temp_32__ + 12 * __temp_35__);
      double __temp_39__ = (__tilevar_3__[__iter_3__-__iter_0__]);
      double __temp_40__ = (__temp_36__ + 15 * __temp_39__);
      double __temp_43__ = (__tilevar_3__[__iter_3__+1-__iter_0__]);
      double __temp_44__ = (__temp_40__ + 12 * __temp_43__);
      double __temp_47__ = t3;
      double __temp_48__ = (__temp_44__ + 5 * __temp_47__);
      double __temp_49__ = (__temp_48__ / 118);
      b4 = __tilevar_4__[__iter_3__-__iter_0__];
      __tilevar_4__[__iter_3__-__iter_0__] = t4;
      t4 = __temp_49__;
    }
    __syncthreads ();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+3),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      double __temp_60__ = b4;
      double __temp_61__ = (__tilevar_4__[__iter_3__+(-1)-__iter_0__]);
      double __temp_62__ = (5 * __temp_60__ + 12 * __temp_61__);
      double __temp_63__ = (__tilevar_4__[__iter_3__-__iter_0__]);
      double __temp_64__ = (__temp_62__ + 15 * __temp_63__);
      double __temp_65__ = (__tilevar_4__[__iter_3__+1-__iter_0__]);
      double __temp_66__ = (__temp_64__ + 12 * __temp_65__);
      double __temp_67__ = t4;
      double __temp_68__ = (__temp_66__ + 5 * __temp_67__);
      double __temp_69__ = (__temp_68__ / 118);
      b5 = __tilevar_5__[__iter_3__-__iter_0__];
      __tilevar_5__[__iter_3__-__iter_0__] = t5;
      t5 = __temp_69__;
    }
    __syncthreads ();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+4),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
      double __temp_80__ = b5;
      double __temp_81__ = (__tilevar_5__[__iter_3__+(-1)-__iter_0__]);
      double __temp_82__ = (5 * __temp_80__ + 12 * __temp_81__);
      double __temp_83__ = (__tilevar_5__[__iter_3__-__iter_0__]);
      double __temp_84__ = (__temp_82__ + 15 * __temp_83__);
      double __temp_85__ = (__tilevar_5__[__iter_3__+1-__iter_0__]);
      double __temp_86__ = (__temp_84__ + 12 * __temp_85__);
      double __temp_87__ = t5;
      double __temp_88__ = (__temp_86__ + 5 * __temp_87__);
      double __temp_89__ = (__temp_88__ / 118);
      __var_1__[__iter_3__+(M)*FORMA_MAX(__iter_1__-3,0)] = __temp_89__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(double)*(4*FORMA_BLOCKDIM_X);
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(double * h_input, int N, int M, double * __var_0__){

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
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__, __size_1___kernel___forma_kernel__0__/128);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __size_1___kernel___forma_kernel__0__/128, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

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
}
/*Host Free End*/
