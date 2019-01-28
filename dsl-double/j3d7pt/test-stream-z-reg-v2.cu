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
#define GAPY (22)
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
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY);
  float t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  float b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;

  // Initialize the values
  int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ; 
  if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
      __tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = input[__iter_5__+N*(__iter_4__+M*(0))];
      t2 = input[__iter_5__+N*(__iter_4__+M*(1))];  
    }
  }
  // Rest of the computation
  for (int __iter_2__ = 1; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
        b2 = __tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        __tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t2; 
        t2 = input[__iter_5__+N*(__iter_4__+M*(__iter_2__+1))]; 
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        float __temp_a3__ = (__tilevar_2__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a7__ = (__tilevar_2__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a8__ = (0.161f * __temp_a3__ + 0.162f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a13__ = (__temp_a8__ + 0.163f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a18__ = (__temp_a13__ + 0.164f * __temp_a17__);
        float __temp_a23__ = (__temp_a18__ + 0.165f * t2);
        float __temp_a28__ = (__temp_a23__ + 0.166f * b2);
        float __temp_a32__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a33__ = (__temp_a28__ - 1.670f * __temp_a32__);
	b3 = __tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]; 
        __tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t3;
        t3 = __temp_a33__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__+1),1)+2) | __iter_4__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2) | __iter_5__ < (FORMA_MAX((__iter_0__+1),1)+2) | __iter_5__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t3;
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        float __temp_a50__ = (__tilevar_3__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a54__ = (__tilevar_3__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a55__ = (0.161f * __temp_a50__ + 0.162f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a60__ = (__temp_a55__ + 0.163f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a65__ = (__temp_a60__ + 0.164f * __temp_a64__);
        float __temp_a70__ = (__temp_a65__ + 0.165f * t3);
        float __temp_a75__ = (__temp_a70__ + 0.166f * b3);
        float __temp_a79__ = (__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a80__ = (__temp_a75__ - 1.670f * __temp_a79__);
        b4 = __tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        __tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t4;
        t4 = __temp_a80__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+2),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__+2),1)+2) | __iter_4__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))-2) | __iter_5__ < (FORMA_MAX((__iter_0__+2),1)+2) | __iter_5__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))-2)) {
          __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t4;
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if( __iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        float __temp_a94__ = (__tilevar_4__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a95__ = (__tilevar_4__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a96__ = (0.161f * __temp_a94__ + 0.162f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a98__ = (__temp_a96__ + 0.163f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a100__ = (__temp_a98__ + 0.164f * __temp_a99__);
        float __temp_a102__ = (__temp_a100__ + 0.165f * t4);
        float __temp_a104__ = (__temp_a102__ + 0.166f * b4);
        float __temp_a105__ = (__tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a106__ = (__temp_a104__ - 1.670f * __temp_a105__);
        b5 = __tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        __tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t5;
        t5 = __temp_a106__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__+3),1)+2) | __iter_4__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))-2) | __iter_5__ < (FORMA_MAX((__iter_0__+3),1)+2) | __iter_5__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))-2)) {
          __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t5;
        }
      }
    }
    __syncthreads (); 
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        float __temp_a120__ = (__tilevar_5__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a121__ = (__tilevar_5__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a122__ = (0.161f * __temp_a120__ + 0.162f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a124__ = (__temp_a122__ + 0.163f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a126__ = (__temp_a124__ + 0.164f * __temp_a125__);
        float __temp_a128__ = (__temp_a126__ + 0.165f * t5);
        float __temp_a130__ = (__temp_a128__ + 0.166f * b5);
        float __temp_a131__ = (__tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a132__ = (__temp_a130__ - 1.670f * __temp_a131__);
        __var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-3,0))] = __temp_a132__;
      }
    }
  }
}

