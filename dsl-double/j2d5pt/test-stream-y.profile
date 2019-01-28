==21602== NVPROF is profiling process 21602, command: ./test-stream-y
==21602== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==21602== Profiling application: ./test-stream-y
==21602== Profiling result:
==21602== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1346634880,1346634880,1346634880
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",9039820,9039820,9039820
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",27508352,27508352,27508352
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_issued","Instructions Issued",624878311,624880699,624879115
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",28678144,28678144,28678144
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",4988640,4988640,4988640
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.499885,0.499886,0.499885
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",9.419071%,9.436712%,9.425606%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",34.744014%,34.755793%,34.750268%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",1.260307%,1.267928%,1.264028%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.284941,2.286377,2.285733
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.019759,0.019763,0.019761
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.006613,0.006613,0.006613
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",41.853977%,41.853977%,41.853977%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",38.658055%,38.658055%,38.658055%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",75.378623%,75.378623%,75.378623%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1345647450,1345647450,1345647450
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",2333753,2333753,2333753
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",31249832,31249832,31249832
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_issued","Instructions Issued",629834256,629834341,629834299
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",24940920,24940920,24940920
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",8730424,8730424,8730424
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.499884,0.499884,0.499884
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",8.757479%,8.769768%,8.764707%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",34.501606%,34.526483%,34.512422%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",4.898731%,4.953101%,4.934163%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.104952,2.107840,2.106306
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.005208,0.005208,0.005208
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.001735,0.001735,0.001735
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",83.363836%,83.363836%,83.363836%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",37.929234%,37.929234%,37.929234%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*, float*, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",74.404969%,74.404969%,74.404969%
