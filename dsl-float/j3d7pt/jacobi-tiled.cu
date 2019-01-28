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

#define GAPX (22)
#define GAPY (6)
#define GAPZ (2)
#define EXTENT (5)

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
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ);

  int __iter_3__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__,0) + 4*(int)(threadIdx.y) ; 
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__+1),1) + 4*(int)(threadIdx.y) ;
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+1))))] = __temp_a33__;
	// __iter_7__ + 1
	float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+1))))] = __temp_b33__;
	// __iter_7__ + 2
	float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+1))))] = __temp_c33__;
	// __iter_7__ + 3
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+1))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+1))))] = __temp_a33__;
	// __iter_7__ + 1
	float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+1))))] = __temp_b33__;
      }
    }
  }
  __syncthreads ();
  int __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__+1),1)+2) || __iter_9__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2))-2) || __iter_10__ < (FORMA_MAX((__iter_1__+1),1)+2) || __iter_10__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2) || __iter_11__ < (FORMA_MAX((__iter_0__+1),1)+2) || __iter_11__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+1))))];
        }
      }
    }
  }
  int __iter_15__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__+2),1) + 4*(int)(threadIdx.y) ;
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+1))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+1))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+2))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+1))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+1))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+2))))] = __temp_b80__;
	// __iter_16__ + 2
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+1))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+1))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+2))))] = __temp_c80__;
	// __iter_16__ + 3
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+1))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+1))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+2))))] = __temp_d80__;
      }
    }
    else if(__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+1))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+1))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+2))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+1))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+1))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+1))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+1))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+1))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+2))))] = __temp_b80__;
      }
    }
  }
  __syncthreads ();
  int __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__+2),1)+2) || __iter_18__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2))-2) || __iter_19__ < (FORMA_MAX((__iter_1__+2),1)+2) || __iter_19__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))-2) || __iter_20__ < (FORMA_MAX((__iter_0__+2),1)+2) || __iter_20__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+2))))];
        }
      }
    }
  }
  int __iter_24__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__+3),1) + 4*(int)(threadIdx.y) ;
    if(__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+2))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+2))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+3))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+2))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+2))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+3))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+2))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+2))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+3))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+2))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+2))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+3))))] = __temp_d106__;
      }
    }
    else if(__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+2))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+2))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+3))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+2))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+2))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+2))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+2))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+2))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+3))))] = __temp_b106__;
      }
    }
  }
  __syncthreads ();
  int __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__+3),1)+2) || __iter_27__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2))-2) || __iter_28__ < (FORMA_MAX((__iter_1__+3),1)+2) || __iter_28__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))-2) || __iter_29__ < (FORMA_MAX((__iter_0__+3),1)+2) || __iter_29__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+3))))];
        }
      }
    }
  }
  int __iter_33__ = FORMA_MAX((__iter_2__+4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-5),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__+4),1) + 4*(int)(threadIdx.y) ;
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+3))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+3))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ 
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+3))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+3))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ 
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+3))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+3))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ 
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+3))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+3))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+3))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+3))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+3))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+3))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+3))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+3))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+3))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Z = (int)(blockDim.z);
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  SMemSize += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  return SMemSize;
}

