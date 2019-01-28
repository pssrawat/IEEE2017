==15227== NVPROF is profiling process 15227, command: ./jacobi-orig
==15227== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==15227== Profiling application: ./jacobi-orig
==15227== Profiling result:
==15227== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",19998022,19998022,19998022
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",6340704,6340704,6340704
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",134322816,134328343,134326434
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.850509,0.850901,0.850643
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",17.926628%,17.936764%,17.931227%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",23.176465%,23.220974%,23.197216%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",1.948476,1.950417,1.949451
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.383488,0.383545,0.383525
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.119004,0.119004,0.119004
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",83.340104%,83.340104%,83.340104%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.819246%,99.819246%,99.819246%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",19998022,19998022,19998022
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",6340704,6340704,6340704
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",134298506,134318227,134306196
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.851270,0.851509,0.851412
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",17.853097%,17.858645%,17.855091%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",23.307344%,23.329333%,23.316966%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",1.943936,1.945307,1.944396
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.383238,0.383441,0.383317
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.119004,0.119004,0.119004
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",83.340104%,83.340104%,83.340104%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.819246%,99.819246%,99.819246%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",19998022,19998022,19998022
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",6340704,6340704,6340704
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",134219940,134231332,134227145
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.851037,0.851132,0.851092
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",17.857484%,17.872497%,17.864405%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",23.400970%,23.414837%,23.406342%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",1.942873,1.943248,1.943054
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.382428,0.382546,0.382503
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.119004,0.119004,0.119004
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",83.340104%,83.340104%,83.340104%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.819246%,99.819246%,99.819246%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",673384360,673384360,673384360
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",19998022,19998022,19998022
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4209678,4209678,4209678
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",6340704,6340704,6340704
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"inst_issued","Instructions Issued",134247775,134252799,134250253
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.850849,0.851162,0.850990
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",17.869911%,17.872840%,17.871545%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",23.364796%,23.384797%,23.371701%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"issued_ipc","Issued IPC",1.943539,1.944206,1.943843
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.382715,0.382767,0.382741
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.119004,0.119004,0.119004
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",83.340104%,83.340104%,83.340104%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",80.011700%,80.011700%,80.011700%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.819246%,99.819246%,99.819246%
