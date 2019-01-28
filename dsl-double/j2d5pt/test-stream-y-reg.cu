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
#define GAPX (118) 
#define EXTENT (5)

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
  float * __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X + GAPX);
  float t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  float b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;

  // Initialize the value
  int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if(__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){
     __tilevar_2__[__iter_3__-__iter_0__] = input[__iter_3__+M*0];
     t2 = input[__iter_3__+M*1];
  }
  // Rest of the computation
  for (int __iter_1__ = 1; __iter_1__ <= N-1; __iter_1__++) {
    if(__iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1))){
      b2 = __tilevar_2__[__iter_3__-__iter_0__];
      __tilevar_2__[__iter_3__-__iter_0__] = t2; 
      t2 = input[__iter_3__+M*(__iter_1__+1)];
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+1),1) &  __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      float __temp_2__ = b2;
      float __temp_5__ = (__tilevar_2__[__iter_3__-1-__iter_0__]);
      float __temp_6__ = (5 * __temp_2__ + 12 * __temp_5__);
      float __temp_9__ = (__tilevar_2__[__iter_3__-__iter_0__]);
      float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
      float __temp_13__ = (__tilevar_2__[__iter_3__+1-__iter_0__]);
      float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
      float __temp_17__ = t2;
      float __temp_18__ = (__temp_14__ + 5 * __temp_17__);
      float __temp_19__ = (__temp_18__ / 118);
      b3 = __tilevar_3__[__iter_3__-__iter_0__];
      __tilevar_3__[__iter_3__-__iter_0__] = t3;
      t3 = __temp_19__;
      //printf ("var0[%d][%d] = %.6f\n", __iter_1__, __iter_3__, t3);
    }
    if(__iter_3__ >= FORMA_MAX((__iter_0__+1),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      if (__iter_3__ < (FORMA_MAX((__iter_0__+1),1)+2) | __iter_3__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2))-2)) {
        __copy_arr_0__[__iter_1__+(M)*(__iter_3__)] = t3;
      }
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+2),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      float __temp_32__ = b3;
      float __temp_35__ = (__tilevar_3__[__iter_3__+(-1)-__iter_0__]);
      float __temp_36__ = (5 * __temp_32__ + 12 * __temp_35__);
      float __temp_39__ = (__tilevar_3__[__iter_3__-__iter_0__]);
      float __temp_40__ = (__temp_36__ + 15 * __temp_39__);
      float __temp_43__ = (__tilevar_3__[__iter_3__+1-__iter_0__]);
      float __temp_44__ = (__temp_40__ + 12 * __temp_43__);
      float __temp_47__ = t3;
      float __temp_48__ = (__temp_44__ + 5 * __temp_47__);
      float __temp_49__ = (__temp_48__ / 118);
      b4 = __tilevar_4__[__iter_3__-__iter_0__];
      __tilevar_4__[__iter_3__-__iter_0__] = t4;
      t4 = __temp_49__;
      //printf ("var1[%d][%d] = %.6f\n", __iter_1__-1, __iter_3__, t4);
    }
    if(__iter_3__ >= FORMA_MAX((__iter_0__+2),1) &  __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      if (__iter_3__ < (FORMA_MAX((__iter_0__+2),1)+2) | __iter_3__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2))-2)) {
        __copy_arr_1__[__iter_1__+(M)*(__iter_3__)] = t4;
      }
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+3),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      float __temp_60__ = b4;
      float __temp_61__ = (__tilevar_4__[__iter_3__+(-1)-__iter_0__]);
      float __temp_62__ = (5 * __temp_60__ + 12 * __temp_61__);
      float __temp_63__ = (__tilevar_4__[__iter_3__-__iter_0__]);
      float __temp_64__ = (__temp_62__ + 15 * __temp_63__);
      float __temp_65__ = (__tilevar_4__[__iter_3__+1-__iter_0__]);
      float __temp_66__ = (__temp_64__ + 12 * __temp_65__);
      float __temp_67__ = t4;
      float __temp_68__ = (__temp_66__ + 5 * __temp_67__);
      float __temp_69__ = (__temp_68__ / 118);
      b5 = __tilevar_5__[__iter_3__-__iter_0__];
      __tilevar_5__[__iter_3__-__iter_0__] = t5;
      t5 = __temp_69__;
      //printf ("var2[%d][%d] = %.6f\n", __iter_1__-2, __iter_3__, t5);
    }
    if(__iter_3__ >= FORMA_MAX((__iter_0__+3),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      if (__iter_3__ < (FORMA_MAX((__iter_0__+3),1)+2) | __iter_3__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2))-2)) {
        __copy_arr_2__[__iter_1__+(M)*(__iter_3__)] = t5;
      }
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__+4),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
      float __temp_80__ = b5;
      float __temp_81__ = (__tilevar_5__[__iter_3__+(-1)-__iter_0__]);
      float __temp_82__ = (5 * __temp_80__ + 12 * __temp_81__);
      float __temp_83__ = (__tilevar_5__[__iter_3__-__iter_0__]);
      float __temp_84__ = (__temp_82__ + 15 * __temp_83__);
      float __temp_85__ = (__tilevar_5__[__iter_3__+1-__iter_0__]);
      float __temp_86__ = (__temp_84__ + 12 * __temp_85__);
      float __temp_87__ = t5;
      float __temp_88__ = (__temp_86__ + 5 * __temp_87__);
      float __temp_89__ = (__temp_88__ / 118);
      __var_1__[__iter_3__+(M)*FORMA_MAX(__iter_1__-3,0)] = __temp_89__;
      //printf ("var3[%d][%d] = %.6f\n", __iter_1__-3, __iter_3__, __temp_89__);
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(4*FORMA_BLOCKDIM_X);
  return SMemSize;
}

