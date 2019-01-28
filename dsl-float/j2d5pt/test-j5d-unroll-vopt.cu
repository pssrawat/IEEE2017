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
#define GAPX (22) 
#define GAPY (22)
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

__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, float * __restrict__ __copy_arr_t0__, float * __restrict__ __copy_arr_t1__, float * __restrict__ __copy_arr_t2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
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
  __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X) + GAPX);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y) + GAPY);
  int __iter_2__;
  __iter_2__ = FORMA_MAX(__iter_1__,0) + 4*(int)(threadIdx.y) ; 
  if( __iter_2__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(0-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(1-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+1)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(2-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+2)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(3-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+3)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((__iter_1__+1),1) + 4*(int)(threadIdx.y) ;
  if( __iter_4__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      // iter 0 : __iter_4__ 
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a6__ = (5*__temp_a2__ + 12*__temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15*__temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12*__temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5*__temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+1)))] = __temp_a19__;
      // iter 1 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b6__ = (5*__temp_a9__+ 12*__temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15*__temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12*__temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5*__temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-(__iter_1__+1)))] = __temp_b19__;
      // iter 2 : __iter_4__ + 2
      float __temp_c5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c6__ = (5*__temp_a17__+ 12*__temp_c5__);
      float __temp_c10__ = (__temp_c6__ + 15*__temp_b17__);
      float __temp_c13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c14__ = (__temp_c10__ + 12*__temp_c13__);
      float __temp_c17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(0-(__iter_1__+0)))]);
      float __temp_c18__ = (__temp_c14__ + 5*__temp_c17__);
      float __temp_c19__ = (__temp_c18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2-(__iter_1__+1)))] = __temp_c19__;
      // iter 3 : __iter_4__ + 3
      float __temp_d5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d6__ = (5*__temp_b17__+ 12*__temp_d5__);
      float __temp_d10__ = (__temp_d6__ + 15*__temp_c17__);
      float __temp_d13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d14__ = (__temp_d10__ + 12*__temp_d13__);
      float __temp_d17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(4)+(0-(__iter_1__+0)))]);
      float __temp_d18__ = (__temp_d14__ + 5*__temp_d17__);
      float __temp_d19__ = (__temp_d18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3-(__iter_1__+1)))] = __temp_d19__;
    }
  }
  else if( __iter_4__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      // iter 0 : __iter_4__ 
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a6__ = (5*__temp_a2__ + 12*__temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15*__temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12*__temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5*__temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+1)))] = __temp_a19__;
      // iter 1 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b6__ = (5*__temp_a9__+ 12*__temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15*__temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12*__temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5*__temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-(__iter_1__+1)))] = __temp_b19__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_6__ = FORMA_MAX((__iter_1__+1),1);
    for(; __iter_6__ < (FORMA_MAX((__iter_1__+1),1)+2); __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+1)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_6__ = (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))-1);
    for(; __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ; __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+1)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_6__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))) {
      int __iter_7__ = FORMA_MAX((__iter_0__+1),1);
      for(; __iter_7__ < (FORMA_MAX((__iter_0__+1),1)+2); __iter_7__++) {
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+1)))];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_6__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.x) ;
    if (__iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))) {
      int __iter_7__ = (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2))-1);
      for(; __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ; __iter_7__++ ){
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+1)))];
      }
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX((__iter_1__+2),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_10__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      // iter 1 : __iter_10__ 
      float __temp_a32__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(-1)+(0-(__iter_1__+1)))]);
      float __temp_a35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+1)))]);
      float __temp_a36__ = (5*__temp_a32__ + 12*__temp_a35__);
      float __temp_a39__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+1)))]);
      float __temp_a40__ = (__temp_a36__ + 15*__temp_a39__);
      float __temp_a43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+1)))]);
      float __temp_a44__ = (__temp_a40__ + 12*__temp_a43__);
      float __temp_a47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(0-(__iter_1__+1)))]);
      float __temp_a48__ = (__temp_a44__ + 5*__temp_a47__);
      float __temp_a49__ = (__temp_a48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+2)))] = __temp_a49__;
      // iter 2 : __iter_10__ + 1
      float __temp_b35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(0-(__iter_1__+1)))]);
      float __temp_b36__ = (5*__temp_a39__+ 12*__temp_b35__);
      float __temp_b40__ = (__temp_b36__ + 15*__temp_a47__);
      float __temp_b43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(0-(__iter_1__+1)))]);
      float __temp_b44__ = (__temp_b40__ + 12*__temp_b43__);
      float __temp_b47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(0-(__iter_1__+1)))]);
      float __temp_b48__ = (__temp_b44__ + 5*__temp_b47__);
      float __temp_b49__ = (__temp_b48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1-(__iter_1__+2)))] = __temp_b49__;
      // iter 3 : __iter_10__ + 2
      float __temp_c35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(0-(__iter_1__+1)))]);
      float __temp_c36__ = (5*__temp_a47__+ 12*__temp_c35__);
      float __temp_c40__ = (__temp_c36__ + 15*__temp_b47__);
      float __temp_c43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(0-(__iter_1__+1)))]);
      float __temp_c44__ = (__temp_c40__ + 12*__temp_c43__);
      float __temp_c47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(0-(__iter_1__+1)))]);
      float __temp_c48__ = (__temp_c44__ + 5*__temp_c47__);
      float __temp_c49__ = (__temp_c48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2-(__iter_1__+2)))] = __temp_c49__;
      // iter 4 : __iter_10__ + 3
      float __temp_d35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(0-(__iter_1__+1)))]);
      float __temp_d36__ = (5*__temp_b47__+ 12*__temp_d35__);
      float __temp_d40__ = (__temp_d36__ + 15*__temp_c47__);
      float __temp_d43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(0-(__iter_1__+1)))]);
      float __temp_d44__ = (__temp_d40__ + 12*__temp_d43__);
      float __temp_d47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(4)+(0-(__iter_1__+1)))]);
      float __temp_d48__ = (__temp_d44__ + 5*__temp_d47__);
      float __temp_d49__ = (__temp_d48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3-(__iter_1__+2)))] = __temp_d49__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_12__ = FORMA_MAX((__iter_1__+2),1);
    for(; __iter_12__ < (FORMA_MAX((__iter_1__+2),1)+2); __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+2)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_12__ = (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))-1);
    for(; __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) ; __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+2)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_12__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.x) ; 
    if (__iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))) {
      int __iter_13__ = FORMA_MAX((__iter_0__+2),1);
      for(; __iter_13__ < (FORMA_MAX((__iter_0__+2),1)+2); __iter_13__++) {
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+2)))];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_12__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.x) ; 
    if (__iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))) {
      int __iter_13__ = (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2))-1);
      for(; __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ; __iter_13__++){
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+2)))];
      }
    }
  }
  __syncthreads();
  int __iter_16__;
  __iter_16__ = FORMA_MAX((__iter_1__+3),1) + 4*(int)(threadIdx.y) ;
  if( __iter_16__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      // iter 1 : __iter_16__ 
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+2)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_a62__ = (5*__temp_a60__ + 12*__temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_a64__ = (__temp_a62__ + 15*__temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_a66__ = (__temp_a64__ + 12*__temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_a68__ = (__temp_a66__ + 5*__temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+3)))] = __temp_a69__;
      // iter 2 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_b62__ = (5*__temp_a63__+ 12*__temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15*__temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_b66__ = (__temp_b64__ + 12*__temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+2)))]);
      float __temp_b68__ = (__temp_b66__ + 5*__temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+3)))] = __temp_b69__;
      // iter 3 : __iter_16__ + 2
      float __temp_c61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+2)))]);
      float __temp_c62__ = (5*__temp_a67__+ 12*__temp_c61__);
      float __temp_c64__ = (__temp_c62__ + 15*__temp_b67__);
      float __temp_c65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+2)))]);
      float __temp_c66__ = (__temp_c64__ + 12*__temp_c65__);
      float __temp_c67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(0-(__iter_1__+2)))]);
      float __temp_c68__ = (__temp_c66__ + 5*__temp_c67__);
      float __temp_c69__ = (__temp_c68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+3)))] = __temp_c69__;
      // iter 4 : __iter_16__ + 3
      float __temp_d61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(0-(__iter_1__+2)))]);
      float __temp_d62__ = (5*__temp_b67__+ 12*__temp_d61__);
      float __temp_d64__ = (__temp_d62__ + 15*__temp_c67__);
      float __temp_d65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(0-(__iter_1__+2)))]);
      float __temp_d66__ = (__temp_d64__ + 12*__temp_d65__);
      float __temp_d67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(4)+(0-(__iter_1__+2)))]);
      float __temp_d68__ = (__temp_d66__ + 5*__temp_d67__);
      float __temp_d69__ = (__temp_d68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+3)))] = __temp_d69__;
    }
  }
  else if( __iter_16__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      // iter 1 : __iter_16__ 
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+2)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_a62__ = (5*__temp_a60__ + 12*__temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_a64__ = (__temp_a62__ + 15*__temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2)))]);
      float __temp_a66__ = (__temp_a64__ + 12*__temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_a68__ = (__temp_a66__ + 5*__temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+3)))] = __temp_a69__;
      // iter 2 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_b62__ = (5*__temp_a63__+ 12*__temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15*__temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+2)))]);
      float __temp_b66__ = (__temp_b64__ + 12*__temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+2)))]);
      float __temp_b68__ = (__temp_b66__ + 5*__temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+3)))] = __temp_b69__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_18__ = FORMA_MAX((__iter_1__+3),1);
    for(; __iter_18__ < (FORMA_MAX((__iter_1__+3),1)+2); __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+3)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_18__ = (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))-1);
    for(; __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ; __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+3)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_18__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.x) ; 
    if (__iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))) {
      int __iter_19__ = FORMA_MAX((__iter_0__+3),1);
      for(; __iter_19__ < (FORMA_MAX((__iter_0__+3),1)+2); __iter_19__++) {
         __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+3)))];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_18__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.x) ; 
    if (__iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))) {
      int __iter_19__ = (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2))-1);
      for(; __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ; __iter_19__++){
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+3)))];
      }
    }
  }
  __syncthreads();
  int __iter_22__;
  __iter_22__ = FORMA_MAX((__iter_1__+4),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_22__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
      // iter 0 : __iter_22__
      float __temp_a80__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+3)))]);
      float __temp_a81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+3)))]);
      float __temp_a82__ = (5*__temp_a80__ + 12*__temp_a81__);
      float __temp_a83__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+3)))]);
      float __temp_a84__ = (__temp_a82__ + 15*__temp_a83__);
      float __temp_a85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+3)))]);
      float __temp_a86__ = (__temp_a84__ + 12*__temp_a85__);
      float __temp_a87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+3)))]);
      float __temp_a88__ = (__temp_a86__ + 5*__temp_a87__);
      float __temp_a89__ = (__temp_a88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_a89__;
      // iter 1 : __iter_22__ + 1
      float __temp_b81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+3)))]);
      float __temp_b82__ = (5*__temp_a83__+ 12*__temp_b81__);
      float __temp_b84__ = (__temp_b82__ + 15*__temp_a87__);
      float __temp_b85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+3)))]);
      float __temp_b86__ = (__temp_b84__ + 12*__temp_b85__);
      float __temp_b87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+3)))]);
      float __temp_b88__ = (__temp_b86__ + 5*__temp_b87__);
      float __temp_b89__ = (__temp_b88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+1)] = __temp_b89__;
      // iter 2 : __iter_22__ + 2
      float __temp_c81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+3)))]);
      float __temp_c82__ = (5*__temp_a87__+ 12*__temp_c81__);
      float __temp_c84__ = (__temp_c82__ + 15*__temp_b87__);
      float __temp_c85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+3)))]);
      float __temp_c86__ = (__temp_c84__ + 12*__temp_c85__);
      float __temp_c87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(0-(__iter_1__+3)))]);
      float __temp_c88__ = (__temp_c86__ + 5*__temp_c87__);
      float __temp_c89__ = (__temp_c88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+2)] = __temp_c89__;
      // iter 3 : __iter_22__ + 3
      float __temp_d81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(0-(__iter_1__+3)))]);
      float __temp_d82__ = (5*__temp_b87__+ 12*__temp_d81__);
      float __temp_d84__ = (__temp_d82__ + 15*__temp_c87__);
      float __temp_d85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(0-(__iter_1__+3)))]);
      float __temp_d86__ = (__temp_d84__ + 12*__temp_d85__);
      float __temp_d87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(4)+(0-(__iter_1__+3)))]);
      float __temp_d88__ = (__temp_d86__ + 5*__temp_d87__);
      float __temp_d89__ = (__temp_d88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+3)] = __temp_d89__;
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

