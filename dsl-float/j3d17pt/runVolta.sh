for regCnt in 32 64; do
    for f in test-stream-z-overlap-2.cu test-stream-z-overlap-2-32x32.cu; do
	echo Running $f for regCnt $regCnt
	nvcc -O3 -maxrregcount=$regCnt -ccbin=g++ -std=c++11 -Xcompiler "-fPIC -fopenmp -O3 -fno-strict-aliasing" --use_fast_math -Xptxas "-v -dlcm=cg" -gencode arch=compute_60,code=sm_60 ../../cuda_header.cu ../j3d17pt_gold.cpp j3d17pt.driver.cpp $f -o test
	nvprof --print-gpu-trace ./test 2> forma-ot-results
	./time.awk
    done
done
