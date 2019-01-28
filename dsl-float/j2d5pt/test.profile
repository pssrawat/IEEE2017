==24987== NVPROF is profiling process 24987, command: ./test
==24987== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==24987== Profiling application: ./test
==24987== Profiling result:
==24987== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"flop_count_sp","Floating Point Operations(Single Precision)",2886580620,2886580620,2886580620
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"gst_transactions","Global Store Transactions",4199909,4199909,4199909
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"cf_executed","Executed Control-Flow Instructions",27155099,27155099,27155099
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"inst_issued","Instructions Issued",182027267,182027267,182027267
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"shared_load_transactions","Shared Load Transactions",39270411,39270411,39270411
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"shared_store_transactions","Shared Store Transactions",9875479,9875479,9875479
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"achieved_occupancy","Achieved Occupancy",0.492948,0.492948,0.492948
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"stall_sync","Issue Stall Reasons (Synchronization)",10.663477%,10.663477%,10.663477%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",46.394599%,46.394599%,46.394599%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"stall_memory_dependency","Issue Stall Reasons (Data Request)",20.741128%,20.741128%,20.741128%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"issued_ipc","Issued IPC",2.154847,2.154847,2.154847
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"inst_replay_overhead","Instruction Replay Overhead",0.010004,0.010004,0.010004
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"global_replay_overhead","Global Memory Replay Overhead",0.009942,0.009942,0.009942
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"gst_efficiency","Global Memory Store Efficiency",87.467949%,87.467949%,87.467949%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"shared_efficiency","Shared Memory Efficiency",46.623489%,46.623489%,46.623489%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, float*)",1,"warp_execution_efficiency","Warp Execution Efficiency",100.000000%,100.000000%,100.000000%
