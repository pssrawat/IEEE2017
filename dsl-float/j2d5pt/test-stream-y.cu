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
#define EXTENT (5)
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

__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X);
  float* __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X);
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X);
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X);
  int rowy = FORMA_BLOCKDIM_Y + 2;
 
  int threadIdx_y = mod((int)threadIdx.y,2);

  int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X + GAPX);
  for (int __iter_1__ = 0; __iter_1__ <= N-1; __iter_1__ += FORMA_BLOCKDIM_Y) {
    int __iter_2__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ; 
    if( __iter_2__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-1)) ){
      int __iter_3__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_3__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(M-1)) ){
        __tilevar_2__[__iter_3__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_2__,rowy)] = input[__iter_3__+M*__iter_2__];
      }
    }
    __syncthreads();
    int __iter_4__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.y) ; 
    if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
      int __iter_5__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
        float __temp_2__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_4__-1),rowy)]);
        float __temp_5__ = (__tilevar_2__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_6__ = (5 * __temp_2__ + 12 * __temp_5__);
        float __temp_9__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_10__ = (__temp_6__ + 15 * __temp_9__);
        float __temp_13__ = (__tilevar_2__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_14__ = (__temp_10__ + 12 * __temp_13__);
        float __temp_17__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_4__+1),rowy)]);
        float __temp_18__ = (__temp_14__ + 5 * __temp_17__);
        float __temp_19__ = (__temp_18__ / 118);
        __tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)] = __temp_19__;
      }
    }
    __syncthreads ();
    if (threadIdx.y < 2) {
      int __iter_6__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
        int __iter_7__ = FORMA_MAX((__iter_0__+1),1) + threadIdx_y;
        if( __iter_7__ < (FORMA_MAX((__iter_0__+1),1)+2)) {
          __copy_arr_0__[__iter_6__+(M)*(__iter_7__)] = __tilevar_3__[__iter_7__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_6__,rowy)];
        }
      }
    }
    else if (threadIdx.y < 4) {
      int __iter_6__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
        int __iter_7__ = FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2))-1 + threadIdx_y;
        if( __iter_7__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(M-2)) ){
          __copy_arr_0__[__iter_6__+(M)*(__iter_7__)] = __tilevar_3__[__iter_7__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_6__,rowy)];
        }
      }
    }
    __syncthreads();
    int __iter_10__ = FORMA_MAX((__iter_1__-2),2) + (int)(threadIdx.y) ; 
    if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
      int __iter_11__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
        float __temp_32__ = (__tilevar_3__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_10__-1),rowy)]);
        float __temp_35__ = (__tilevar_3__[__iter_11__+(-1)-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_36__ = (5 * __temp_32__ + 12 * __temp_35__);
        float __temp_39__ = (__tilevar_3__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_40__ = (__temp_36__ + 15 * __temp_39__);
        float __temp_43__ = (__tilevar_3__[__iter_11__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_44__ = (__temp_40__ + 12 * __temp_43__);
        float __temp_47__ = (__tilevar_3__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_10__+1),rowy)]);
        float __temp_48__ = (__temp_44__ + 5 * __temp_47__);
        float __temp_49__ = (__temp_48__ / 118);
        __tilevar_4__[__iter_11__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)] = __temp_49__;
      }
    }
    __syncthreads ();
    if (threadIdx.y < 2) {
      int __iter_12__ = FORMA_MAX((__iter_1__-2),2) + (int)(threadIdx.x) ; 
      if( __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
        int __iter_13__ = FORMA_MAX((__iter_0__+2),1) + threadIdx_y;
        if( __iter_13__ < (FORMA_MAX((__iter_0__+2),1)+2)) {
          __copy_arr_1__[__iter_12__+(M)*(__iter_13__)] = __tilevar_4__[__iter_13__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_12__,rowy)];
        }
      }
    }
    else if (threadIdx.y < 4) {
      int __iter_12__ = FORMA_MAX((__iter_1__-2),2) + (int)(threadIdx.x) ; 
      if( __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
        int __iter_13__ = FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2))-1 + threadIdx_y;
        if( __iter_13__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(M-2)) ){
          __copy_arr_1__[__iter_12__+(M)*(__iter_13__)] = __tilevar_4__[__iter_13__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_12__,rowy)];
        }
      }
    }
    __syncthreads();
    int __iter_16__ = FORMA_MAX((__iter_1__-3),3) + (int)(threadIdx.y) ; 
    if( __iter_16__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-4)) ){
      int __iter_17__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
        float __temp_60__ = (__tilevar_4__[__iter_17__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_16__-1),rowy)]);
        float __temp_61__ = (__tilevar_4__[__iter_17__+(-1)-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)]);
        float __temp_62__ = (5 * __temp_60__ + 12 * __temp_61__);
        float __temp_63__ = (__tilevar_4__[__iter_17__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)]);
        float __temp_64__ = (__temp_62__ + 15 * __temp_63__);
        float __temp_65__ = (__tilevar_4__[__iter_17__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)]);
        float __temp_66__ = (__temp_64__ + 12 * __temp_65__);
        float __temp_67__ = (__tilevar_4__[__iter_17__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_16__+1),rowy)]);
        float __temp_68__ = (__temp_66__ + 5 * __temp_67__);
        float __temp_69__ = (__temp_68__ / 118);
        __tilevar_5__[__iter_17__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)] = __temp_69__;
      }
    }
    __syncthreads ();
    if (threadIdx.y < 2) {
      int __iter_18__ = FORMA_MAX((__iter_1__-3),3) + (int)(threadIdx.x) ; 
      if( __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-4)) ){
        int __iter_19__ = FORMA_MAX((__iter_0__+3),1) + threadIdx_y;
        if( __iter_19__ < FORMA_MAX((__iter_0__+3),1)+2) {
          __copy_arr_2__[__iter_18__+(M)*(__iter_19__)] = __tilevar_5__[__iter_19__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_18__,rowy)];
        }
      }
    }
    else if (threadIdx.y < 4) {
      int __iter_18__ = FORMA_MAX((__iter_1__-3),3) + (int)(threadIdx.x) ; 
      if( __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-4)) ){
        int __iter_19__ = FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2))-1 + threadIdx_y;
        if( __iter_19__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(M-2)) ){
          __copy_arr_2__[__iter_18__+(M)*(__iter_19__)] = __tilevar_5__[__iter_19__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_18__,rowy)];
        }
      }
    }
    __syncthreads();
    int __iter_22__ = FORMA_MAX((__iter_1__-4),4) + (int)(threadIdx.y) ; 
    if( __iter_22__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-5)) ){
      int __iter_23__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_23__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(M-2)) ){
        float __temp_80__ = (__tilevar_5__[__iter_23__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_22__-1),rowy)]);
        float __temp_81__ = (__tilevar_5__[__iter_23__+(-1)-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_22__,rowy)]);
        float __temp_82__ = (5 * __temp_80__ + 12 * __temp_81__);
        float __temp_83__ = (__tilevar_5__[__iter_23__-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_22__,rowy)]);
        float __temp_84__ = (__temp_82__ + 15 * __temp_83__);
        float __temp_85__ = (__tilevar_5__[__iter_23__+1-__iter_0__+FORMA_BLOCKDIM_X*mod(__iter_22__,rowy)]);
        float __temp_86__ = (__temp_84__ + 12 * __temp_85__);
        float __temp_87__ = (__tilevar_5__[__iter_23__-__iter_0__+FORMA_BLOCKDIM_X*mod((__iter_22__+1),rowy)]);
        float __temp_88__ = (__temp_86__ + 5 * __temp_87__);
        float __temp_89__ = (__temp_88__ / 118);
        __var_1__[__iter_23__+(M)*(__iter_22__)] = __temp_89__;
      }
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  return SMemSize;
}

