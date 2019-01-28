==18422== NVPROF is profiling process 18422, command: ./test
==18422== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==18422== Profiling application: ./test
==18422== Profiling result:
==18422== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",5295551832,5295551832,5295551832
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",3905676,3905676,3905676
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",25266144,25266144,25266144
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",246864034,246865321,246864733
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",34037640,34037640,34037640
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",15997080,15997080,15997080
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.920392,0.923268,0.922286
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",13.835381%,13.981768%,13.922306%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",22.923903%,22.949105%,22.934825%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",19.261186%,19.340539%,19.308562%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",3.449025,3.461720,3.454006
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.012545,0.012550,0.012547
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.006851,0.006851,0.006851
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",93.715659%,93.715659%,93.715659%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",48.476845%,48.476845%,48.476845%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",100.000000%,100.000000%,100.000000%
