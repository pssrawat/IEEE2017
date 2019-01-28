source ../setup.sh 

${NVCC} -O3 -maxrregcount=32 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu jacobi_gold.cpp jacobi.driver.cpp jacobi-untiled.cu -o test
${NVPROF} --print-gpu-trace ./test 2>untiled-results

${NVCC} -O3 -maxrregcount=64 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu jacobi_gold.cpp jacobi.driver.cpp test-stream-y-overlap-4-reg-divide.cu -o test
${NVPROF} --print-gpu-trace ./test 2>opt-results

../common/time.awk > time-results

${NVCC} -O3 -maxrregcount=32 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -lnvidia-ml -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu jacobi_gold.cpp jacobi.driver.cpp nvml-untiled.cu -o test
./test > out-nvml-untiled 2>log-nvml-untiled
 

${NVCC} -O3 -maxrregcount=64 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -lnvidia-ml -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu jacobi_gold.cpp jacobi.driver.cpp nvml-opt.cu -o test
./test > out-nvml-opt 2>log-nvml-opt

