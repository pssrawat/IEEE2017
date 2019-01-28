==15718== NVPROF is profiling process 15718, command: ./test
==15718== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==15718== Profiling application: ./test
==15718== Profiling result:
==15718== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"flop_count_sp","Floating Point Operations(Single Precision)",8723051220,8723051220,8723051220
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"gld_transactions","Global Load Transactions",12881920,12881920,12881920
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"gst_transactions","Global Store Transactions",9567090,9567090,9567090
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"cf_executed","Executed Control-Flow Instructions",71136384,71136384,71136384
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"inst_issued","Instructions Issued",623908947,623908947,623908947
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"shared_load_transactions","Shared Load Transactions",156103860,156103860,156103860
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"shared_store_transactions","Shared Store Transactions",27874345,27874345,27874345
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"achieved_occupancy","Achieved Occupancy",0.995165,0.995165,0.995165
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"stall_sync","Issue Stall Reasons (Synchronization)",33.165547%,33.165547%,33.165547%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",19.980126%,19.980126%,19.980126%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"stall_memory_dependency","Issue Stall Reasons (Data Request)",0.238357%,0.238357%,0.238357%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"issued_ipc","Issued IPC",2.003697,2.003697,2.003697
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"inst_replay_overhead","Instruction Replay Overhead",0.029328,0.029328,0.029328
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"global_replay_overhead","Global Memory Replay Overhead",0.015015,0.015015,0.015015
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"gld_efficiency","Global Memory Load Efficiency",100.000000%,100.000000%,100.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"gst_efficiency","Global Memory Store Efficiency",74.558824%,74.558824%,74.558824%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"shared_efficiency","Shared Memory Efficiency",41.673992%,41.673992%,41.673992%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",1,"warp_execution_efficiency","Warp Execution Efficiency",100.000000%,100.000000%,100.000000%