int __blockSizeToSMemSize___kernel___forma_kernel__0__(dim3 blockDim){
  int FORMA_BLOCKDIM_Y = (int)(blockDim.y);
  int FORMA_BLOCKDIM_X = (int)(blockDim.x);
  int SMemSize = 0;
  SMemSize += sizeof(float)*(4*FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  return SMemSize;
}

/* X+GAP, Y, Z */
__global__ void __kernel___forma_kernel__1__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX) + (int)FORMA_BLOCKDIM_X;
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY);
  float t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  float b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;

  // Initialize the values
  int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__-EXTENT,0) + (int)(threadIdx.x) ;

  if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
       __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = input[__iter_5__+N*(__iter_4__+M*(0))];
       t2 = input[__iter_5__+N*(__iter_4__+M*(1))];
    }
  }
  // Rest of the computation
  for (int __iter_2__ = 1; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1))) {
       if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
	b2 = __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t2;
	t2 = input[__iter_5__+N*(__iter_4__+M*(__iter_2__+1))];
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if( __iter_5__ >= FORMA_MAX((__iter_0__-1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
        float __temp_a3__ = (__tilevar_2__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a7__ = (__tilevar_2__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a8__ = (0.161f * __temp_a3__ + 0.162f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a13__ = (__temp_a8__ + 0.163f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a18__ = (__temp_a13__ + 0.164f * __temp_a17__);
        float __temp_a23__ = (__temp_a18__ + 0.165f * t2);
        float __temp_a28__ = (__temp_a23__ + 0.166f * b2);
        float __temp_a32__ = (__tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a33__ = (__temp_a28__ - 1.670f * __temp_a32__);
	b3 = __tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
	__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t3;
	t3 = __temp_a33__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__+1),1)+2) | __iter_4__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))-2)) {
          __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t3;
        }
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_5__ < FORMA_MAX((__iter_0__-1),1) | __iter_5__ > FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2))) {
	 b3 = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
         __tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	 t3 = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-2),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
        float __temp_a50__ = (__tilevar_3__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a54__ = (__tilevar_3__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a55__ = (0.161f * __temp_a50__ + 0.162f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a60__ = (__temp_a55__ + 0.163f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a65__ = (__temp_a60__ + 0.164f * __temp_a64__);
        float __temp_a70__ = (__temp_a65__ + 0.165f * t3);
        float __temp_a75__ = (__temp_a70__ + 0.166f * b3);
        float __temp_a79__ = (__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a80__ = (__temp_a75__ - 1.670f * __temp_a79__);
        b4 = __tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        __tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t4;
        t4 = __temp_a80__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      if( __iter_5__ >= FORMA_MAX((__iter_0__-2),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__+2),1)+2) | __iter_4__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))-2)) {
          __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t4;
        }
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-4),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        if (__iter_5__ < FORMA_MAX((__iter_0__-2),1) | __iter_5__ > FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2))) {
	 b4 = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
         __tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	 t4 = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        float __temp_a94__ = (__tilevar_4__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a95__ = (__tilevar_4__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a96__ = (0.161f * __temp_a94__ + 0.162f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a98__ = (__temp_a96__ + 0.163f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a100__ = (__temp_a98__ + 0.164f * __temp_a99__);
        float __temp_a102__ = (__temp_a100__ + 0.165f * t4);
        float __temp_a104__ = (__temp_a102__ + 0.166f * b4);
        float __temp_a105__ = (__tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a106__ = (__temp_a104__ - 1.670f * __temp_a105__);
        b5 = __tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)];
        __tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = t5;
        t5 = __temp_a106__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__+3),1)+2) | __iter_4__ > (FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))-2)) {
          __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t5;
        }
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__+3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-5),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(N-2)) ){
        if (__iter_5__ < FORMA_MAX((__iter_0__-3),1) | __iter_5__ > FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2))) {
	  b5 = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
          __tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	  t5 = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+4),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-4),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        float __temp_a120__ = (__tilevar_5__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a121__ = (__tilevar_5__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a122__ = (0.161f * __temp_a120__ + 0.162f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_a124__ = (__temp_a122__ + 0.163f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_a126__ = (__temp_a124__ + 0.164f * __temp_a125__);
        float __temp_a128__ = (__temp_a126__ + 0.165f * t5);
        float __temp_a130__ = (__temp_a128__ + 0.166f * b5);
        float __temp_a131__ = (__tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_a132__ = (__temp_a130__ - 1.670f * __temp_a131__);
        __var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-3,0))] = __temp_a132__;
      }
    }
  }
}