/* X+GAP, Y, Z */
__global__ void __kernel___forma_kernel__1__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX) + (int)(FORMA_BLOCKDIM_X);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ);

  int __iter_3__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__,0) + 4*(int)(threadIdx.y) ;
     if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__+1),1) + 4*(int)(threadIdx.y) ;
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__+1),1)+2) || __iter_9__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2))-2) || __iter_10__ < (FORMA_MAX((__iter_1__+1),1)+2) || __iter_10__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ;
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ;
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ;
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_11__ < FORMA_MAX((__iter_0__-1),1) || __iter_11__ > FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2))) {
         __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__+2),1) + 4*(int)(threadIdx.y) ;
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__ 
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1 
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2 
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 3 
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if(__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__ 
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1 
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__+2),1)+2) || __iter_18__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2))-2) || __iter_19__ < (FORMA_MAX((__iter_1__+2),1)+2) || __iter_19__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        if (__iter_20__ < FORMA_MAX((__iter_0__-2),1) || __iter_20__ > FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2))) {
          __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__+3),1) + 4*(int)(threadIdx.y) ;
    if(__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if(__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__+3),1)+2) || __iter_27__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2))-2) || __iter_28__ < (FORMA_MAX((__iter_1__+3),1)+2) || __iter_28__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-5),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(N-2)) ){
        if (__iter_29__ < FORMA_MAX((__iter_0__-3),1) || __iter_29__ > FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2))) {
          __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__+4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-5),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__+4),1) + 4*(int)(threadIdx.y) ;
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ + 3
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/* X, Y+GAP, Z */
__global__ void __kernel___forma_kernel__2__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY) + (int)(FORMA_BLOCKDIM_Y);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ);

  int __iter_3__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__-2,0) + 4*(int)(threadIdx.y) ;
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__-1),1) + 4*(int)(threadIdx.y) ;
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__+1),1)+2) || __iter_9__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2))-2) || __iter_11__ < (FORMA_MAX((__iter_0__+1),1)+2) || __iter_11__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_10__ < FORMA_MAX((__iter_1__-1),1) || __iter_10__ > FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
          __tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__-2),1) + 4*(int)(threadIdx.y) ;
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 3
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if(__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__+2),1)+2) || __iter_18__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2))-2) || __iter_20__ < (FORMA_MAX((__iter_0__+2),1)+2) || __iter_20__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_19__ < FORMA_MAX((__iter_1__-2),1) || __iter_19__ > FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
          __tilevar_4__[__iter_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__-3),1) + 4*(int)(threadIdx.y) ;
    if (__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if (__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__+3),1)+2) || __iter_27__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2))-2) || __iter_29__ < (FORMA_MAX((__iter_0__+3),1)+2) || __iter_29__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-5),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_28__ < FORMA_MAX((__iter_1__-3),1) || __iter_28__ > FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
          __tilevar_5__[__iter_29__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__+4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-5),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__-4),1) + 4*(int)(threadIdx.y) ;
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ + 3
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/* X, Y, Z+GAP */
__global__ void __kernel___forma_kernel__3__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ) + FORMA_BLOCKDIM_Z;

  int __iter_3__ = FORMA_MAX(__iter_2__-2,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__,0) + 4*(int)(threadIdx.y) ;
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__+1),1) + 4*(int)(threadIdx.y) ;
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__ 
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1 
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2 
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3 
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 2 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__ 
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1 
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2 
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_c33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__ 
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1 
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_10__ < (FORMA_MAX((__iter_1__+1),1)+2) || __iter_10__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2) || __iter_11__ < (FORMA_MAX((__iter_0__+1),1)+2) || __iter_11__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_9__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__-1),1)) || __iter_9__ > (FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)))) {
 	  __tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__+2),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 3
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if(__iter_16__ + 2 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_c80__;
      }
    }
    else if(__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_19__ < (FORMA_MAX((__iter_1__+2),1)+2) || __iter_19__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))-2) || __iter_20__ < (FORMA_MAX((__iter_0__+2),1)+2) || __iter_20__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_18__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__-2),1)) || __iter_18__ > (FORMA_MIN(((__iter_2__+2+GAPZ)-1),(L-2)))) {
	  __tilevar_4__[__iter_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__+3),1) + 4*(int)(threadIdx.y) ;
    if(__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__ 
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1 
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3 
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if(__iter_25__ + 2 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__ 
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1 
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_c106__;
      }
    }
    else if(__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__ 
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1 
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_28__ < (FORMA_MAX((__iter_1__+3),1)+2) || __iter_28__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))-2) || __iter_29__ < (FORMA_MAX((__iter_0__+3),1)+2) || __iter_29__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_27__ = FORMA_MAX((__iter_2__-5),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+5)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__-3),1)) || __iter_27__ > (FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)))) {
	  __tilevar_5__[__iter_29__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__+4),1) + 4*(int)(threadIdx.y) ;
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 2 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/* X+GAP, Y+GAP, Z */
__global__ void __kernel___forma_kernel__4__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX) + (int)(FORMA_BLOCKDIM_X);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY) + (int)(FORMA_BLOCKDIM_Y);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ);

  int __iter_3__ = FORMA_MAX(__iter_2__,0) + (int)(threadIdx.z) ; 
  for(; __iter_3__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__-2,0) + 4*(int)(threadIdx.y) ;
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ +  1<= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(0-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__-1),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2 
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3 
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 2 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2 
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_c33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(0-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(0-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__+1),1)+2) || __iter_9__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_9__ = FORMA_MAX((__iter_2__+1),1) + (int)(threadIdx.z) ;
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-2),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ;
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ;
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_10__ < FORMA_MAX((__iter_1__-1),1) || __iter_10__ > FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2)) || __iter_11__ < FORMA_MAX((__iter_0__-1),1) || __iter_11__ > FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2))) {
         __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(0-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
 __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__-2),1) + 4*(int)(threadIdx.y) ;
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 1
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 2
	float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if(__iter_16__ + 2 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 1
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_c80__;
      }
    }
    else if(__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(0-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__+2),1)+2) || __iter_18__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_18__ = FORMA_MAX((__iter_2__+2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-3),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        if (__iter_19__ < (FORMA_MAX((__iter_1__-2),1)) || __iter_19__ > (FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) || __iter_20__ < FORMA_MAX((__iter_0__-2),1) || __iter_20__ > FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2))) {
          __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(0-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__-3),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__ 
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if(__iter_25__ + 2 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__ 
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_c106__;
      }
    }
    else if(__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__ 
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(0-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__+3),1)+2) || __iter_27__ > (FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_27__ = FORMA_MAX((__iter_2__+3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-4),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-5),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-5),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(N-2)) ){
        if (__iter_28__ < (FORMA_MAX((__iter_1__-3),1)) || __iter_28__ > (FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) || __iter_29__ < FORMA_MAX((__iter_0__-3),1) || __iter_29__ > FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2))) {
          __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(0-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__+4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+FORMA_BLOCKDIM_Z)-5),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__-4),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1 
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ + 3
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 2 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1 
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1 
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(0-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(0-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(0-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/* X, Y+GAP, Z+GAP */
__global__ void __kernel___forma_kernel__5__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY) + (int)(FORMA_BLOCKDIM_Y);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ) + (int)(FORMA_BLOCKDIM_Z);

  int __iter_3__ = FORMA_MAX(__iter_2__-2,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__-2,0) + 4*(int)(threadIdx.y) ;
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(0-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__-1),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_11__ < (FORMA_MAX((__iter_0__+1),1)+2) || __iter_11__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_9__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__+1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__-1),1)) || __iter_9__ > (FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2))) ||__iter_10__ < FORMA_MAX((__iter_1__-1),1) || __iter_10__ > FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
          __tilevar_3__[__iter_11__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__-2),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2 
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 3
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if(__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
	// __iter_16__
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_20__ < (FORMA_MAX((__iter_0__+2),1)+2) || __iter_20__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_18__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__+2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__-2),1)) || __iter_18__ > (FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2))) || __iter_19__ < FORMA_MAX((__iter_1__-2),1) || __iter_19__ > FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
          __tilevar_4__[__iter_20__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__-3),1) + 4*(int)(threadIdx.y) ; 
    if (__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if (__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_29__ < (FORMA_MAX((__iter_0__+3),1)+2) || __iter_29__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_27__ = FORMA_MAX((__iter_2__-5),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+5)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-5),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__+3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__-3),1)) || __iter_27__ > (FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2))) || __iter_28__ < FORMA_MAX((__iter_1__-3),1) || __iter_28__ > FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
          __tilevar_5__[__iter_29__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__-4),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
        // __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ + 3
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__+4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
        // __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(0-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/* X+GAP, Y, Z+GAP */
