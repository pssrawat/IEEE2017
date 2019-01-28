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

void Check_CUDA_Error(const char* message);
/*Texture references */
/*Shared Memory Variable */
extern __shared__ char __FORMA_SHARED_MEM__[];
/* Device code Begin */

__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float * __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);

  float t2_0=0.0f, t2_1=0.0f, t3_0=0.0f, t3_1=0.0f, t4_0=0.0f, t4_1=0.0f, t5_0=0.0f, t5_1=0.0f;
  float b2_0=0.0f, b2_1=0.0f, b3_0=0.0f, b3_1=0.0f, b4_0=0.0f, b4_1=0.0f, b5_0=0.0f, b5_1=0.0f;
  int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X-16);
  int __iter_y__ = FORMA_MAX((int)(blockIdx.y)*FORMA_BLOCKDIM_Y-8, 0);

  //Initialize the values
  int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if(__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){ 
    b2_0 = input[__iter_3__+M*__iter_y__];
    __tilevar_2__[__iter_3__-__iter_0__] = input[__iter_3__+M*(__iter_y__+1)];
    t2_0 = input[__iter_3__+M*(__iter_y__+2)];
    t2_1 = input[__iter_3__+M*(__iter_y__+3)];
  }
  // Initial computation
  for (int __iter_1__ = __iter_y__+2; __iter_1__ < FORMA_MIN(N-2,__iter_y__+14); __iter_1__++) {
    if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
	b2_1 = b2_0;
      	b2_0 = __tilevar_2__[__iter_3__-__iter_0__]; 
      	__tilevar_2__[__iter_3__-__iter_0__] = t2_0;
      	t2_0 = t2_1;
	t2_1 = input[__iter_3__+M*(__iter_1__+2)];
    }
    __syncthreads ();
    if (__iter_3__ >= FORMA_MAX((__iter_0__+2),2) &  __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3)) ){
        float __temp_a__ = b2_1;
        float __temp_2__ = b2_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_2__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_2__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_2__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_2__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_2__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t2_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t2_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
	b3_1 = b3_0;
	b3_0 = __tilevar_3__[__iter_3__-__iter_0__];   
        __tilevar_3__[__iter_3__-__iter_0__] = t3_0;
	t3_0 = t3_1;
	t3_1 = __temp_19__;
    }
    __syncthreads();
    if (__iter_3__ >= FORMA_MAX((__iter_0__+4),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3))) {
        float __temp_a__ = b3_1;
        float __temp_2__ = b3_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_3__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_3__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_3__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_3__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_3__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t3_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t3_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
	b4_1 = b4_0;
	b4_0 = __tilevar_4__[__iter_3__-__iter_0__];   
        __tilevar_4__[__iter_3__-__iter_0__] = t4_0;
	t4_0 = t4_1;
	t4_1 = __temp_19__;
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+6),2) &  __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-7),(M-3))) {
        float __temp_a__ = b4_1;
        float __temp_2__ = b4_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_4__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_4__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_4__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_4__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_4__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t4_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t4_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
	b5_1 = b5_0;
	b5_0 = __tilevar_5__[__iter_3__-__iter_0__];   
        __tilevar_5__[__iter_3__-__iter_0__] = t5_0;
	t5_0 = t5_1;
	t5_1 = __temp_19__;
    }
  }
  // Rest of the computation
  for (int __iter_1__ = FORMA_MAX(2,__iter_y__+14); __iter_1__ < FORMA_MIN(N-2,__iter_y__+FORMA_BLOCKDIM_Y+14); __iter_1__++) {
    if (__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))) {
	b2_1 = b2_0;
      	b2_0 = __tilevar_2__[__iter_3__-__iter_0__]; 
      	__tilevar_2__[__iter_3__-__iter_0__] = t2_0;
      	t2_0 = t2_1;
	t2_1 = input[__iter_3__+M*(__iter_1__+2)];
    }
    __syncthreads ();
    if (__iter_3__ >= FORMA_MAX((__iter_0__+2),2) &  __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-3)) ){
        float __temp_a__ = b2_1;
        float __temp_2__ = b2_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_2__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_2__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_2__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_2__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_2__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t2_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t2_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
	b3_1 = b3_0;
	b3_0 = __tilevar_3__[__iter_3__-__iter_0__];   
        __tilevar_3__[__iter_3__-__iter_0__] = t3_0;
	t3_0 = t3_1;
	t3_1 = __temp_19__;
    }
    __syncthreads();
    if (__iter_3__ >= FORMA_MAX((__iter_0__+4),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-3))) {
        float __temp_a__ = b3_1;
        float __temp_2__ = b3_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_3__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_3__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_3__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_3__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_3__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t3_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t3_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
	b4_1 = b4_0;
	b4_0 = __tilevar_4__[__iter_3__-__iter_0__];   
        __tilevar_4__[__iter_3__-__iter_0__] = t4_0;
	t4_0 = t4_1;
	t4_1 = __temp_19__;
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+6),2) &  __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-7),(M-3))) {
        float __temp_a__ = b4_1;
        float __temp_2__ = b4_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_4__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_4__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_4__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_4__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_4__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t4_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t4_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
	b5_1 = b5_0;
	b5_0 = __tilevar_5__[__iter_3__-__iter_0__];   
        __tilevar_5__[__iter_3__-__iter_0__] = t5_0;
	t5_0 = t5_1;
	t5_1 = __temp_19__;
    }
    __syncthreads();
    if (__iter_3__ >= FORMA_MAX((__iter_0__+8),2) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-9),(M-3))){
	float __temp_a__ = b5_1;
        float __temp_2__ = b5_0;
        float __temp_b__ = (7 * __temp_a__ + 5 * __temp_2__);
        float __temp_c__ = (__tilevar_5__[__iter_3__-2-__iter_0__]);
        float __temp_d__ = (__temp_b__ + 9 * __temp_c__);
        float __temp_5__ = (__tilevar_5__[__iter_3__-1-__iter_0__]);
        float __temp_6__ = (__temp_d__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_5__[__iter_3__-__iter_0__]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_5__[__iter_3__+1-__iter_0__]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_e__ =  (__tilevar_5__[__iter_3__+2-__iter_0__]);
        float __temp_f__ = (__temp_14__ + 9 * __temp_e__);
        float __temp_17__ = t5_0;
        float __temp_18__ = (__temp_f__ + 5 * __temp_17__);
        float __temp_g__ = t5_1;
        float __temp_h__ = (__temp_18__ + 7 * __temp_g__);
        float __temp_19__ = (__temp_h__ / 118);
        __var_1__[__iter_3__+M*FORMA_MAX(__iter_1__-6,0)] = __temp_19__;
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(4*FORMA_BLOCKDIM_X);
  return SMemSize;
}

/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(float * h_input, int N, int M, float * __var_0__){

/* Host allocation Begin */
  float * input;
  cudaMalloc(&input,sizeof(float)*(N*M));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(float)*(N*M), memcpy_kind_h_input);
  }
  float * __var_1__;
  cudaMalloc(&__var_1__,sizeof(float)*(N*M));
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
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-16);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__, __size_1___kernel___forma_kernel__0__/64);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __blockConfig___kernel___forma_kernel__0__.x, __size_1___kernel___forma_kernel__0__/64, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(float)*(N*M), memcpy_kind___var_0__);
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