/* X, Y+GAP, Z */
__global__ void __kernel___forma_kernel__2__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY) + (int)(FORMA_BLOCKDIM_Y);
  float t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  float b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;

  int __iter_4__ = FORMA_MAX(__iter_1__-EXTENT,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if(__iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
       __tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = input[__iter_5__+N*(__iter_4__+M*(0))];
       t2 = input[__iter_5__+N*(__iter_4__+M*(1))]; 
    }
  }
  // Rest of the computation
  for (int __iter_2__ = 1; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
	b2 = __tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
	__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t2;
	t2 = input[__iter_5__+N*(__iter_4__+M*(__iter_2__+1))];
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        float __temp_a3__ = (__tilevar_2__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a7__ = (__tilevar_2__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a8__ = (0.161f * __temp_a3__ + 0.162f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a13__ = (__temp_a8__ + 0.163f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a18__ = (__temp_a13__ + 0.164f * __temp_a17__);
        float __temp_a23__ = (__temp_a18__ + 0.165f * t2);
        float __temp_a28__ = (__temp_a23__ + 0.166f * b2);
        float __temp_a32__ = (__tilevar_2__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a33__ = (__temp_a28__ - 1.670f * __temp_a32__);
	b3 = __tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
	__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t3;
	t3 = __temp_a33__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_5__ < (FORMA_MAX((__iter_0__+1),1)+2) | __iter_5__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))-2)) {
          __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t3;
        }
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2)) ){
        if (__iter_4__ < FORMA_MAX((__iter_1__-1),1) | __iter_4__ > FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
	  b3 = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
          __tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	  t3 = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+2),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        float __temp_a50__ = (__tilevar_3__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a54__ = (__tilevar_3__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a55__ = (0.161f * __temp_a50__ + 0.162f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a60__ = (__temp_a55__ + 0.163f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a65__ = (__temp_a60__ + 0.164f * __temp_a64__);
        float __temp_a70__ = (__temp_a65__ + 0.165f * t3);
        float __temp_a75__ = (__temp_a70__ + 0.166f * b3);
        float __temp_a79__ = (__tilevar_3__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a80__ = (__temp_a75__ - 1.670f * __temp_a79__);
	b4 = __tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
        __tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t4;
	t4 = __temp_a80__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+2),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_5__ < (FORMA_MAX((__iter_0__+2),1)+2) | __iter_5__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))-2)) {
          __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t4;
        }
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-4),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+2),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2)) ){
        if (__iter_4__ < FORMA_MAX((__iter_1__-2),1) | __iter_4__ > FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
	  b4 = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
          __tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	  t4 = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        float __temp_a94__ = (__tilevar_4__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a95__ = (__tilevar_4__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a96__ = (0.161f * __temp_a94__ + 0.162f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a98__ = (__temp_a96__ + 0.163f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a100__ = (__temp_a98__ + 0.164f * __temp_a99__);
        float __temp_a102__ = (__temp_a100__ + 0.165f * t4);
        float __temp_a104__ = (__temp_a102__ + 0.166f * b4);
        float __temp_a105__ = (__tilevar_4__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a106__ = (__temp_a104__ - 1.670f * __temp_a105__);
	b5 = __tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
        __tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t5;
	t5 = __temp_a106__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      if( __iter_5__ >= FORMA_MAX((__iter_0__+3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_5__ < (FORMA_MAX((__iter_0__+3),1)+2) | __iter_5__ > (FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))-2)) {
          __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__))] = t5;
        }
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-5),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__+3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2)) ){
        if (__iter_4__ < FORMA_MAX((__iter_1__-3),1) | __iter_4__ > FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
	 b5 = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
          __tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	 t5 = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-4),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      if( __iter_5__ >= FORMA_MAX((__iter_0__+4),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2)) ){
        float __temp_a120__ = (__tilevar_5__[__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a121__ = (__tilevar_5__[__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a122__ = (0.161f * __temp_a120__ + 0.162f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a124__ = (__temp_a122__ + 0.163f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a126__ = (__temp_a124__ + 0.164f * __temp_a125__);
        float __temp_a128__ = (__temp_a126__ + 0.165f * t5);
        float __temp_a130__ = (__temp_a128__ + 0.166f * b5);
        float __temp_a131__ = (__tilevar_5__[__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a132__ = (__temp_a130__ - 1.670f * __temp_a131__);
        __var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-3,0))] = __temp_a132__;
      }
    }
  }
}

/* X+GAP, Y+GAP, Z */
__global__ void __kernel___forma_kernel__3__(float * __restrict__ input, int L, int M, int N, float * __restrict__ __copy_arr_0__, float * __restrict__ __copy_arr_1__, float * __restrict__ __copy_arr_2__, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  int __FORMA_SHARED_MEM_OFFSET__ = 0;
  float* __tilevar_2__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_3__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_4__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);
  float* __tilevar_5__ = (float*)(__FORMA_SHARED_MEM__+__FORMA_SHARED_MEM_OFFSET__);
  __FORMA_SHARED_MEM_OFFSET__ += sizeof(float)*(FORMA_BLOCKDIM_Y*FORMA_BLOCKDIM_X);

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)+GAPX) + (int)(FORMA_BLOCKDIM_X);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)+GAPY) + (int)(FORMA_BLOCKDIM_Y);
  float t2=0.0f, t3=0.0f, t4=0.0f, t5=0.0f;
  float b2=0.0f, b3=0.0f, b4=0.0f, b5=0.0f;

  int __iter_4__ = FORMA_MAX(__iter_1__-EXTENT,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__-EXTENT,0) + (int)(threadIdx.x) ;
  if(__iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
    if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
      __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = input[__iter_5__+N*(__iter_4__+M*(0))];
      t2 = input[__iter_5__+N*(__iter_4__+M*(1))];
    }
  }
  for (int __iter_2__ = 1; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-1))) {
      if( __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-1)) ){
        b2 = __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
        __tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t2;
        t2 = input[__iter_5__+N*(__iter_4__+M*(__iter_2__+1))];
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2)) ){
        float __temp_a3__ = (__tilevar_2__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a7__ = (__tilevar_2__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a8__ = (0.161f * __temp_a3__ + 0.162f * __temp_a7__);
        float __temp_a12__ = (__tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a13__ = (__temp_a8__ + 0.163f * __temp_a12__);
        float __temp_a17__ = (__tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a18__ = (__temp_a13__ + 0.164f * __temp_a17__);
        float __temp_a23__ = (__temp_a18__ + 0.165f * t2);
        float __temp_a28__ = (__temp_a23__ + 0.166f * b2);
        float __temp_a32__ = (__tilevar_2__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a33__ = (__temp_a28__ - 1.670f * __temp_a32__);
	b3 = __tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
        __tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t3;
	t3 = __temp_a33__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        if (__iter_4__ < FORMA_MAX((__iter_1__-1),1) | __iter_4__ > FORMA_MIN(((__iter_1__+GAPY+1)-1),(M-2)) | __iter_5__ < FORMA_MAX((__iter_0__-1),1) | __iter_5__ > FORMA_MIN(((__iter_0__+GAPX+1)-1),(N-2))) {
	 b3 = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
         __tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	 t3 = __copy_arr_0__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-2),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2)) ){
        float __temp_a50__ = (__tilevar_3__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a54__ = (__tilevar_3__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a55__ = (0.161f * __temp_a50__ + 0.162f * __temp_a54__);
        float __temp_a59__ = (__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a60__ = (__temp_a55__ + 0.163f * __temp_a59__);
        float __temp_a64__ = (__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a65__ = (__temp_a60__ + 0.164f * __temp_a64__);
        float __temp_a70__ = (__temp_a65__ + 0.165f * t3);
        float __temp_a75__ = (__temp_a70__ + 0.166f * b3);
        float __temp_a79__ = (__tilevar_3__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a80__ = (__temp_a75__ - 1.670f * __temp_a79__);
	b4 = __tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
        __tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t4;
	t4 = __temp_a80__;
      }
    }
    if( __iter_4__ >= FORMA_MAX((__iter_1__-4),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-4),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__-2),1)) | __iter_4__ > (FORMA_MIN(((__iter_1__+GAPY+2)-1),(M-2))) | __iter_5__ < FORMA_MAX((__iter_0__-2),1) | __iter_5__ > FORMA_MIN(((__iter_0__+GAPX+2)-1),(N-2))) {
	  b4 = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
          __tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	  t4 = __copy_arr_1__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) {
      if( __iter_5__ >= FORMA_MAX((__iter_0__-3),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2)) ){
        float __temp_a94__ = (__tilevar_4__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a95__ = (__tilevar_4__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a96__ = (0.161f * __temp_a94__ + 0.162f * __temp_a95__);
        float __temp_a97__ = (__tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a98__ = (__temp_a96__ + 0.163f * __temp_a97__);
        float __temp_a99__ = (__tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a100__ = (__temp_a98__ + 0.164f * __temp_a99__);
        float __temp_a102__ = (__temp_a100__ + 0.165f * t4);
        float __temp_a104__ = (__temp_a102__ + 0.166f * b4);
        float __temp_a105__ = (__tilevar_4__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a106__ = (__temp_a104__ - 1.670f * __temp_a105__);
	b5 = __tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))];
        __tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = t5;
	t5 = __temp_a106__;
      }
    }
    if(__iter_4__ >= FORMA_MAX((__iter_1__-5),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+5)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-5),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+5)-1),(N-2)) ){
        if (__iter_4__ < (FORMA_MAX((__iter_1__-3),1)) | __iter_4__ > (FORMA_MIN(((__iter_1__+GAPY+3)-1),(M-2))) | __iter_5__ < FORMA_MAX((__iter_0__-3),1) | __iter_5__ > FORMA_MIN(((__iter_0__+GAPX+3)-1),(N-2))) {
	  b5 = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__-2))];
          __tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))] = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__-1))];
	  t5 = __copy_arr_2__[__iter_5__+N*(__iter_4__+M*(__iter_2__))];
        }
      }
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__-4),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+GAPY+4)-1),(M-2))) {
      if(__iter_5__ >= FORMA_MAX((__iter_0__-4),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+GAPX+4)-1),(N-2)) ){
        float __temp_a120__ = (__tilevar_5__[__iter_5__+1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a121__ = (__tilevar_5__[__iter_5__-1+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a122__ = (0.161f * __temp_a120__ + 0.162f * __temp_a121__);
        float __temp_a123__ = (__tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+1+(EXTENT-__iter_1__))]);
        float __temp_a124__ = (__temp_a122__ + 0.163f * __temp_a123__);
        float __temp_a125__ = (__tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__-1+(EXTENT-__iter_1__))]);
        float __temp_a126__ = (__temp_a124__ + 0.164f * __temp_a125__);
        float __temp_a128__ = (__temp_a126__ + 0.165f * t5);
        float __temp_a130__ = (__temp_a128__ + 0.166f * b5);
        float __temp_a131__ = (__tilevar_5__[__iter_5__+(EXTENT-__iter_0__)+FORMA_BLOCKDIM_X*(__iter_4__+(EXTENT-__iter_1__))]);
        float __temp_a132__ = (__temp_a130__ - 1.670f * __temp_a131__);
        __var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-3,0))] = __temp_a132__;
      }
    }
  }
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d7pt(float * h_input, int L, int M, int N, float * __var_0__){

/* Host allocation Begin */
  float * input;
  cudaMalloc(&input,sizeof(float)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : input\n");
  cudaPointerAttributes ptrAttrib_h_input;
  cudaMemcpyKind memcpy_kind_h_input = cudaMemcpyHostToDevice;
  if (cudaPointerGetAttributes(&ptrAttrib_h_input, h_input) == cudaSuccess)
    if (ptrAttrib_h_input.memoryType == cudaMemoryTypeDevice)
      memcpy_kind_h_input = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  if( memcpy_kind_h_input != cudaMemcpyDeviceToDevice ){
    cudaMemcpy(input,h_input,sizeof(float)*(L*M*N), memcpy_kind_h_input);
  }
  float * __var_1__;
  cudaMalloc(&__var_1__,sizeof(float)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __var_1__\n");
  float * __copy_arr_0__;
  cudaMalloc(&__copy_arr_0__,sizeof(float)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_0__\n");
  float * __copy_arr_1__;
  cudaMalloc(&__copy_arr_1__,sizeof(float)*(L*M*N));
  Check_CUDA_Error("Allocation Error!! : __copy_arr_1__\n");
  float * __copy_arr_2__;
  cudaMalloc(&__copy_arr_2__,sizeof(float)*(L*M*N));
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
  int __size_0___kernel___forma_kernel__0__ = N;
  int __size_1___kernel___forma_kernel__0__ = M;
  int __block_0___kernel___forma_kernel__0__ = 32;
  int __block_1___kernel___forma_kernel__0__ = 32;
  int __block_2___kernel___forma_kernel__0__ = 1;
  dim3 __blockConfig___kernel___forma_kernel__0__(__block_0___kernel___forma_kernel__0__,__block_1___kernel___forma_kernel__0__,__block_2___kernel___forma_kernel__0__);
  int __SMemSize___kernel___forma_kernel__0__ = 0;
  __SMemSize___kernel___forma_kernel__0__ = __blockSizeToSMemSize___kernel___forma_kernel__0__(__blockConfig___kernel___forma_kernel__0__);
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x+GAPX);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y+GAPY);
  int __grid_2___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  dim3 unrollConfig (__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

  __kernel___forma_kernel__1__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__1__\n");

  __kernel___forma_kernel__2__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__2__\n");

  __kernel___forma_kernel__3__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig, __SMemSize___kernel___forma_kernel__0__>>> (input, L, M, N, __copy_arr_0__, __copy_arr_1__, __copy_arr_2__, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__3__\n");

  cudaPointerAttributes ptrAttrib___var_0__;
  cudaMemcpyKind memcpy_kind___var_0__ = cudaMemcpyDeviceToHost;
  if (cudaPointerGetAttributes(&ptrAttrib___var_0__, __var_0__) == cudaSuccess)
    if (ptrAttrib___var_0__.memoryType == cudaMemoryTypeDevice)
      memcpy_kind___var_0__ = cudaMemcpyDeviceToDevice;
  cudaGetLastError();
  cudaMemcpy(__var_0__,__var_1__, sizeof(float)*(L*M*N), memcpy_kind___var_0__);
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
