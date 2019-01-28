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
/* Device code Begin */
/* X, Y, Z */
__global__ void __kernel___forma_kernel__0__(float * __restrict__ input, int L, int M, int N, int FORMA_BLOCKDIM_X, int FORMA_BLOCKDIM_Y, int FORMA_BLOCKDIM_Z, float * __restrict__ __var_1__){
  __shared__ float tilevar[4][32*32];
  float t[4], b[4], out=0.0f;

  int __iter_0__ = (int)(blockIdx.x)*((int)(FORMA_BLOCKDIM_X)-8);
  int __iter_1__ = (int)(blockIdx.y)*((int)(FORMA_BLOCKDIM_Y)-8);
 
  // Initialize the values
  int __iter_4__ = FORMA_MAX(__iter_1__,0) + (int)(threadIdx.y) ;
  int __iter_5__ = FORMA_MAX(__iter_0__,0) + (int)(threadIdx.x) ;
  if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1)) ){
      tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = 0.0f;
      tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = 0.0f;
      tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = 0.0f;
  }
  // Rest of the computation
  for (int __iter_2__ = 0; __iter_2__ <= L-1; __iter_2__++) {
    if(__iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-1),(M-1)) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-1),(N-1))){
        tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = input[__iter_5__+N*(__iter_4__+M*(__iter_2__))]; 
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+1),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-2),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+1),1) & __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-2),(N-2))){
	// Bottom 
	float __temp_3__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_7__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_8__ = (0.5f * __temp_3__ + 0.7f *__temp_7__);
        float __temp_12__ = (tilevar[0][ __iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_13__ = (__temp_8__ + 0.9f * __temp_12__);
        float __temp_17__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_18__ = (__temp_13__ + 1.2f * __temp_17__);
        float __temp_22__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_23__ = (__temp_18__ + 1.5f * __temp_22__);
        float __temp_27__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_28__ = (__temp_23__ + 1.2f * __temp_27__);
        float __temp_32__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_33__ = (__temp_28__ + 0.9f * __temp_32__);
        float __temp_37__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_38__ = (__temp_33__ + 0.7f * __temp_37__);
        float __temp_42__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_43__ = (__temp_38__ + 0.5f * __temp_42__) / 159;
	t[0] += __temp_43__;
	//Mid 
        float __temp_47__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_52__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_53__ = (0.51f * __temp_47__ + 0.71f * __temp_52__);
        float __temp_57__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_58__ = (__temp_53__ + 0.91f * __temp_57__);
        float __temp_62__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_63__ = (__temp_58__ + 1.21f * __temp_62__);
        float __temp_67__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_68__ = (__temp_63__ + 1.51f * __temp_67__);
        float __temp_72__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_73__ = (__temp_68__ + 1.21f * __temp_72__);
        float __temp_77__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_78__ = (__temp_73__ + 0.91f * __temp_77__);
        float __temp_82__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_83__ = (__temp_78__ + 0.71f * __temp_82__);
        float __temp_87__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_88__ = (__temp_83__ + 0.51f * __temp_87__) / 159;
	b[0] += __temp_88__;	
	// Top
        float __temp_92__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_97__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_98__ = (0.52f * __temp_92__ + 0.72f * __temp_97__);
        float __temp_102__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_103__ = (__temp_98__ + 0.92f * __temp_102__);
        float __temp_107__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_108__ = (__temp_103__ + 1.22f * __temp_107__);
        float __temp_112__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_113__ = (__temp_108__ + 1.52f * __temp_112__);
        float __temp_117__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_118__ = (__temp_113__ + 1.22f * __temp_117__);
        float __temp_122__ = (tilevar[0][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_123__ = (__temp_118__ + 0.92f * __temp_122__);
        float __temp_127__ = (tilevar[0][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_128__ = (__temp_123__ + 0.72f * __temp_127__);
        float __temp_132__ = (tilevar[0][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_133__ = (__temp_128__ + 0.52f * __temp_132__) / 159;
        tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] += __temp_133__;
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+2),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-3),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+2),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-3),(N-2))){
	float __temp_3__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_7__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_8__ = (0.5f * __temp_3__ + 0.7f *__temp_7__);
        float __temp_12__ = (tilevar[1][ __iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_13__ = (__temp_8__ + 0.9f * __temp_12__);
        float __temp_17__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_18__ = (__temp_13__ + 1.2f * __temp_17__);
        float __temp_22__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_23__ = (__temp_18__ + 1.5f * __temp_22__);
        float __temp_27__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_28__ = (__temp_23__ + 1.2f * __temp_27__);
        float __temp_32__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_33__ = (__temp_28__ + 0.9f * __temp_32__);
        float __temp_37__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_38__ = (__temp_33__ + 0.7f * __temp_37__);
        float __temp_42__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_43__ = (__temp_38__ + 0.5f * __temp_42__) / 159;
	t[1] += __temp_43__;
	//Mid 
        float __temp_47__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_52__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_53__ = (0.51f * __temp_47__ + 0.71f * __temp_52__);
        float __temp_57__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_58__ = (__temp_53__ + 0.91f * __temp_57__);
        float __temp_62__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_63__ = (__temp_58__ + 1.21f * __temp_62__);
        float __temp_67__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_68__ = (__temp_63__ + 1.51f * __temp_67__);
        float __temp_72__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_73__ = (__temp_68__ + 1.21f * __temp_72__);
        float __temp_77__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_78__ = (__temp_73__ + 0.91f * __temp_77__);
        float __temp_82__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_83__ = (__temp_78__ + 0.71f * __temp_82__);
        float __temp_87__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_88__ = (__temp_83__ + 0.51f * __temp_87__) / 159;
	b[1] += __temp_88__;	
	// Top
        float __temp_92__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_97__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_98__ = (0.52f * __temp_92__ + 0.72f * __temp_97__);
        float __temp_102__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_103__ = (__temp_98__ + 0.92f * __temp_102__);
        float __temp_107__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_108__ = (__temp_103__ + 1.22f * __temp_107__);
        float __temp_112__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_113__ = (__temp_108__ + 1.52f * __temp_112__);
        float __temp_117__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_118__ = (__temp_113__ + 1.22f * __temp_117__);
        float __temp_122__ = (tilevar[1][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_123__ = (__temp_118__ + 0.92f * __temp_122__);
        float __temp_127__ = (tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_128__ = (__temp_123__ + 0.72f * __temp_127__);
        float __temp_132__ = (tilevar[1][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_133__ = (__temp_128__ + 0.52f * __temp_132__) / 159;
        tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] += __temp_133__;
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+3),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-4),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+3),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-4),(N-2))){
	float __temp_3__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_7__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_8__ = (0.5f * __temp_3__ + 0.7f *__temp_7__);
        float __temp_12__ = (tilevar[2][ __iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_13__ = (__temp_8__ + 0.9f * __temp_12__);
        float __temp_17__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_18__ = (__temp_13__ + 1.2f * __temp_17__);
        float __temp_22__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_23__ = (__temp_18__ + 1.5f * __temp_22__);
        float __temp_27__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_28__ = (__temp_23__ + 1.2f * __temp_27__);
        float __temp_32__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_33__ = (__temp_28__ + 0.9f * __temp_32__);
        float __temp_37__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_38__ = (__temp_33__ + 0.7f * __temp_37__);
        float __temp_42__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_43__ = (__temp_38__ + 0.5f * __temp_42__) / 159;
	t[2] += __temp_43__;
	//Mid 
        float __temp_47__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_52__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_53__ = (0.51f * __temp_47__ + 0.71f * __temp_52__);
        float __temp_57__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_58__ = (__temp_53__ + 0.91f * __temp_57__);
        float __temp_62__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_63__ = (__temp_58__ + 1.21f * __temp_62__);
        float __temp_67__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_68__ = (__temp_63__ + 1.51f * __temp_67__);
        float __temp_72__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_73__ = (__temp_68__ + 1.21f * __temp_72__);
        float __temp_77__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_78__ = (__temp_73__ + 0.91f * __temp_77__);
        float __temp_82__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_83__ = (__temp_78__ + 0.71f * __temp_82__);
        float __temp_87__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_88__ = (__temp_83__ + 0.51f * __temp_87__) / 159;
	b[2] += __temp_88__;	
	// Top
        float __temp_92__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_97__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_98__ = (0.52f * __temp_92__ + 0.72f * __temp_97__);
        float __temp_102__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_103__ = (__temp_98__ + 0.92f * __temp_102__);
        float __temp_107__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_108__ = (__temp_103__ + 1.22f * __temp_107__);
        float __temp_112__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_113__ = (__temp_108__ + 1.52f * __temp_112__);
        float __temp_117__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_118__ = (__temp_113__ + 1.22f * __temp_117__);
        float __temp_122__ = (tilevar[2][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_123__ = (__temp_118__ + 0.92f * __temp_122__);
        float __temp_127__ = (tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_128__ = (__temp_123__ + 0.72f * __temp_127__);
        float __temp_132__ = (tilevar[2][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_133__ = (__temp_128__ + 0.52f * __temp_132__) / 159;
        tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] += __temp_133__;
    }
    __syncthreads ();
    if(__iter_4__ >= FORMA_MAX((__iter_1__+4),1) & __iter_4__ <= FORMA_MIN(((__iter_1__+FORMA_BLOCKDIM_Y)-5),(M-2)) & __iter_5__ >= FORMA_MAX((__iter_0__+4),1) &  __iter_5__ <= FORMA_MIN(((__iter_0__+FORMA_BLOCKDIM_X)-5),(N-2))){
	float __temp_3__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_7__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_8__ = (0.5f * __temp_3__ + 0.7f *__temp_7__);
        float __temp_12__ = (tilevar[3][ __iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_13__ = (__temp_8__ + 0.9f * __temp_12__);
        float __temp_17__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_18__ = (__temp_13__ + 1.2f * __temp_17__);
        float __temp_22__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_23__ = (__temp_18__ + 1.5f * __temp_22__);
        float __temp_27__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_28__ = (__temp_23__ + 1.2f * __temp_27__);
        float __temp_32__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_33__ = (__temp_28__ + 0.9f * __temp_32__);
        float __temp_37__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_38__ = (__temp_33__ + 0.7f * __temp_37__);
        float __temp_42__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_43__ = (__temp_38__ + 0.5f * __temp_42__) / 159;
	t[3] += __temp_43__;
	//Mid 
        float __temp_47__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_52__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_53__ = (0.51f * __temp_47__ + 0.71f * __temp_52__);
        float __temp_57__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_58__ = (__temp_53__ + 0.91f * __temp_57__);
        float __temp_62__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_63__ = (__temp_58__ + 1.21f * __temp_62__);
        float __temp_67__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_68__ = (__temp_63__ + 1.51f * __temp_67__);
        float __temp_72__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_73__ = (__temp_68__ + 1.21f * __temp_72__);
        float __temp_77__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_78__ = (__temp_73__ + 0.91f * __temp_77__);
        float __temp_82__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_83__ = (__temp_78__ + 0.71f * __temp_82__);
        float __temp_87__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_88__ = (__temp_83__ + 0.51f * __temp_87__) / 159;
	b[3] += __temp_88__;	
	// Top
        float __temp_92__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_97__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_98__ = (0.52f * __temp_92__ + 0.72f * __temp_97__);
        float __temp_102__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-1-__iter_1__)]);
        float __temp_103__ = (__temp_98__ + 0.92f * __temp_102__);
        float __temp_107__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_108__ = (__temp_103__ + 1.22f * __temp_107__);
        float __temp_112__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_113__ = (__temp_108__ + 1.52f * __temp_112__);
        float __temp_117__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)]);
        float __temp_118__ = (__temp_113__ + 1.22f * __temp_117__);
        float __temp_122__ = (tilevar[3][__iter_5__-1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_123__ = (__temp_118__ + 0.92f * __temp_122__);
        float __temp_127__ = (tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_128__ = (__temp_123__ + 0.72f * __temp_127__);
        float __temp_132__ = (tilevar[3][__iter_5__+1-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__+1-__iter_1__)]);
        float __temp_133__ = (__temp_128__ + 0.52f * __temp_132__) / 159;
	out += __temp_133__;
	__var_1__[__iter_5__+N*(__iter_4__+M*FORMA_MAX(__iter_2__-4,0))] = out;
    }
    __syncthreads ();
    // Now rotate 
    tilevar[1][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = b[0];
    b[0] = t[0];
    t[0] = 0.0f;
    tilevar[2][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = b[1];
    b[1] = t[1];
    t[1] = 0.0f;
    tilevar[3][__iter_5__-__iter_0__+FORMA_BLOCKDIM_X*(__iter_4__-__iter_1__)] = b[2];
    b[2] = t[2];
    t[2] = 0.0f;
    out= b[3]; 
    b[3] = t[3];
    t[3] = 0.0f;
  }
}

/*Device code End */
/* Host Code Begin */
extern "C" void j3d27pt(float * h_input, int L, int M, int N, float * __var_0__){

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
  int __grid_0___kernel___forma_kernel__0__ = FORMA_CEIL(__size_0___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.x-8);
  int __grid_1___kernel___forma_kernel__0__ = FORMA_CEIL(__size_1___kernel___forma_kernel__0__,__blockConfig___kernel___forma_kernel__0__.y-8);
  int __grid_2___kernel___forma_kernel__0__ = 1;
  dim3 __gridConfig___kernel___forma_kernel__0__(__grid_0___kernel___forma_kernel__0__,__grid_1___kernel___forma_kernel__0__,__grid_2___kernel___forma_kernel__0__);
  dim3 unrollConfig (__blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z);

  __kernel___forma_kernel__0__<<<__gridConfig___kernel___forma_kernel__0__, unrollConfig>>> (input, L, M, N, __blockConfig___kernel___forma_kernel__0__.x, __blockConfig___kernel___forma_kernel__0__.y, __blockConfig___kernel___forma_kernel__0__.z, __var_1__);
  Check_CUDA_Error("Kernel Launch Error!! : __kernel___forma_kernel__0__\n");

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
}
/*Host Free End*/
