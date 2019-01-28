==20858== NVPROF is profiling process 20858, command: ./test
==20858== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==20858== Profiling application: ./test
==20858== Profiling result:
==20858== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",3611549214,3611549214,3611549214
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",3912831,3912831,3912831
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",25153155,25153155,25153155
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",201533647,201534900,201534111
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",36196305,36196305,36196305
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",9091773,9091773,9091773
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.917697,0.918391,0.918100
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",15.541355%,15.596998%,15.575569%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",34.555199%,34.601778%,34.571244%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",15.267000%,15.306864%,15.290774%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",3.134806,3.153212,3.141176
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.008415,0.008422,0.008418
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.008373,0.008373,0.008373
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",93.715659%,93.715659%,93.715659%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",48.297802%,48.297802%,48.297802%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",100.000000%,100.000000%,100.000000%
