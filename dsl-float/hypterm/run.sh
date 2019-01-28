source ../setup.sh 

${NVCC} -O3 -maxrregcount=128 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu hypterm_gold.cpp hypterm.driver.cpp hypterm-untiled.cu -o test
${NVPROF} --print-gpu-trace ./test 2>untiled-results

${NVCC} -O3 -maxrregcount=128 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu hypterm_gold.cpp hypterm.driver.cpp hypterm-maxfuse.cu -o test
${NVPROF} --print-gpu-trace ./test 2>opt-results

${NVCC} -O3 -maxrregcount=128 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu hypterm_gold.cpp hypterm.driver.cpp hypterm-halo.cu -o test
${NVPROF} --print-gpu-trace ./test 2>halo-results

./time.awk > time-results

${NVCC} -O3 -maxrregcount=128 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -lnvidia-ml -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu hypterm_gold.cpp hypterm.driver.cpp nvml-untiled.cu -o test
./test > out-nvml-untiled 2>log-nvml-untiled
 

${NVCC} -O3 -maxrregcount=128 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -lnvidia-ml -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../common/cuda_header.cu hypterm_gold.cpp hypterm.driver.cpp nvml-opt.cu -o test
./test > out-nvml-opt 2>log-nvml-opt