__global__ void __kernel___forma_kernel__1__(float * __restrict__ input, int N, int M, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  float* __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Y+2)*FORMA_BLOCKDIM_X));
  int rowy = FORMA_BLOCKDIM_Y + 2;
  int threadIdx_y = mod(threadIdx.y,2);
 
  int __iter_0__ = (int)(blockIdx.x)*((int)FORMA_BLOCKDIM_X + GAPX) + (int)FORMA_BLOCKDIM_X;
  for (int __iter_1__ = 0; __iter_1__ <= N-1; __iter_1__ += FORMA_BLOCKDIM_Y) {
    int __iter_2__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ; 
    if( __iter_2__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(N-1)) ){
      int __iter_3__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_3__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-1)) ){
        __tilevar_2__[__iter_3__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_2__,rowy)] = input[__iter_3__+(M)*(__iter_2__)];
      }
    }
    __syncthreads();
    int __iter_4__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.y) ; 
    if( __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
      int __iter_5__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) ){
        float __temp_2__ = (5 * __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_4__-1),rowy)]);
        float __temp_5__ = (12 * __tilevar_2__[__iter_5__+(-1)+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_6__ = (__temp_2__ + __temp_5__);
        float __temp_9__ = (15 * __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_10__ = (__temp_6__ + __temp_9__);
        float __temp_13__ = (12 * __tilevar_2__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)]);
        float __temp_14__ = (__temp_10__ + __temp_13__);
        float __temp_17__ = (5 * __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_4__+1),rowy)]);
        float __temp_18__ = (__temp_14__ + __temp_17__);
        float __temp_19__ = (__temp_18__ / 118);
        __tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_4__,rowy)] = __temp_19__;
      }
    }
    __syncthreads ();
    if (threadIdx.y < 2) {
      int __iter_6__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
        int __iter_7__ = FORMA_MAX((__iter_0__-3),1) + threadIdx_y;
        if( __iter_7__ < FORMA_MAX((__iter_0__-1),1)) {
          __tilevar_3__[__iter_7__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_6__,rowy)] = __copy_arr_0__[__iter_6__+(M)*(__iter_7__)];
        }
      }
    }
    else if (threadIdx.y < 4) {
      int __iter_6__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_6__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(N-2)) ){
        int __iter_7__ = FORMA_MIN(((__iter_0__+GAPX+1)-1),(M-2)) +1 + threadIdx_y;
        if( __iter_7__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
          __tilevar_3__[__iter_7__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_6__,rowy)] = __copy_arr_0__[__iter_6__+(M)*(__iter_7__)];
        }
      }
    }
    __syncthreads();
    int __iter_10__ = FORMA_MAX((__iter_1__-2),2) + (int)(threadIdx.y) ; 
    if( __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
      int __iter_11__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) ){
        float __temp_32__ = (5 * __tilevar_3__[__iter_11__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_10__-1),rowy)]);
        float __temp_35__ = (12 * __tilevar_3__[__iter_11__+(-1)+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_36__ = (__temp_32__ + __temp_35__);
        float __temp_39__ = (15 * __tilevar_3__[__iter_11__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_40__ = (__temp_36__ + __temp_39__);
        float __temp_43__ = (12 * __tilevar_3__[__iter_11__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)]);
        float __temp_44__ = (__temp_40__ + __temp_43__);
        float __temp_47__ = (5 * __tilevar_3__[__iter_11__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_10__+1),rowy)]);
        float __temp_48__ = (__temp_44__ + __temp_47__);
        float __temp_49__ = (__temp_48__ / 118);
        __tilevar_4__[__iter_11__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_10__,rowy)] = __temp_49__;
      }
    }
    __syncthreads ();
    if (threadIdx.y < 2) {
      int __iter_12__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
        int __iter_13__ = FORMA_MAX((__iter_0__-4),1) + threadIdx_y;
        if( __iter_13__ < FORMA_MAX((__iter_0__-2),1)) {
          __tilevar_4__[__iter_13__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_12__,rowy)] = __copy_arr_1__[__iter_12__+(M)*(__iter_13__)];
        }
      }
    }
    else if (threadIdx.y < 4) {
      int __iter_12__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_12__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(N-3)) ){
        int __iter_13__ = FORMA_MIN(((__iter_0__+GAPX+2)-1),(M-2)) + 1 + threadIdx_y;
        if( __iter_13__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
          __tilevar_4__[__iter_13__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_12__,rowy)] = __copy_arr_1__[__iter_12__+(M)*(__iter_13__)];
        }
      }
    }
    __syncthreads();
    int __iter_16__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    if( __iter_16__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-4)) ){
      int __iter_17__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) ){
        float __temp_60__ = (5 * __tilevar_4__[__iter_17__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_16__-1),rowy)]);
        float __temp_61__ = (12 * __tilevar_4__[__iter_17__+(-1)+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)]);
        float __temp_62__ = (__temp_60__ + __temp_61__);
        float __temp_63__ = (15 * __tilevar_4__[__iter_17__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)]);
        float __temp_64__ = (__temp_62__ + __temp_63__);
        float __temp_65__ = (12 * __tilevar_4__[__iter_17__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)]);
        float __temp_66__ = (__temp_64__ + __temp_65__);
        float __temp_67__ = (5 * __tilevar_4__[__iter_17__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_16__+1),rowy)]);
        float __temp_68__ = (__temp_66__ + __temp_67__);
        float __temp_69__ = (__temp_68__ / 118);
        __tilevar_5__[__iter_17__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_16__,rowy)] = __temp_69__;
      }
    }
    __syncthreads ();
    if (threadIdx.y < 2) {
      int __iter_18__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-4)) ){
        int __iter_19__ = FORMA_MAX((__iter_0__-5),1) + threadIdx_y;
        if( __iter_19__ < FORMA_MAX((__iter_0__-3),1)) {
          __tilevar_5__[__iter_19__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_18__,rowy)] = __copy_arr_2__[__iter_18__+(M)*(__iter_19__)];
        }
      }
    }
    else if (threadIdx.y < 4) {
      int __iter_18__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_18__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(N-4)) ){
        int __iter_19__ = FORMA_MIN(((__iter_0__+GAPX+3)-1),(M-2)) + 1 + threadIdx_y;
        if( __iter_19__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(M-2)) ){
          __tilevar_5__[__iter_19__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_18__,rowy)] = __copy_arr_2__[__iter_18__+(M)*(__iter_19__)];
        }
      }
    }
    __syncthreads();
    int __iter_22__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.y) ; 
    if( __iter_22__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(N-5)) ){
      int __iter_23__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_23__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(M-2)) ){
        float __temp_80__ = (5 * __tilevar_5__[__iter_23__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_22__-1),rowy)]);
        float __temp_81__ = (12 * __tilevar_5__[__iter_23__+(-1)+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_22__,rowy)]);
        float __temp_82__ = (__temp_80__ + __temp_81__);
        float __temp_83__ = (15 * __tilevar_5__[__iter_23__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_22__,rowy)]);
        float __temp_84__ = (__temp_82__ + __temp_83__);
        float __temp_85__ = (12 * __tilevar_5__[__iter_23__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod(__iter_22__,rowy)]);
        float __temp_86__ = (__temp_84__ + __temp_85__);
        float __temp_87__ = (5 * __tilevar_5__[__iter_23__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*mod((__iter_22__+1),rowy)]);
        float __temp_88__ = (__temp_86__ + __temp_87__);
        float __temp_89__ = (__temp_88__ / 118);
        __var_1__[__iter_23__+(M)*(__iter_22__)] = __temp_89__;
      }
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
  int __block_0___kernel___forma_kernel__0__ = 32;
  int __block_1___kernel___forma_kernel__0__ = 6;
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