__global__ void __kernel___forma_kernel__1__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float * __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
  float * __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_X);
 
  int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X + GAPX) + (int)FORMA_BLOCKDIM_X;
  float t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  float b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;

  // Initialize the values
  int __iter_3__ = FORMA_MAX(__iter_0__-EXTENT,0) + (int)(threadIdx.x) ;
  if (__iter_3__ >= FORMA_MAX(__iter_0__-2,0) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-1))){
    __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)] = input[__iter_3__+(M)*(0)];
    t2 = input[__iter_3__+(M)*(1)];
  }
  // Rest of the computation
  for (int __iter_1__ = 1; __iter_1__ <= N-1; __iter_1__++) {
    if(__iter_3__ >= FORMA_MAX(__iter_0__-2,0) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-1))){
      b2 = __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)] = t2;
      t2 = input[__iter_3__+(M)*(__iter_1__+1)];
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__-1),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
      float __temp_2__ = b2;
      float __temp_5__ = (__tilevar_2__[__iter_3__+(-1)+(EXTENT-__iter_0__)]);
      float __temp_6__ = (5 * __temp_2__ + 12 * __temp_5__);
      float __temp_9__ = (__tilevar_2__[__iter_3__+(EXTENT-__iter_0__)]);
      float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
      float __temp_13__ = (__tilevar_2__[__iter_3__+1+(EXTENT-__iter_0__)]);
      float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
      float __temp_17__ = t2;
      float __temp_18__ = (__temp_14__ + 5 * __temp_17__);
      float __temp_19__ = (__temp_18__ / 118);
      b3 = __tilevar_3__[__iter_3__+(EXTENT-__iter_0__)];
      __tilevar_3__[__iter_3__+(EXTENT-__iter_0__)] = t3;
      t3 = __temp_19__;
      //printf ("var0[%d][%d] = %.6f\n", __iter_1__-0, __iter_3__, t3); 
    }
    if (__iter_3__ >= FORMA_MAX((__iter_0__-3),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) & (__iter_3__ < FORMA_MAX((__iter_0__-1),1) | __iter_3__ > FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)))) {
      b3 = __copy_arr_0__[__iter_1__-2+(M)*(__iter_3__)];
      __tilevar_3__[__iter_3__+(EXTENT-__iter_0__)] = __copy_arr_0__[__iter_1__-1+(M)*(__iter_3__)];
      t3 = __copy_arr_0__[__iter_1__+(M)*(__iter_3__)]; 
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__-2),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
      float __temp_32__ = b3;
      float __temp_35__ = (__tilevar_3__[__iter_3__+(-1)+(EXTENT-__iter_0__)]);
      float __temp_36__ = (5 * __temp_32__ + 12 * __temp_35__);
      float __temp_39__ = (__tilevar_3__[__iter_3__+(EXTENT-__iter_0__)]);
      float __temp_40__ = (__temp_36__ + 15 * __temp_39__);
      float __temp_43__ = (__tilevar_3__[__iter_3__+1+(EXTENT-__iter_0__)]);
      float __temp_44__ = (__temp_40__ + 12 * __temp_43__);
      float __temp_47__ = t3;
      float __temp_48__ = (__temp_44__ + 5 * __temp_47__);
      float __temp_49__ = (__temp_48__ / 118);
      b4 = __tilevar_4__[__iter_3__+(EXTENT-__iter_0__)];
      __tilevar_4__[__iter_3__+(EXTENT-__iter_0__)] = t4;
      t4 = __temp_49__;
      //printf ("var1[%d][%d] = %.6f\n", __iter_1__-1, __iter_3__, t4);
    }
    if (__iter_3__ >= FORMA_MAX((__iter_0__-4),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) & (__iter_3__ < FORMA_MAX((__iter_0__-2),1) | __iter_3__ > FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)))) {
      b4 = __copy_arr_1__[__iter_1__-2+(M)*(__iter_3__)];
      __tilevar_4__[__iter_3__+(EXTENT-__iter_0__)] = __copy_arr_1__[__iter_1__-1+(M)*(__iter_3__)];
      t4 = __copy_arr_1__[__iter_1__+(M)*(__iter_3__)];
    }
    __syncthreads();
    if(__iter_3__ >= FORMA_MAX((__iter_0__-3),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
      float __temp_60__ = b4;
      float __temp_61__ = (__tilevar_4__[__iter_3__+(-1)+(EXTENT-__iter_0__)]);
      float __temp_62__ = (5 * __temp_60__ + 12 * __temp_61__);
      float __temp_63__ = (__tilevar_4__[__iter_3__+(EXTENT-__iter_0__)]);
      float __temp_64__ = (__temp_62__ + 15 * __temp_63__);
      float __temp_65__ = (__tilevar_4__[__iter_3__+1+(EXTENT-__iter_0__)]);
      float __temp_66__ = (__temp_64__ + 12 * __temp_65__);
      float __temp_67__ = t4;
      float __temp_68__ = (__temp_66__ + 5 * __temp_67__);
      float __temp_69__ = (__temp_68__ / 118);
      b5 = __tilevar_5__[__iter_3__+(EXTENT-__iter_0__)];
      __tilevar_5__[__iter_3__+(EXTENT-__iter_0__)] = t5;
      t5 = __temp_69__;
    }
    if (__iter_3__ >= FORMA_MAX((__iter_0__-5),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(M-2)) & (__iter_3__ < FORMA_MAX((__iter_0__-3),1) | __iter_3__ > FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)))) {
      b5 = __copy_arr_2__[__iter_1__-2+(M)*(__iter_3__)];
      __tilevar_5__[__iter_3__+(EXTENT-__iter_0__)] = __copy_arr_2__[__iter_1__-1+(M)*(__iter_3__)];
      t5 = __copy_arr_2__[__iter_1__+(M)*(__iter_3__)];
    }
    __syncthreads();
    if( __iter_3__ >= FORMA_MAX((__iter_0__-4),1) & __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
      float __temp_80__ = b5;
      float __temp_81__ = (__tilevar_5__[__iter_3__+(-1)+(EXTENT-__iter_0__)]);
      float __temp_82__ = (5 * __temp_80__ + 12 * __temp_81__);
      float __temp_83__ = (__tilevar_5__[__iter_3__+(EXTENT-__iter_0__)]);
      float __temp_84__ = (__temp_82__ + 15 * __temp_83__);
      float __temp_85__ = (__tilevar_5__[__iter_3__+1+(EXTENT-__iter_0__)]);
      float __temp_86__ = (__temp_84__ + 12 * __temp_85__);
      float __temp_87__ = t5;
      float __temp_88__ = (__temp_86__ + 5 * __temp_87__);
      float __temp_89__ = (__temp_88__ / 118);
      __var_1__[__iter_3__+(M)*FORMA_MAX(__iter_1__-3,0)] = __temp_89__;
    }
  }
}

/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(float * h_input, int N, int M, float * __var_0__){

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
  float * __copy_arr_0__;
  cudaMalloc(&__copy_arr_0__,sizeof(float)*((N)*(M)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_0__\n");
  float * __copy_arr_1__;
  cudaMalloc(&__copy_arr_1__,sizeof(float)*((N)*(M)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_1__\n");
  float * __copy_arr_2__;
  cudaMalloc(&__copy_arr_2__,sizeof(float)*((N)*(M)));
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
  int __block_0___kernel___forma_kernel__0__ = 128;
  int __block_1___kernel___forma_kernel__0__ = 1;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x+GAPX);
  int __grid_1___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, __blockConfig___kernel___forma_kernel__0__, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");

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
  cudaFree(__copy_arr_0__);
  cudaFree(__copy_arr_1__);
  cudaFree(__copy_arr_2__);
}
/*Host Free End*/