__global__ void __kernel___forma_kernel__1__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, float * __restrict__ __copy_arr_t0__, float * __restrict__ __copy_arr_t1__, float * __restrict__ __copy_arr_t2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
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
  __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X) + GAPX) + (int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y) + GAPY);
  int __iter_2__;
  __iter_2__ = FORMA_MAX(__iter_1__,0) + 4*(int)(threadIdx.y) ; 
  if( __iter_2__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(0-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(1-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+1)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(2-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+2)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(3-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+3)];
    }
  }
  __syncthreads();
  int __iter_4__; 
  __iter_4__ = FORMA_MAX((__iter_1__+1),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_4__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
      // iter 0 : __iter_4__ 
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a6__ = (5 * __temp_a2__ + 12 * __temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15 * __temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12 * __temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5 * __temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))] = __temp_a19__;
      // iter 0 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b6__ = (5 * __temp_a9__+ 12 * __temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15 * __temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12 * __temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5 * __temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-(__iter_1__+0)))] = __temp_b19__;
      // iter 0 : __iter_4__ + 2
      float __temp_c5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c6__ = (5 * __temp_a17__+ 12 * __temp_c5__);
      float __temp_c10__ = (__temp_c6__ + 15 * __temp_b17__);
      float __temp_c13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c14__ = (__temp_c10__ + 12 * __temp_c13__);
      float __temp_c17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(0-(__iter_1__+0)))]);
      float __temp_c18__ = (__temp_c14__ + 5 * __temp_c17__);
      float __temp_c19__ = (__temp_c18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2-(__iter_1__+0)))] = __temp_c19__;
      // iter 3 : __iter_4__ + 3
      float __temp_d5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d6__ = (5 * __temp_b17__ + 12 * __temp_d5__);
      float __temp_d10__ = (__temp_d6__ + 15 * __temp_c17__);
      float __temp_d13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d14__ = (__temp_d10__ + 12 * __temp_d13__);
      float __temp_d17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(4)+(0-(__iter_1__+0)))]);
      float __temp_d18__ = (__temp_d14__ + 5 * __temp_d17__);
      float __temp_d19__ = (__temp_d18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3-(__iter_1__+0)))] = __temp_d19__;
    }
  }
  else if( __iter_4__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
      // iter 0 : __iter_4__ 
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a6__ = (5 * __temp_a2__ + 12 * __temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15 * __temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12 * __temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5 * __temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-(__iter_1__+0)))] = __temp_a19__;
      // iter 0 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b6__ = (5 * __temp_a9__ + 12 * __temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15 * __temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12 * __temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5 * __temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-(__iter_1__+0)))] = __temp_b19__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_6__ = FORMA_MAX((__iter_1__+1),1);
    for(; __iter_6__ < (FORMA_MAX((__iter_1__+1),1)+2); __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_6__ = FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))-1;
    for(; __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ; __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_6__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))) { 
      int __iter_7__ = FORMA_MAX((__iter_0__-3),1);
      for(; __iter_7__ < FORMA_MAX((__iter_0__-1),1); __iter_7__++) {
        __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_6__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2))) {
      int __iter_7__ = FORMA_MIN(((__iter_0__+GAPX+1)),(M-2));
      for(; __iter_7__ < FORMA_MIN(((__iter_0__+GAPX+3)),(M-2)); __iter_7__++){
         __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(0-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX((__iter_1__+2),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_10__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
      // iter 0 : __iter_10__ 
      float __temp_a32__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*( __iter_10__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0)))]);
      float __temp_a36__ = (5 * __temp_a32__ + 12 * __temp_a35__);
      float __temp_a39__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0)))]);
      float __temp_a40__ = (__temp_a36__ + 15 * __temp_a39__);
      float __temp_a43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0)))]);
      float __temp_a44__ = (__temp_a40__ + 12 * __temp_a43__);
      float __temp_a47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a48__ = (__temp_a44__ + 5 * __temp_a47__);
      float __temp_a49__ = (__temp_a48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0)))] = __temp_a49__;
      // iter 2 : __iter_10__ + 1
      float __temp_b35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b36__ = (5 * __temp_a39__ + 12 * __temp_b35__);
      float __temp_b40__ = (__temp_b36__ + 15 * __temp_a47__);
      float __temp_b43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b44__ = (__temp_b40__ + 12 * __temp_b43__);
      float __temp_b47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b48__ = (__temp_b44__ + 5 * __temp_b47__);
      float __temp_b49__ = (__temp_b48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1-(__iter_1__+0)))] = __temp_b49__;
      // iter 3 : __iter_10__ + 2
      float __temp_c35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c36__ = (5 * __temp_a47__ + 12 * __temp_c35__);
      float __temp_c40__ = (__temp_c36__ + 15 * __temp_b47__);
      float __temp_c43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c44__ = (__temp_c40__ + 12 * __temp_c43__);
      float __temp_c47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(0-(__iter_1__+0)))]);
      float __temp_c48__ = (__temp_c44__ + 5 * __temp_c47__);
      float __temp_c49__ = (__temp_c48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2-(__iter_1__+0)))] = __temp_c49__;
      // iter 4 : __iter_10__ + 3
      float __temp_d35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d36__ = (5 * __temp_b47__ + 12 * __temp_d35__);
      float __temp_d40__ = (__temp_d36__ + 15 * __temp_c47__);
      float __temp_d43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d44__ = (__temp_d40__ + 12 * __temp_d43__);
      float __temp_d47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(4)+(0-(__iter_1__+0)))]);
      float __temp_d48__ = (__temp_d44__ + 5 * __temp_d47__);
      float __temp_d49__ = (__temp_d48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3-(__iter_1__+0)))] = __temp_d49__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_12__ = FORMA_MAX((__iter_1__+2),1);
    for(; __iter_12__ < (FORMA_MAX((__iter_1__+2),1)+2); __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_12__ = (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))-1);
    for(; __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2)) ; __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_12__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.x) ; 
    if(__iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))) {
      int __iter_13__ = FORMA_MAX((__iter_0__-4),1);
      for(; __iter_13__ < FORMA_MAX((__iter_0__-2),1); __iter_13__++) {
        __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_12__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.x) ; 
    if(__iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-2))) {
      int __iter_13__ = FORMA_MIN((__iter_0__+GAPX+2),(M-2));
      for(; __iter_13__ < FORMA_MIN((__iter_0__+GAPX+4),(M-2)) ; __iter_13__++){
         __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(0-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  __syncthreads();
  int __iter_16__;
  __iter_16__ = FORMA_MAX((__iter_1__+3),1) + 4*(int)(threadIdx.y) ;
  if( __iter_16__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
      // iter 0 : __iter_16__
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))]);
      float __temp_a62__ = (5 * __temp_a60__ + 12 * __temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))]);
      float __temp_a64__ = (__temp_a62__ + 15 * __temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))]);
      float __temp_a66__ = (__temp_a64__ + 12 * __temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a68__ = (__temp_a66__ + 5 * __temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))] = __temp_a69__;
      // iter 1 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b62__ = (5 * __temp_a63__ + 12 * __temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15 * __temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b66__ = (__temp_b64__ + 12 * __temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b68__ = (__temp_b66__ + 5 * __temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0)))] = __temp_b69__;
      // iter 2 : __iter_16__ + 2
      float __temp_c61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c62__ = (5 * __temp_a67__ + 12 * __temp_c61__);
      float __temp_c64__ = (__temp_c62__ + 15 * __temp_b67__);
      float __temp_c65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c66__ = (__temp_c64__ + 12 * __temp_c65__);
      float __temp_c67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(0-(__iter_1__+0)))]);
      float __temp_c68__ = (__temp_c66__ + 5 * __temp_c67__);
      float __temp_c69__ = (__temp_c68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0)))] = __temp_c69__;
      // iter 3 : __iter_16__ + 3
      float __temp_d61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d62__ = (5 * __temp_b67__ + 12 * __temp_d61__);
      float __temp_d64__ = (__temp_d62__ + 15 * __temp_c67__);
      float __temp_d65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d66__ = (__temp_d64__ + 12 * __temp_d65__);
      float __temp_d67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(4)+(0-(__iter_1__+0)))]);
      float __temp_d68__ = (__temp_d66__ + 5 * __temp_d67__);
      float __temp_d69__ = (__temp_d68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0)))] = __temp_d69__;
    }
  }
  else if( __iter_16__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
      // iter 0 : __iter_16__
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))]);
      float __temp_a62__ = (5 * __temp_a60__ + 12 * __temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))]);
      float __temp_a64__ = (__temp_a62__ + 15 * __temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))]);
      float __temp_a66__ = (__temp_a64__ + 12 * __temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a68__ = (__temp_a66__ + 5 * __temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0)))] = __temp_a69__;
      // iter 1 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b62__ = (5 * __temp_a63__+ 12 * __temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15 * __temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b66__ = (__temp_b64__ + 12 * __temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b68__ = (__temp_b66__ + 5 * __temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0)))] = __temp_b69__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_18__ = FORMA_MAX((__iter_1__+3),1);
    for(; __iter_18__ < (FORMA_MAX((__iter_1__+3),1)+2); __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_18__ = FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))-1;
    for(; __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2)) ; __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_18__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.x) ; 
    if(__iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))) {
      int __iter_19__ = FORMA_MAX((__iter_0__-5),1);
      for(; __iter_19__ < FORMA_MAX((__iter_0__-3),1); __iter_19__++) {
        __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_18__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.x) ; 
    if(__iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-2))) {
      int __iter_19__ = FORMA_MIN(((__iter_0__+GAPX+3)),(M-2));
      for(; __iter_19__ < FORMA_MIN(((__iter_0__+GAPX+5)),(M-2)) ; __iter_19__++ ){
        __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(0-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  __syncthreads();
  int __iter_22__;
  __iter_22__ = FORMA_MAX((__iter_1__+4),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_22__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
      // iter 0 : __iter_22__
      float __temp_a80__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(0-(__iter_1__+0)))]);
      float __temp_a81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+0)))]);
      float __temp_a82__ = (5 * __temp_a80__ + 12 * __temp_a81__);
      float __temp_a83__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+0)))]);
      float __temp_a84__ = (__temp_a82__ + 15 * __temp_a83__);
      float __temp_a85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(0-(__iter_1__+0)))]);
      float __temp_a86__ = (__temp_a84__ + 12 * __temp_a85__);
      float __temp_a87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+0)))]);
      float __temp_a88__ = (__temp_a86__ + 5 * __temp_a87__);
      float __temp_a89__ = (__temp_a88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_a89__;
      // iter 1 : __iter_22__ + 1
      float __temp_b81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b82__ = (5 * __temp_a83__ + 12 * __temp_b81__);
      float __temp_b84__ = (__temp_b82__ + 15 * __temp_a87__);
      float __temp_b85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(0-(__iter_1__+0)))]);
      float __temp_b86__ = (__temp_b84__ + 12 * __temp_b85__);
      float __temp_b87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+0)))]);
      float __temp_b88__ = (__temp_b86__ + 5 * __temp_b87__);
      float __temp_b89__ = (__temp_b88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+1)] = __temp_b89__;
      // iter 2 : __iter_22__ + 2
      float __temp_c81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c82__ = (5 * __temp_a87__ + 12 * __temp_c81__);
      float __temp_c84__ = (__temp_c82__ + 15 * __temp_b87__);
      float __temp_c85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(0-(__iter_1__+0)))]);
      float __temp_c86__ = (__temp_c84__ + 12 * __temp_c85__);
      float __temp_c87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(0-(__iter_1__+0)))]);
      float __temp_c88__ = (__temp_c86__ + 5 * __temp_c87__);
      float __temp_c89__ = (__temp_c88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+2)] = __temp_c89__;
      // iter 3 : __iter_22__ + 3
      float __temp_d81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d82__ = (5 * __temp_b87__ + 12 * __temp_d81__);
      float __temp_d84__ = (__temp_d82__ + 15 * __temp_c87__);
      float __temp_d85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(0-(__iter_1__+0)))]);
      float __temp_d86__ = (__temp_d84__ + 12 * __temp_d85__);
      float __temp_d87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(4)+(0-(__iter_1__+0)))]);
      float __temp_d88__ = (__temp_d86__ + 5 * __temp_d87__);
      float __temp_d89__ = (__temp_d88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+3)] = __temp_d89__;
    }
  }
}

