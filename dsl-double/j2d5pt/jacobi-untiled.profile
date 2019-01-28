==14587== NVPROF is profiling process 14587, command: ./jacobi-untiled
==14587== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==14587== Profiling application: ./jacobi-untiled
==14587== Profiling result:
==14587== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",14776472,14776472,14776472
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",126615605,126618910,126616738
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.874750,0.875061,0.874857
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",23.033782%,23.066001%,23.045307%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",33.583328%,33.673174%,33.642597%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.308122,2.309393,2.308713
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.034464,0.034491,0.034473
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.017163,0.017163,0.017163
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.811364%,99.811364%,99.811364%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",14776472,14776472,14776472
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",126618565,126619350,126619033
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.874865,0.875136,0.875006
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",22.910879%,22.968790%,22.946801%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",33.769867%,33.960418%,33.840543%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.302681,2.307393,2.304287
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.034488,0.034495,0.034492
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.017163,0.017163,0.017163
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.811364%,99.811364%,99.811364%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",14776472,14776472,14776472
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",126615206,126615555,126615427
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.874507,0.875028,0.874763
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",23.045103%,23.052607%,23.048788%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",33.583411%,33.642926%,33.611490%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.309003,2.314894,2.311176
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.034461,0.034464,0.034463
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.017163,0.017163,0.017163
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.811364%,99.811364%,99.811364%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",14776472,14776472,14776472
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",126615325,126615532,126615462
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.874634,0.875045,0.874813
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",23.005648%,23.019794%,23.014111%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",33.695508%,33.720747%,33.709391%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.307427,2.313271,2.310722
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.034462,0.034464,0.034463
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.017163,0.017163,0.017163
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.811364%,99.811364%,99.811364%
