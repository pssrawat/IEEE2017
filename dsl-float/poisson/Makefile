NVCC=nvcc
NVPROF=nvprof
OPTFLAGS=-O3 -maxrregcount=32 -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-dlcm=cg"
COMPUTEFLAGS=-gencode arch=compute_50,code=sm_50 

all:
	$(NVCC) $(OPTFLAGS) $(COMPUTEFLAGS) ../common/cuda_header.cu poisson.driver.cpp poisson_gold.cpp poisson-untiled.cu -o untiled
	$(NVCC) $(OPTFLAGS) $(COMPUTEFLAGS) poisson3d-sp.overtile.cu -o overtile
	$(NVCC) $(OPTFLAGS) $(COMPUTEFLAGS) poisson3d_host.cu poisson3d_kernel.cu -o ppcg 
	$(NVCC) $(OPTFLAGS) $(COMPUTEFLAGS) ../common/cuda_header.cu poisson.driver.cpp poisson_gold.cpp poisson3d-overtile-1.cu -o forma-ot 
	$(NVCC) $(OPTFLAGS) $(COMPUTEFLAGS) ../common/cuda_header.cu poisson.driver.cpp poisson_gold.cpp poisson-gen-2.cu -o opt
	$(NVPROF) --print-gpu-trace ./ppcg > /dev/null 2>ppcg-results
	$(NVPROF) --print-gpu-trace ./untiled > /dev/null 2>untiled-results
	$(NVPROF) --print-gpu-trace ./overtile > /dev/null 2>overtile-results
	$(NVPROF) --print-gpu-trace ./forma-ot > /dev/null 2>forma-ot-results
	$(NVPROF) --print-gpu-trace ./opt > /dev/null 2>opt-results
	../common/time.awk