__global__ void __kernel___forma_kernel__2__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, float * __restrict__ __copy_arr_t0__, float * __restrict__ __copy_arr_t1__, float * __restrict__ __copy_arr_t2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
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
  __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X) + GAPX);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y) + GAPY) + (int)(FORMA_BLOCKDIM_Y);
  int __iter_2__;
  __iter_2__ = FORMA_MAX(__iter_1__-2,0) + 4*(int)(threadIdx.y) ; 
  if( __iter_2__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(1)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+1)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(2)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+2)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(3)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+3)];
    }
  }
  else if( __iter_2__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
      __tilevar_2__[__iter_3__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(1)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+1)];
    }
  }
  __syncthreads();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((__iter_1__-1),1) + 4*(int)(threadIdx.y) ;
  if( __iter_4__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      // iter 0 : __iter_4__ 
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a6__ = (5 * __temp_a2__ + 12 * __temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15 * __temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12 * __temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5 * __temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))] = __temp_a19__;
      // iter 1 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b6__ = (5 * __temp_a9__ + 12 * __temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15 * __temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12 * __temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5 * __temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b19__;
      // iter 2 : __iter_4__ + 2
      float __temp_c5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c6__ = (5 * __temp_a17__ + 12 * __temp_c5__);
      float __temp_c10__ = (__temp_c6__ + 15 * __temp_b17__);
      float __temp_c13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c14__ = (__temp_c10__ + 12 * __temp_c13__);
      float __temp_c17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c18__ = (__temp_c14__ + 5 * __temp_c17__);
      float __temp_c19__ = (__temp_c18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))] = __temp_c19__;
      // iter 3 : __iter_4__ + 3
      float __temp_d5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d6__ = (5 * __temp_b17__ + 12 * __temp_d5__);
      float __temp_d10__ = (__temp_d6__ + 15 * __temp_c17__);
      float __temp_d13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d14__ = (__temp_d10__ + 12 * __temp_d13__);
      float __temp_d17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d18__ = (__temp_d14__ + 5 * __temp_d17__);
      float __temp_d19__ = (__temp_d18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))] = __temp_d19__;
    }
  }
  else if( __iter_4__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ;
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
      // iter 0 : __iter_4__ 
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a6__ = (5 * __temp_a2__ + 12 * __temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15 * __temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12 * __temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5 * __temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))] = __temp_a19__;
      // iter 1 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b6__ = (5 * __temp_a9__ + 12 * __temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15 * __temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12 * __temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5 * __temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b19__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_6__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(N-2))) {
      int __iter_7__ = FORMA_MAX((__iter_0__+1),1);
      for(; __iter_7__ < (FORMA_MAX((__iter_0__+1),1)+2); __iter_7__++) {
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_6__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(N-2))) {
      int __iter_7__ = (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2))-1);
      for(; __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ; __iter_7__++){
        __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)] = __tilevar_3__[__iter_7__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_6__ = FORMA_MAX((__iter_1__-3),1);
    for(; __iter_6__ < FORMA_MAX((__iter_1__-1),1); __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
        __tilevar_3__[__iter_7__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_6__ = FORMA_MIN(((__iter_1__+GAPY+1)),(N-2));
    for(; __iter_6__ < FORMA_MIN(((__iter_1__+GAPY+3)),(N-2)) ; __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
        __tilevar_3__[__iter_7__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX((__iter_1__-2),1) + 4*(int)(threadIdx.y) ;
  if( __iter_10__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      // iter 0 : __iter_10__ 
      float __temp_a32__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*( __iter_10__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a36__ = (5 * __temp_a32__ + 12 * __temp_a35__);
      float __temp_a39__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a40__ = (__temp_a36__ + 15 * __temp_a39__);
      float __temp_a43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a44__ = (__temp_a40__ + 12 * __temp_a43__);
      float __temp_a47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a48__ = (__temp_a44__ + 5 * __temp_a47__);
      float __temp_a49__ = (__temp_a48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))] = __temp_a49__;
      // iter 1 : __iter_10__ + 1
      float __temp_b35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b36__ = (5 * __temp_a39__ + 12 * __temp_b35__);
      float __temp_b40__ = (__temp_b36__ + 15 * __temp_a47__);
      float __temp_b43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b44__ = (__temp_b40__ + 12 * __temp_b43__);
      float __temp_b47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b48__ = (__temp_b44__ + 5 * __temp_b47__);
      float __temp_b49__ = (__temp_b48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b49__;
      // iter 2 : __iter_10__ + 2
      float __temp_c35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c36__ = (5 * __temp_a47__ + 12 * __temp_c35__);
      float __temp_c40__ = (__temp_c36__ + 15 * __temp_b47__);
      float __temp_c43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c44__ = (__temp_c40__ + 12 * __temp_c43__);
      float __temp_c47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c48__ = (__temp_c44__ + 5 * __temp_c47__);
      float __temp_c49__ = (__temp_c48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))] = __temp_c49__;
      // iter 3 : __iter_10__ + 3
      float __temp_d35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d36__ = (5 * __temp_b47__ + 12 * __temp_d35__);
      float __temp_d40__ = (__temp_d36__ + 15 * __temp_c47__);
      float __temp_d43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d44__ = (__temp_d40__ + 12 * __temp_d43__);
      float __temp_d47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d48__ = (__temp_d44__ + 5 * __temp_d47__);
      float __temp_d49__ = (__temp_d48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))] = __temp_d49__;
    }
  }
  else if( __iter_10__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
      // iter 0 : __iter_10__ 
      float __temp_a32__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*( __iter_10__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a36__ = (5 * __temp_a32__ + 12 * __temp_a35__);
      float __temp_a39__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a40__ = (__temp_a36__ + 15 * __temp_a39__);
      float __temp_a43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a44__ = (__temp_a40__ + 12 * __temp_a43__);
      float __temp_a47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a48__ = (__temp_a44__ + 5 * __temp_a47__);
      float __temp_a49__ = (__temp_a48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))] = __temp_a49__;
      // iter 1 : __iter_10__ + 1
      float __temp_b35__ = (__tilevar_3__[__iter_11__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b36__ = (5 * __temp_a39__ + 12 * __temp_b35__);
      float __temp_b40__ = (__temp_b36__ + 15 * __temp_a47__);
      float __temp_b43__ = (__tilevar_3__[ __iter_11__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b44__ = (__temp_b40__ + 12 * __temp_b43__);
      float __temp_b47__ = (__tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b48__ = (__temp_b44__ + 5 * __temp_b47__);
      float __temp_b49__ = (__temp_b48__ / 118);
      __tilevar_4__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b49__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_12__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.x) ; 
    if(__iter_12__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2))) { 
      int __iter_13__ = FORMA_MAX((__iter_0__+2),1);
      for(; __iter_13__ < (FORMA_MAX((__iter_0__+2),1)+2); __iter_13__++) {
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_12__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.x) ; 
    if(__iter_12__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2))) { 
      int __iter_13__ = (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2))-1);
      for(; __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ; __iter_13__++){
        __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)] = __tilevar_4__[__iter_13__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_12__ = FORMA_MAX((__iter_1__-4),1);
    for(; __iter_12__ < FORMA_MAX((__iter_1__-2),1); __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
        __tilevar_4__[__iter_13__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_12__ = FORMA_MIN(((__iter_1__+GAPY+2)),(N-2));
    for(; __iter_12__ < FORMA_MIN(((__iter_1__+GAPY+4)),(N-2)) ; __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
        __tilevar_4__[__iter_13__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  __syncthreads();
  int __iter_16__;
  __iter_16__ = FORMA_MAX((__iter_1__-3),1) + 4*(int)(threadIdx.y) ;
  if( __iter_16__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      //iter 0 : __iter_16__
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a62__ = (5 * __temp_a60__ + 12 * __temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a64__ = (__temp_a62__ + 15 * __temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a66__ = (__temp_a64__ + 12 * __temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a68__ = (__temp_a66__ + 5 * __temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))] = __temp_a69__;
      // iter 1 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b62__ = (5 * __temp_a63__ + 12 * __temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15 * __temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b66__ = (__temp_b64__ + 12 * __temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b68__ = (__temp_b66__ + 5 * __temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b69__;
      // iter 2 : __iter_16__ + 2
      float __temp_c61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c62__ = (5 * __temp_a67__ + 12 * __temp_c61__);
      float __temp_c64__ = (__temp_c62__ + 15 * __temp_b67__);
      float __temp_c65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c66__ = (__temp_c64__ + 12 * __temp_c65__);
      float __temp_c67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c68__ = (__temp_c66__ + 5 * __temp_c67__);
      float __temp_c69__ = (__temp_c68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))] = __temp_c69__;
      // iter 3 : __iter_16__ + 3
      float __temp_d61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d62__ = (5 * __temp_b67__ + 12 * __temp_d61__);
      float __temp_d64__ = (__temp_d62__ + 15 * __temp_c67__);
      float __temp_d65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d66__ = (__temp_d64__ + 12 * __temp_d65__);
      float __temp_d67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d68__ = (__temp_d66__ + 5 * __temp_d67__);
      float __temp_d69__ = (__temp_d68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))] = __temp_d69__;
    }
  }
  else if( __iter_16__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ;
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
      //iter 0 : __iter_16__
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a62__ = (5 * __temp_a60__ + 12 * __temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a64__ = (__temp_a62__ + 15 * __temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a66__ = (__temp_a64__ + 12 * __temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a68__ = (__temp_a66__ + 5 * __temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))] = __temp_a69__;
      // iter 1 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b62__ = (5 * __temp_a63__ + 12 * __temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15 * __temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b66__ = (__temp_b64__ + 12 * __temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b68__ = (__temp_b66__ + 5 * __temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b69__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_18__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.x) ; 
    if(__iter_18__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2))) {
      int __iter_19__ = FORMA_MAX((__iter_0__+3),1);
      for(; __iter_19__ < (FORMA_MAX((__iter_0__+3),1)+2); __iter_19__++) {
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_18__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.x) ; 
    if(__iter_18__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2))) {
      int __iter_19__ = (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2))-1);
      for(; __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ; __iter_19__++ ){
        __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)] = __tilevar_5__[__iter_19__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))];
      }
    }
  }
  else if (threadIdx.y == 2) { 
    int __iter_18__ = FORMA_MAX((__iter_1__-5),1);
    for(; __iter_18__ < FORMA_MAX((__iter_1__-3),1); __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
        __tilevar_5__[__iter_19__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  else if (threadIdx.y == 3) { 
    int __iter_18__ = FORMA_MIN(((__iter_1__+GAPY+3)),(N-2));
    for(; __iter_18__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(N-2)) ; __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
         __tilevar_5__[__iter_19__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  __syncthreads();
  int __iter_22__;
  __iter_22__ = FORMA_MAX((__iter_1__-4),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_22__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
      // iter 0 : __iter_22__
      float __temp_a80__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a82__ = (5 * __temp_a80__ + 12 * __temp_a81__);
      float __temp_a83__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a84__ = (__temp_a82__ + 15 * __temp_a83__);
      float __temp_a85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a86__ = (__temp_a84__ + 12 * __temp_a85__);
      float __temp_a87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a88__ = (__temp_a86__ + 5 * __temp_a87__);
      float __temp_a89__ = (__temp_a88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_a89__;
      // iter 1 : __iter_22__ + 1
      float __temp_b81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b82__ = (5 * __temp_a83__ + 12 * __temp_b81__);
      float __temp_b84__ = (__temp_b82__ + 15 * __temp_a87__);
      float __temp_b85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b86__ = (__temp_b84__ + 12 * __temp_b85__);
      float __temp_b87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b88__ = (__temp_b86__ + 5 * __temp_b87__);
      float __temp_b89__ = (__temp_b88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+1)] = __temp_b89__;
      // iter 2 : __iter_22__ + 2
      float __temp_c81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c82__ = (5 * __temp_a87__ + 12 * __temp_c81__);
      float __temp_c84__ = (__temp_c82__ + 15 * __temp_b87__);
      float __temp_c85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c86__ = (__temp_c84__ + 12 * __temp_c85__);
      float __temp_c87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c88__ = (__temp_c86__ + 5 * __temp_c87__);
      float __temp_c89__ = (__temp_c88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+2)] = __temp_c89__;
      // iter 3 : __iter_22__ + 3
      float __temp_d81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d82__ = (5 * __temp_b87__ + 12 * __temp_d81__);
      float __temp_d84__ = (__temp_d82__ + 15 * __temp_c87__);
      float __temp_d85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d86__ = (__temp_d84__ + 12 * __temp_d85__);
      float __temp_d87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d88__ = (__temp_d86__ + 5 * __temp_d87__);
      float __temp_d89__ = (__temp_d88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+3)] = __temp_d89__;
    }
  }
  else if( __iter_22__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
      // iter 0 : __iter_22__
      float __temp_a80__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a82__ = (5 * __temp_a80__ + 12 * __temp_a81__);
      float __temp_a83__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a84__ = (__temp_a82__ + 15 * __temp_a83__);
      float __temp_a85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a86__ = (__temp_a84__ + 12 * __temp_a85__);
      float __temp_a87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a88__ = (__temp_a86__ + 5 * __temp_a87__);
      float __temp_a89__ = (__temp_a88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_a89__;
      // iter 1 : __iter_22__ + 1
      float __temp_b81__ = (__tilevar_5__[__iter_23__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b82__ = (5 * __temp_a83__ + 12 * __temp_b81__);
      float __temp_b84__ = (__temp_b82__ + 15 * __temp_a87__);
      float __temp_b85__ = (__tilevar_5__[__iter_23__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b86__ = (__temp_b84__ + 12 * __temp_b85__);
      float __temp_b87__ = (__tilevar_5__[__iter_23__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b88__ = (__temp_b86__ + 5 * __temp_b87__);
      float __temp_b89__ = (__temp_b88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+1)] = __temp_b89__;
    }
  }
}

__global__ void __kernel___forma_kernel__3__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, float * __restrict__ __copy_arr_t0__, float * __restrict__ __copy_arr_t1__, float * __restrict__ __copy_arr_t2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
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
  __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X) + GAPX) + (int)(FORMA_BLOCKDIM_X);
  int __iter_1__;
  __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y) + GAPY) + (int)(FORMA_BLOCKDIM_Y);
  int __iter_2__;
  __iter_2__ = FORMA_MAX(__iter_1__-2,0) + 4*(int)(threadIdx.y) ;
  if( __iter_2__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(1)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+1)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(2)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+2)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(3)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+3)];
    }
  }
  else if( __iter_2__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-1)) ){
    int __iter_3__;
    __iter_3__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
    if( __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-1)) ){
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__)];
      __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_2__+(1)+(EXTENT-__iter_1__))] = input[__iter_3__+(M-0)*(__iter_2__+1)];
    }
  }
  __syncthreads ();
  int __iter_4__;
  __iter_4__ = FORMA_MAX((__iter_1__-1),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_4__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
      // iter 0 : __iter_4__
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a6__ = (5 * __temp_a2__ + 12 * __temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15 * __temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12 * __temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5 * __temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))] = __temp_a19__;
      // iter 1 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b6__ = (5 * __temp_a9__ + 12 * __temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15 * __temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12 * __temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5 * __temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b19__;
      // iter 2 : __iter_4__ + 2
      float __temp_c5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c6__ = (5 * __temp_a17__ + 12 * __temp_c5__);
      float __temp_c10__ = (__temp_c6__ + 15 * __temp_b17__);
      float __temp_c13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c14__ = (__temp_c10__ + 12 * __temp_c13__);
      float __temp_c17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c18__ = (__temp_c14__ + 5 * __temp_c17__);
      float __temp_c19__ = (__temp_c18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))] = __temp_c19__;
      // iter 3 : __iter_4__ + 3
      float __temp_d5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d6__ = (5 * __temp_b17__ + 12 * __temp_d5__);
      float __temp_d10__ = (__temp_d6__ + 15 * __temp_c17__);
      float __temp_d13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d14__ = (__temp_d10__ + 12 * __temp_d13__);
      float __temp_d17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d18__ = (__temp_d14__ + 5 * __temp_d17__);
      float __temp_d19__ = (__temp_d18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-(__iter_1__+0)))] = __temp_d19__;
    }
  }
  else if( __iter_4__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(N-2)) ){
    int __iter_5__;
    __iter_5__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
      // iter 0 : __iter_4__
      float __temp_a2__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a6__ = (5 * __temp_a2__ + 12 * __temp_a5__);
      float __temp_a9__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a10__ = (__temp_a6__ + 15 * __temp_a9__);
      float __temp_a13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a14__ = (__temp_a10__ + 12 * __temp_a13__);
      float __temp_a17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a18__ = (__temp_a14__ + 5 * __temp_a17__);
      float __temp_a19__ = (__temp_a18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-(__iter_1__+0)))] = __temp_a19__;
      // iter 1 : __iter_4__ + 1
      float __temp_b5__ = (__tilevar_2__[__iter_5__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b6__ = (5 * __temp_a9__ + 12 * __temp_b5__);
      float __temp_b10__ = (__temp_b6__ + 15 * __temp_a17__);
      float __temp_b13__ = (__tilevar_2__[__iter_5__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b14__ = (__temp_b10__ + 12 * __temp_b13__);
      float __temp_b17__ = (__tilevar_2__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b18__ = (__temp_b14__ + 5 * __temp_b17__);
      float __temp_b19__ = (__temp_b18__ / 118);
      __tilevar_3__[__iter_5__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b19__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) {
    int __iter_6__ = FORMA_MAX((__iter_1__-3),1);
    for(; __iter_6__ < FORMA_MAX((__iter_1__-1),1); __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
         __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_6__ = FORMA_MIN(((__iter_1__+GAPY+1)),(N-2));
    for(; __iter_6__ < FORMA_MIN(((__iter_1__+GAPY+3)),(N-2)) ; __iter_6__++) {
      int __iter_7__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_7__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
         __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_6__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2))) {
      int __iter_7__ = FORMA_MAX((__iter_0__-3),1);
      for(; __iter_7__ < FORMA_MAX((__iter_0__-1),1); __iter_7__++) {
        __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_6__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.x) ; 
    if(__iter_6__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2))) {
      int __iter_7__ = FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2))+1;
      for(; __iter_7__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ; __iter_7__++){
        __tilevar_3__[__iter_7__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_6__+(EXTENT-(__iter_1__+0)))] = __copy_arr_0__[__iter_7__+(M-0)*(__iter_6__)];
      }
    }
  }
  __syncthreads();
  int __iter_10__;
  __iter_10__ = FORMA_MAX((__iter_1__-2),1) + 4*(int)(threadIdx.y) ;
  if( __iter_10__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
      // iter 0 : __iter_10__ 
      float __temp_a32__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*( __iter_10__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a36__ = (5 * __temp_a32__ + 12 * __temp_a35__);
      float __temp_a39__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a40__ = (__temp_a36__ + 15 * __temp_a39__);
      float __temp_a43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a44__ = (__temp_a40__ + 12 * __temp_a43__);
      float __temp_a47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a48__ = (__temp_a44__ + 5 * __temp_a47__);
      float __temp_a49__ = (__temp_a48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))] = __temp_a49__;
      // iter 1 : __iter_10__ + 1
      float __temp_b35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b36__ = (5 * __temp_a39__ + 12 * __temp_b35__);
      float __temp_b40__ = (__temp_b36__ + 15 * __temp_a47__);
      float __temp_b43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b44__ = (__temp_b40__ + 12 * __temp_b43__);
      float __temp_b47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b48__ = (__temp_b44__ + 5 * __temp_b47__);
      float __temp_b49__ = (__temp_b48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b49__;
      // iter 2 : __iter_10__ + 2
      float __temp_c35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c36__ = (5 * __temp_a47__ + 12 * __temp_c35__);
      float __temp_c40__ = (__temp_c36__ + 15 * __temp_b47__);
      float __temp_c43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c44__ = (__temp_c40__ + 12 * __temp_c43__);
      float __temp_c47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c48__ = (__temp_c44__ + 5 * __temp_c47__);
      float __temp_c49__ = (__temp_c48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))] = __temp_c49__;
      // iter 3 : __iter_10__ + 3
      float __temp_d35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d36__ = (5 * __temp_b47__ + 12 * __temp_d35__);
      float __temp_d40__ = (__temp_d36__ + 15 * __temp_c47__);
      float __temp_d43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d44__ = (__temp_d40__ + 12 * __temp_d43__);
      float __temp_d47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d48__ = (__temp_d44__ + 5 * __temp_d47__);
      float __temp_d49__ = (__temp_d48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(3)+(EXTENT-(__iter_1__+0)))] = __temp_d49__;
    }
  }
  else if( __iter_10__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2)) ){
    int __iter_11__;
    __iter_11__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
    if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
      // iter 0 : __iter_10__ 
      float __temp_a32__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*( __iter_10__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a36__ = (5 * __temp_a32__ + 12 * __temp_a35__);
      float __temp_a39__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a40__ = (__temp_a36__ + 15 * __temp_a39__);
      float __temp_a43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a44__ = (__temp_a40__ + 12 * __temp_a43__);
      float __temp_a47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a48__ = (__temp_a44__ + 5 * __temp_a47__);
      float __temp_a49__ = (__temp_a48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0)))] = __temp_a49__;
      // iter 1 : __iter_10__ + 1
      float __temp_b35__ = (__tilevar_3__[__iter_11__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b36__ = (5 * __temp_a39__ + 12 * __temp_b35__);
      float __temp_b40__ = (__temp_b36__ + 15 * __temp_a47__);
      float __temp_b43__ = (__tilevar_3__[ __iter_11__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b44__ = (__temp_b40__ + 12 * __temp_b43__);
      float __temp_b47__ = (__tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b48__ = (__temp_b44__ + 5 * __temp_b47__);
      float __temp_b49__ = (__temp_b48__ / 118);
      __tilevar_4__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b49__;
    }
  }
  __syncthreads ();

  if (threadIdx.y == 0) {
    int __iter_12__ = FORMA_MAX((__iter_1__-4),1);
    for(; __iter_12__ < FORMA_MAX((__iter_1__-2),1); __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
        __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  else if (threadIdx.y == 1) {
    int __iter_12__ = FORMA_MIN(((__iter_1__+GAPY+2)-1),(N-2))+1;
    for(; __iter_12__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2)) ; __iter_12__++) {
      int __iter_13__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_13__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
        __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_12__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.x) ; 
    if(__iter_12__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2))) {
      int __iter_13__ = FORMA_MAX((__iter_0__-4),1);
      for(; __iter_13__ < FORMA_MAX((__iter_0__-2),1); __iter_13__++) {
        __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_12__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.x) ; 
    if(__iter_12__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2))) {
      int __iter_13__ = FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2))+1;
      for(; __iter_13__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ; __iter_13__++){
        __tilevar_4__[__iter_13__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_12__+(EXTENT-(__iter_1__+0)))] = __copy_arr_1__[__iter_13__+(M-0)*(__iter_12__)];
      }
    }
  }
  __syncthreads();
  int __iter_16__;
  __iter_16__ = FORMA_MAX((__iter_1__-3),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_16__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
      // iter 0 : __iter_16__
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a62__ = (5 * __temp_a60__ + 12 * __temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a64__ = (__temp_a62__ + 15 * __temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a66__ = (__temp_a64__ + 12 * __temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a68__ = (__temp_a66__ + 5 * __temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))] = __temp_a69__;
      // iter 1 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b62__ = (5 * __temp_a63__ + 12 * __temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15 * __temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b66__ = (__temp_b64__ + 12 * __temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b68__ = (__temp_b66__ + 5 * __temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b69__;
      // iter 2 : __iter_16__ + 2
      float __temp_c61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c62__ = (5 * __temp_a67__ + 12 * __temp_c61__);
      float __temp_c64__ = (__temp_c62__ + 15 * __temp_b67__);
      float __temp_c65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c66__ = (__temp_c64__ + 12 * __temp_c65__);
      float __temp_c67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c68__ = (__temp_c66__ + 5 * __temp_c67__);
      float __temp_c69__ = (__temp_c68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))] = __temp_c69__;
      // iter 3 : __iter_16__ + 3
      float __temp_d61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d62__ = (5 * __temp_b67__ + 12 * __temp_d61__);
      float __temp_d64__ = (__temp_d62__ + 15 * __temp_c67__);
      float __temp_d65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d66__ = (__temp_d64__ + 12 * __temp_d65__);
      float __temp_d67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d68__ = (__temp_d66__ + 5 * __temp_d67__);
      float __temp_d69__ = (__temp_d68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0)))] = __temp_d69__;
    }
  }
  else if( __iter_16__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2)) ){
    int __iter_17__;
    __iter_17__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
    if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
      // iter 0 : __iter_16__
      float __temp_a60__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a62__ = (5 * __temp_a60__ + 12 * __temp_a61__);
      float __temp_a63__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a64__ = (__temp_a62__ + 15 * __temp_a63__);
      float __temp_a65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a66__ = (__temp_a64__ + 12 * __temp_a65__);
      float __temp_a67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a68__ = (__temp_a66__ + 5 * __temp_a67__);
      float __temp_a69__ = (__temp_a68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0)))] = __temp_a69__;
      // iter 1 : __iter_16__ + 1
      float __temp_b61__ = (__tilevar_4__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b62__ = (5 * __temp_a63__ + 12 * __temp_b61__);
      float __temp_b64__ = (__temp_b62__ + 15 * __temp_a67__);
      float __temp_b65__ = (__tilevar_4__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b66__ = (__temp_b64__ + 12 * __temp_b65__);
      float __temp_b67__ = (__tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b68__ = (__temp_b66__ + 5 * __temp_b67__);
      float __temp_b69__ = (__temp_b68__ / 118);
      __tilevar_5__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0)))] = __temp_b69__;
    }
  }
  __syncthreads ();
  if (threadIdx.y == 0) { 
    int __iter_18__ = FORMA_MAX((__iter_1__-5),1);
    for(; __iter_18__ < FORMA_MAX((__iter_1__-3),1); __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__-5),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(M-2)) ){
        __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  else if (threadIdx.y == 1) { 
    int __iter_18__ = FORMA_MIN(((__iter_1__+GAPY+3)-1),(N-2))+1;
    for(; __iter_18__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(N-2)) ; __iter_18__++) {
      int __iter_19__ = FORMA_MAX((__iter_0__-5),1) + (int)(threadIdx.x) ; 
      if( __iter_19__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(M-2)) ){
        __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  else if (threadIdx.y == 2) {
    int __iter_18__ = FORMA_MAX((__iter_1__-5),1) + (int)(threadIdx.x) ; 
    if(__iter_18__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(N-2))) {
      int __iter_19__ = FORMA_MAX((__iter_0__-5),1);
      for(; __iter_19__ < FORMA_MAX((__iter_0__-3),1); __iter_19__++) {
        __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  else if (threadIdx.y == 3) {
    int __iter_18__ = FORMA_MAX((__iter_1__-5),1) + (int)(threadIdx.x) ; 
    if(__iter_18__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(N-2))) {
      int __iter_19__ = FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2))+1;
      for(; __iter_19__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(M-2)) ; __iter_19__++){
        __tilevar_5__[__iter_19__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_18__+(EXTENT-(__iter_1__+0)))] = __copy_arr_2__[__iter_19__+(M-0)*(__iter_18__)];
      }
    }
  }
  __syncthreads();
  int __iter_22__;
  __iter_22__ = FORMA_MAX((__iter_1__-4),1) + 4*(int)(threadIdx.y) ; 
  if( __iter_22__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
      // iter 0 : __iter_22__ 
      float __temp_a80__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a82__ = (5 * __temp_a80__ + 12 * __temp_a81__);
      float __temp_a83__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a84__ = (__temp_a82__ + 15 * __temp_a83__);
      float __temp_a85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a86__ = (__temp_a84__ + 12 * __temp_a85__);
      float __temp_a87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a88__ = (__temp_a86__ + 5 * __temp_a87__);
      float __temp_a89__ = (__temp_a88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_a89__;
      // iter 1 : __iter_22__ + 1
      float __temp_b81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b82__ = (5 * __temp_a83__ + 12 * __temp_b81__);
      float __temp_b84__ = (__temp_b82__ + 15 * __temp_a87__);
      float __temp_b85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b86__ = (__temp_b84__ + 12 * __temp_b85__);
      float __temp_b87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b88__ = (__temp_b86__ + 5 * __temp_b87__);
      float __temp_b89__ = (__temp_b88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+1)] = __temp_b89__;
      // iter 2 : __iter_22__ + 2
      float __temp_c81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c82__ = (5 * __temp_a87__ + 12 * __temp_c81__);
      float __temp_c84__ = (__temp_c82__ + 15 * __temp_b87__);
      float __temp_c85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c86__ = (__temp_c84__ + 12 * __temp_c85__);
      float __temp_c87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_c88__ = (__temp_c86__ + 5 * __temp_c87__);
      float __temp_c89__ = (__temp_c88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+2)] = __temp_c89__;
      // iter 3 : __iter_22__ + 3
      float __temp_d81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d82__ = (5 * __temp_b87__ + 12 * __temp_d81__);
      float __temp_d84__ = (__temp_d82__ + 15 * __temp_c87__);
      float __temp_d85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(3)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d86__ = (__temp_d84__ + 12 * __temp_d85__);
      float __temp_d87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(4)+(EXTENT-(__iter_1__+0)))]);
      float __temp_d88__ = (__temp_d86__ + 5 * __temp_d87__);
      float __temp_d89__ = (__temp_d88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+3)] = __temp_d89__;
    }
  }
  else if( __iter_22__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(N-2)) ){
    int __iter_23__;
    __iter_23__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
    if( __iter_23__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
      // iter 0 : __iter_22__ 
      float __temp_a80__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(-1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a82__ = (5 * __temp_a80__ + 12 * __temp_a81__);
      float __temp_a83__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a84__ = (__temp_a82__ + 15 * __temp_a83__);
      float __temp_a85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(EXTENT-(__iter_1__+0)))]);
      float __temp_a86__ = (__temp_a84__ + 12 * __temp_a85__);
      float __temp_a87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_a88__ = (__temp_a86__ + 5 * __temp_a87__);
      float __temp_a89__ = (__temp_a88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__)] = __temp_a89__;
      // iter 1 : __iter_22__ + 1
      float __temp_b81__ = (__tilevar_5__[__iter_23__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b82__ = (5 * __temp_a83__ + 12 * __temp_b81__);
      float __temp_b84__ = (__temp_b82__ + 15 * __temp_a87__);
      float __temp_b85__ = (__tilevar_5__[__iter_23__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(1)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b86__ = (__temp_b84__ + 12 * __temp_b85__);
      float __temp_b87__ = (__tilevar_5__[__iter_23__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_22__+(2)+(EXTENT-(__iter_1__+0)))]);
      float __temp_b88__ = (__temp_b86__ + 5 * __temp_b87__);
      float __temp_b89__ = (__temp_b88__ / 118);
      __var_1__[__iter_23__+(M-0)*(__iter_22__+1)] = __temp_b89__;
    }
  }
}


/*Device code End */
/* Host Code Begin */
extern "C" void jacobi(float * h_input, int N, int M, float * __var_0__){

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
  float * __copy_arr_t0__;
  cudaMalloc(&__copy_arr_t0__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_t0__\n");
  float * __copy_arr_t1__;
  cudaMalloc(&__copy_arr_t1__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_t1__\n");
  float * __copy_arr_t2__;
  cudaMalloc(&__copy_arr_t2__,sizeof(float)*((N-0)*(M-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_t2__\n");

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
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x+GAPX);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y+GAPY);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__);
  dim3 unrollConfig(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/4);
  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __copy_arr_t0__, __copy_arr_t1__, __copy_arr_t2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");
  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __copy_arr_t0__, __copy_arr_t1__, __copy_arr_t2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");
  dim3 __blockConfig___kernel___forma_kernel__2__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y);
  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __copy_arr_t0__, __copy_arr_t1__, __copy_arr_t2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");
  dim3 __blockConfig___kernel___forma_kernel__3__(__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y);
  __kernel___forma_kernel__3__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, N, M, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __copy_arr_t0__, __copy_arr_t1__, __copy_arr_t2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__3__\n");

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