__global__ void __kernel___forma_kernel__6__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX) + FORMA_BLOCKDIM_X;
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY);
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ) + FORMA_BLOCKDIM_Z;

  int __iter_3__ = FORMA_MAX(__iter_2__-2,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__,0) + 4*(int)(threadIdx.y) ;
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(0-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__+1),1) + 4*(int)(threadIdx.y) ;
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__ 
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1 
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2 
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3 
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if(__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__ 
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1 
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
        if (__iter_10__ < (FORMA_MAX((__iter_1__+1),1)+2) || __iter_10__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2)) {
          __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))] = __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_9__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__+1),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__-1),1)) || __iter_9__ > (FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2))) || __iter_11__ < (FORMA_MAX((__iter_0__-1),1)) || __iter_11__ > (FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)))) {
 	  __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__+2),1) + 4*(int)(threadIdx.y) ;
    if (__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__ 
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1 
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 3
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if (__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__ 
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1 
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
        if (__iter_19__ < (FORMA_MAX((__iter_1__+2),1)+2) || __iter_19__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))-2)) {
          __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))] = __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_18__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__+2),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__-2),1)) || __iter_18__ > (FORMA_MIN(((__iter_2__+2+GAPZ)-1),(L-2))) || __iter_20__ < (FORMA_MAX((__iter_0__-2),1)) || __iter_20__ > (FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)))) {
	  __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__+3),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if(__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25__ + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_28__ < (FORMA_MAX((__iter_1__+3),1)+2) || __iter_28__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))-2)) {
          __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))] = __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))];
        }
      }
    }
  }
  __iter_27__ = FORMA_MAX((__iter_2__-5),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+5)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__+3),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-5),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__-3),1)) || __iter_27__ > (FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2))) || __iter_29__ < (FORMA_MAX((__iter_0__-3),1)) || __iter_29__ > (FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)))) {
	  __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__+4),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1 
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2 
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ + 3 
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__ 
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(0-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1 
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/* X+GAP, Y+GAP, Z+GAP */
__global__ void __kernel___forma_kernel__7__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_0__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float* __tilevar_1__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(((FORMA_BLOCKDIM_Z-0)*(FORMA_BLOCKDIM_Y-0)*(FORMA_BLOCKDIM_X-0)));
  float * __tilevar_2__ = __tilevar_0__;
  float * __tilevar_3__ = __tilevar_1__;
  float * __tilevar_4__ = __tilevar_0__;
  float * __tilevar_5__ = __tilevar_1__;
  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX) + (int)FORMA_BLOCKDIM_X;
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY) + (int)FORMA_BLOCKDIM_Y;
  int __iter_2__ = (int)(blockIdx.z)*((int)(FORMA_BLOCKDIM_Z)+GAPZ) + (int)FORMA_BLOCKDIM_Z;

  int __iter_3__ = FORMA_MAX(__iter_2__-2,0) + (int)(threadIdx.z) ; 
  for( ; __iter_3__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-1)) ; __iter_3__+=(int)(blockDim.z) ){
    int __iter_4__ = FORMA_MAX(__iter_1__-2,0) + 4*(int)(threadIdx.y) ;
    if(__iter_4__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(2)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(2)+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(3)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(3)+(M-0)*(__iter_3__))];
      }
    }
    else if(__iter_4__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      int __iter_5__ = FORMA_MAX(__iter_0__-2,0) + (int)(threadIdx.x) ; 
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(M-0)*(__iter_3__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+(FORMA_BLOCKDIM_X-0)*(__iter_4__+(1)+(EXTENT-__iter_1__)+(FORMA_BLOCKDIM_Y-0)*(__iter_3__+(EXTENT-__iter_2__)))] = input[__iter_5__+(N-0)*(__iter_4__+(1)+(M-0)*(__iter_3__))];
      }
    }
  }
  __syncthreads();
  int __iter_6__ = FORMA_MAX((__iter_2__-1),1) + (int)(threadIdx.z) ; 
  for( ; __iter_6__ <= FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2)) ; __iter_6__+=(int)(blockDim.z) ){
    int __iter_7__ = FORMA_MAX((__iter_1__-1),1) + 4*(int)(threadIdx.y) ;
    if(__iter_7__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_c33__;
	// __iter_7__ + 3
        float __temp_d3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d8__ = (0.161000f * __temp_d3__ + 0.162000f * __temp_d7__);
        float __temp_d12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d13__ = (__temp_d8__ + 0.163000f * __temp_d12__);
        float __temp_d17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d18__ = (__temp_d13__ + 0.164000f * __temp_d17__);
        float __temp_d22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d23__ = (__temp_d18__ + 0.165000f * __temp_d22__);
        float __temp_d27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d28__ = (__temp_d23__ + 0.166000f * __temp_d27__);
        float __temp_d32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d33__ = (__temp_d28__ - 1.670000f * __temp_d32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_d33__;
      }
    }
    else if (__iter_7__ + 2 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
	// __iter_7__ + 2
        float __temp_c3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c8__ = (0.161000f * __temp_c3__ + 0.162000f * __temp_c7__);
        float __temp_c12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c13__ = (__temp_c8__ + 0.163000f * __temp_c12__);
        float __temp_c17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c18__ = (__temp_c13__ + 0.164000f * __temp_c17__);
        float __temp_c22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c23__ = (__temp_c18__ + 0.165000f * __temp_c22__);
        float __temp_c27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c28__ = (__temp_c23__ + 0.166000f * __temp_c27__);
        float __temp_c32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c33__ = (__temp_c28__ - 1.670000f * __temp_c32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_c33__;
      }
    }
    else if (__iter_7__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      int __iter_8__ = FORMA_MAX((__iter_0__-1),1) + (int)(threadIdx.x) ; 
      if( __iter_8__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
	// __iter_7__
        float __temp_a3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a8__ = (0.161000f * __temp_a3__ + 0.162000f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a13__ = (__temp_a8__ + 0.163000f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a18__ = (__temp_a13__ + 0.164000f * __temp_a17__);
        float __temp_a22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a23__ = (__temp_a18__ + 0.165000f * __temp_a22__);
        float __temp_a27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a28__ = (__temp_a23__ + 0.166000f * __temp_a27__);
        float __temp_a32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a33__ = (__temp_a28__ - 1.670000f * __temp_a32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_a33__;
	// __iter_7__ + 1
        float __temp_b3__ = (__tilevar_2__[__iter_8__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b7__ = (__tilevar_2__[__iter_8__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b8__ = (0.161000f * __temp_b3__ + 0.162000f * __temp_b7__);
        float __temp_b12__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b13__ = (__temp_b8__ + 0.163000f * __temp_b12__);
        float __temp_b17__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b18__ = (__temp_b13__ + 0.164000f * __temp_b17__);
        float __temp_b22__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b23__ = (__temp_b18__ + 0.165000f * __temp_b22__);
        float __temp_b27__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b28__ = (__temp_b23__ + 0.166000f * __temp_b27__);
        float __temp_b32__ = (__tilevar_2__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*( __iter_6__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b33__ = (__temp_b28__ - 1.670000f * __temp_b32__);
        __tilevar_3__[__iter_8__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_7__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_6__+(EXTENT-(__iter_2__+0))))] = __temp_b33__;
      }
    }
  }
  __syncthreads();
  int __iter_9__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_9__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_9__ += (int)(blockDim.z) ){
    int __iter_10__ = FORMA_MAX((__iter_1__-3),1) + (int)(threadIdx.y) ; 
    for(; __iter_10__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2)) ; __iter_10__ += (int)(blockDim.y)){
      int __iter_11__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_11__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_9__ < (FORMA_MAX((__iter_2__-1),1)) || __iter_9__ > (FORMA_MIN(((__iter_2__+GAPZ+1)-1),(L-2))) || __iter_10__ < (FORMA_MAX((__iter_1__-1),1)) || __iter_10__ > (FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) || __iter_11__ < (FORMA_MAX((__iter_0__-1),1)) || __iter_11__ > (FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)))) {
 	  __tilevar_3__[__iter_11__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_10__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_9__+(EXTENT-(__iter_2__+0))))] = __copy_arr_0__[__iter_11__+(N-0)*(__iter_10__+(M-0)*(__iter_9__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_15__ = FORMA_MAX((__iter_2__-2),1) + (int)(threadIdx.z) ; 
  for( ; __iter_15__ <= FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2)) ; __iter_15__ += (int)(blockDim.z) ){
    int __iter_16__ = FORMA_MAX((__iter_1__-2),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_16__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__ 
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
	// __iter_16__ + 2
        float __temp_c50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c55__ = (0.161000f * __temp_c50__ + 0.162000f * __temp_c54__);
        float __temp_c59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c60__ = (__temp_c55__ + 0.163000f * __temp_c59__);
        float __temp_c64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c65__ = (__temp_c60__ + 0.164000f * __temp_c64__);
        float __temp_c69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c70__ = (__temp_c65__ + 0.165000f * __temp_c69__);
        float __temp_c74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c75__ = (__temp_c70__ + 0.166000f * __temp_c74__);
        float __temp_c79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c80__ = (__temp_c75__ - 1.670000f * __temp_c79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_c80__;
	// __iter_16__ + 3
        float __temp_d50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d55__ = (0.161000f * __temp_d50__ + 0.162000f * __temp_d54__);
        float __temp_d59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d60__ = (__temp_d55__ + 0.163000f * __temp_d59__);
        float __temp_d64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d65__ = (__temp_d60__ + 0.164000f * __temp_d64__);
        float __temp_d69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d70__ = (__temp_d65__ + 0.165000f * __temp_d69__);
        float __temp_d74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d75__ = (__temp_d70__ + 0.166000f * __temp_d74__);
        float __temp_d79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d80__ = (__temp_d75__ - 1.670000f * __temp_d79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_d80__;
      }
    }
    else if (__iter_16__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      int __iter_17__ = FORMA_MAX((__iter_0__-2),1) + (int)(threadIdx.x) ; 
      if( __iter_17__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
	// __iter_16__ 
        float __temp_a50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a55__ = (0.161000f * __temp_a50__ + 0.162000f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a60__ = (__temp_a55__ + 0.163000f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a65__ = (__temp_a60__ + 0.164000f * __temp_a64__);
        float __temp_a69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a70__ = (__temp_a65__ + 0.165000f * __temp_a69__);
        float __temp_a74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a75__ = (__temp_a70__ + 0.166000f * __temp_a74__);
        float __temp_a79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a80__ = (__temp_a75__ - 1.670000f * __temp_a79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_a80__;
	// __iter_16__ + 1
        float __temp_b50__ = (__tilevar_3__[__iter_17__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b54__ = (__tilevar_3__[__iter_17__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b55__ = (0.161000f * __temp_b50__ + 0.162000f * __temp_b54__);
        float __temp_b59__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b60__ = (__temp_b55__ + 0.163000f * __temp_b59__);
        float __temp_b64__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b65__ = (__temp_b60__ + 0.164000f * __temp_b64__);
        float __temp_b69__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b70__ = (__temp_b65__ + 0.165000f * __temp_b69__);
        float __temp_b74__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b75__ = (__temp_b70__ + 0.166000f * __temp_b74__);
        float __temp_b79__ = (__tilevar_3__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b80__ = (__temp_b75__ - 1.670000f * __temp_b79__);
        __tilevar_4__[__iter_17__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_16__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_15__+(EXTENT-(__iter_2__+0))))] = __temp_b80__;
      }
    }
  }
  __syncthreads();
  int __iter_18__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_18__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_18__ += (int)(blockDim.z) ){
    int __iter_19__ = FORMA_MAX((__iter_1__-4),1) + (int)(threadIdx.y) ; 
    for(; __iter_19__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2)) ; __iter_19__ += (int)(blockDim.y) ){
      int __iter_20__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_20__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        if (__iter_18__ < (FORMA_MAX((__iter_2__-2),1)) || __iter_18__ > (FORMA_MIN(((__iter_2__+GAPZ+2)-1),(L-2))) || __iter_19__ < (FORMA_MAX((__iter_1__-2),1)) || __iter_19__ > (FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) || __iter_20__ < (FORMA_MAX((__iter_0__-2),1)) || __iter_20__ > (FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)))) {
	  __tilevar_4__[__iter_20__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_19__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_18__+(EXTENT-(__iter_2__+0))))] = __copy_arr_1__[__iter_20__+(N-0)*(__iter_19__+(M-0)*(__iter_18__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_24__ = FORMA_MAX((__iter_2__-3),1) + (int)(threadIdx.z) ; 
  for( ; __iter_24__ <= FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2)) ; __iter_24__ += (int)(blockDim.z) ){
    int __iter_25__ = FORMA_MAX((__iter_1__-3),1) + 4*(int)(threadIdx.y) ;
    if(__iter_25__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25 + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
	// __iter_25__ + 2
        float __temp_c94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c96__ = (0.161000f * __temp_c94__ + 0.162000f * __temp_c95__);
        float __temp_c97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c98__ = (__temp_c96__ + 0.163000f * __temp_c97__);
        float __temp_c99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c100__ = (__temp_c98__ + 0.164000f * __temp_c99__);
        float __temp_c101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c102__ = (__temp_c100__ + 0.165000f * __temp_c101__);
        float __temp_c103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c104__ = (__temp_c102__ + 0.166000f * __temp_c103__);
        float __temp_c105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c106__ = (__temp_c104__ - 1.670000f * __temp_c105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_c106__;
	// __iter_25__ + 3
        float __temp_d94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d96__ = (0.161000f * __temp_d94__ + 0.162000f * __temp_d95__);
        float __temp_d97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d98__ = (__temp_d96__ + 0.163000f * __temp_d97__);
        float __temp_d99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d100__ = (__temp_d98__ + 0.164000f * __temp_d99__);
        float __temp_d101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d102__ = (__temp_d100__ + 0.165000f * __temp_d101__);
        float __temp_d103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d104__ = (__temp_d102__ + 0.166000f * __temp_d103__);
        float __temp_d105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d106__ = (__temp_d104__ - 1.670000f * __temp_d105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_d106__;
      }
    }
    else if(__iter_25__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      int __iter_26__ = FORMA_MAX((__iter_0__-3),1) + (int)(threadIdx.x) ; 
      if( __iter_26__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
	// __iter_25__
        float __temp_a94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a96__ = (0.161000f * __temp_a94__ + 0.162000f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a98__ = (__temp_a96__ + 0.163000f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a100__ = (__temp_a98__ + 0.164000f * __temp_a99__);
        float __temp_a101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a102__ = (__temp_a100__ + 0.165000f * __temp_a101__);
        float __temp_a103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a104__ = (__temp_a102__ + 0.166000f * __temp_a103__);
        float __temp_a105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a106__ = (__temp_a104__ - 1.670000f * __temp_a105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_a106__;
	// __iter_25 + 1
        float __temp_b94__ = (__tilevar_4__[__iter_26__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b95__ = (__tilevar_4__[__iter_26__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b96__ = (0.161000f * __temp_b94__ + 0.162000f * __temp_b95__);
        float __temp_b97__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b98__ = (__temp_b96__ + 0.163000f * __temp_b97__);
        float __temp_b99__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b100__ = (__temp_b98__ + 0.164000f * __temp_b99__);
        float __temp_b101__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b102__ = (__temp_b100__ + 0.165000f * __temp_b101__);
        float __temp_b103__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b104__ = (__temp_b102__ + 0.166000f * __temp_b103__);
        float __temp_b105__ = (__tilevar_4__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b106__ = (__temp_b104__ - 1.670000f * __temp_b105__);
        __tilevar_5__[__iter_26__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_25__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_24__+(EXTENT-(__iter_2__+0))))] = __temp_b106__;
      }
    }
  }
  __syncthreads();
  int __iter_27__ = FORMA_MAX((__iter_2__-5),1) + (int)(threadIdx.z) ; 
  for( ; __iter_27__ <= FORMA_MIN(((__iter_2__+GAPZ+5)-1),(L-2)) ; __iter_27__ += (int)(blockDim.z) ){
    int __iter_28__ = FORMA_MAX((__iter_1__-5),1) + (int)(threadIdx.y) ; 
    for(; __iter_28__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(M-2)) ; __iter_28__ += (int)(blockDim.y)){
      int __iter_29__ = FORMA_MAX((__iter_0__-5),1) + (int)(threadIdx.x) ; 
      if( __iter_29__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(N-2)) ){
        if (__iter_27__ < (FORMA_MAX((__iter_2__-3),1)) || __iter_27__ > (FORMA_MIN(((__iter_2__+GAPZ+3)-1),(L-2))) || __iter_28__ < (FORMA_MAX((__iter_1__-3),1)) || __iter_28__ > (FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) || __iter_29__ < (FORMA_MAX((__iter_0__-3),1)) || __iter_29__ > (FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)))) {
	  __tilevar_5__[__iter_29__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_28__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_27__+(EXTENT-(__iter_2__+0))))] = __copy_arr_2__[__iter_29__+(N-0)*(__iter_28__+(M-0)*(__iter_27__))];
        }
      }
    }
  }
  __syncthreads();
  int __iter_33__ = FORMA_MAX((__iter_2__-4),1) + (int)(threadIdx.z) ; 
  for( ; __iter_33__ <= FORMA_MIN(((__iter_2__+GAPZ+4)-1),(L-2)) ; __iter_33__ += (int)(blockDim.z) ){
    int __iter_34__ = FORMA_MAX((__iter_1__-4),1) + 4*(int)(threadIdx.y) ; 
    if(__iter_34__ + 3 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
	// __iter_34__ + 2
        float __temp_c120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c122__ = (0.161000f * __temp_c120__ + 0.162000f * __temp_c121__);
        float __temp_c123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c124__ = (__temp_c122__ + 0.163000f * __temp_c123__);
        float __temp_c125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c126__ = (__temp_c124__ + 0.164000f * __temp_c125__);
        float __temp_c127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c128__ = (__temp_c126__ + 0.165000f * __temp_c127__);
        float __temp_c129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_c130__ = (__temp_c128__ + 0.166000f * __temp_c129__);
        float __temp_c131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(2)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_c132__ = (__temp_c130__ - 1.670000f * __temp_c131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(2)+(M-0)*(__iter_33__))] = __temp_c132__;
	// __iter_34__ + 3
        float __temp_d120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d122__ = (0.161000f * __temp_d120__ + 0.162000f * __temp_d121__);
        float __temp_d123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d124__ = (__temp_d122__ + 0.163000f * __temp_d123__);
        float __temp_d125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d126__ = (__temp_d124__ + 0.164000f * __temp_d125__);
        float __temp_d127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d128__ = (__temp_d126__ + 0.165000f * __temp_d127__);
        float __temp_d129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_d130__ = (__temp_d128__ + 0.166000f * __temp_d129__);
        float __temp_d131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(3)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_d132__ = (__temp_d130__ - 1.670000f * __temp_d131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(3)+(M-0)*(__iter_33__))] = __temp_d132__;
      }
    }
    else if(__iter_34__ + 1 <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      int __iter_35__ = FORMA_MAX((__iter_0__-4),1) + (int)(threadIdx.x) ; 
      if( __iter_35__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
	// __iter_34__
        float __temp_a120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a122__ = (0.161000f * __temp_a120__ + 0.162000f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a124__ = (__temp_a122__ + 0.163000f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a126__ = (__temp_a124__ + 0.164000f * __temp_a125__);
        float __temp_a127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a128__ = (__temp_a126__ + 0.165000f * __temp_a127__);
        float __temp_a129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_a130__ = (__temp_a128__ + 0.166000f * __temp_a129__);
        float __temp_a131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_a132__ = (__temp_a130__ - 1.670000f * __temp_a131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(M-0)*(__iter_33__))] = __temp_a132__;
	// __iter_34__ + 1
        float __temp_b120__ = (__tilevar_5__[__iter_35__+(1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b121__ = (__tilevar_5__[__iter_35__+(-1)+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b122__ = (0.161000f * __temp_b120__ + 0.162000f * __temp_b121__);
        float __temp_b123__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b124__ = (__temp_b122__ + 0.163000f * __temp_b123__);
        float __temp_b125__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(-1)+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b126__ = (__temp_b124__ + 0.164000f * __temp_b125__);
        float __temp_b127__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b128__ = (__temp_b126__ + 0.165000f * __temp_b127__);
        float __temp_b129__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(-1)+(EXTENT-(__iter_2__+0))))]);
        float __temp_b130__ = (__temp_b128__ + 0.166000f * __temp_b129__);
        float __temp_b131__ = (__tilevar_5__[__iter_35__+(EXTENT-(__iter_0__+0))+(FORMA_BLOCKDIM_X-0)*(__iter_34__+(1)+(EXTENT-(__iter_1__+0))+(FORMA_BLOCKDIM_Y-0)*(__iter_33__+(EXTENT-(__iter_2__+0))))]);
        float __temp_b132__ = (__temp_b130__ - 1.670000f * __temp_b131__);
        __var_1__[__iter_35__+(N-0)*(__iter_34__+(1)+(M-0)*(__iter_33__))] = __temp_b132__;
      }
    }
  }
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d7pt(float * h_input, int L, int M, int N, float * __var_0__){

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
  float * __copy_arr_0__;
  cudaMalloc(&__copy_arr_0__,sizeof(float)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_0__\n");
  float * __copy_arr_1__;
  cudaMalloc(&__copy_arr_1__,sizeof(float)*((L-0)*(M-0)*(N-0)));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_1__\n");
  float * __copy_arr_2__;
  cudaMalloc(&__copy_arr_2__,sizeof(float)*((L-0)*(M-0)*(N-0)));
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
  int __size_0___kernel___forma_kernel__0__ = ((N-1) - 0 ) + 1;
  int __size_1___kernel___forma_kernel__0__ = ((M-1) - 0 ) + 1;
  int __size_2___kernel___forma_kernel__0__ = ((L-1) - 0 ) + 1;
  int __block_0___kernel___forma_kernel__0__ = 32;
  int __block_1___kernel___forma_kernel__0__ = 16;
  int __block_2___kernel___forma_kernel__0__ = 12;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x+GAPX);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y+GAPY);
  int __grid_2___kernel___forma_kernel__0__ = FORMA_CEIL(__size_2___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.z+GAPZ);
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  dim3 unrollConfig (__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y/4, __blockConfig___kernel___forma_kernel__0__.z/3);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");

  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");

  __kernel___forma_kernel__3__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__3__\n");

  __kernel___forma_kernel__4__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__4__\n");

  __kernel___forma_kernel__5__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__5__\n");

  __kernel___forma_kernel__6__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__6__\n");

  __kernel___forma_kernel__7__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__7__\n");

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
  cudaFree(__copy_arr_0__);
  cudaFree(__copy_arr_1__);
  cudaFree(__copy_arr_2__);
}
/*Host Free End*/
