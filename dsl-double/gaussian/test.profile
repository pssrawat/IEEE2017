==20072== NVPROF is profiling process 20072, command: ./test
==20072== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==20072== Profiling application: ./test
==20072== Profiling result:
==20072== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",9889546240,9889546240,9889546240
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",3579904,3579904,3579904
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",26674040,26674040,26674040
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",394790193,394791129,394790609
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",55205888,55205888,55205888
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",16900975,16900975,16900975
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.348148,0.348174,0.348164
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",13.653872%,13.660521%,13.657817%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",33.703582%,33.715157%,33.709727%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",28.773731%,28.790564%,28.781675%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.711656,2.713287,2.712376
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.018693,0.018695,0.018694
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.003044,0.003044,0.003044
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",99.975562%,99.975562%,99.975562%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",46.661310%,46.661310%,46.661310%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",100.000000%,100.000000%,100.000000%
