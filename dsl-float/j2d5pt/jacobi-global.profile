==30874== NVPROF is profiling process 30874, command: ./jacobi-global
==30874== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==30874== Profiling application: ./jacobi-global
==30874== Profiling result:
==30874== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",80937000,80937000,80937000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",2096640,2096640,2096640
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",18870272,18870272,18870272
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",134213862,134213874,134213869
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.914103,0.914370,0.914255
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",34.612485%,34.649579%,34.636350%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",36.948664%,37.045092%,36.980957%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",3.459397,3.465102,3.463019
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.007895,0.007895,0.007895
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",22.791245%,22.791245%,22.791245%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.972708%,99.972708%,99.972708%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",156958760,156958760,156958760
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",2096640,2096640,2096640
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",18870272,18870272,18870272
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",137359190,137359208,137359201
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.915062,0.915185,0.915140
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",32.934723%,33.003075%,32.959972%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",37.163974%,37.245958%,37.210554%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",3.491741,3.500541,3.495145
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.007714,0.007714,0.007714
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",41.597926%,41.597926%,41.597926%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.972962%,99.972962%,99.972962%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",227737640,227737640,227737640
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",2096640,2096640,2096640
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",18870272,18870272,18870272
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",139456330,139456426,139456392
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.914952,0.915216,0.915083
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",33.889586%,33.946281%,33.927192%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",36.863466%,36.947672%,36.895428%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",3.525952,3.533086,3.528438
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.007597,0.007598,0.007598
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",57.178126%,57.178126%,57.178126%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.973372%,99.973372%,99.973372%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1924136960,1924136960,1924136960
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",7077888,7077888,7077888
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",66846720,66846720,66846720
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_issued","Instructions Issued",673188354,673188357,673188355
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",40894464,40894464,40894464
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",7602176,7602176,7602176
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.949639,0.949919,0.949759
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",16.338469%,16.396240%,16.375299%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",31.984248%,31.992339%,31.989528%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",5.524723%,5.537079%,5.530789%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"issued_ipc","Issued IPC",3.448666,3.449909,3.449356
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.003129,0.003129,0.003129
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",52.083333%,52.083333%,52.083333%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",39.459459%,39.459459%,39.459459%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",90.173340%,90.173340%,90.173340%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",293273640,293273640,293273640
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",2096640,2096640,2096640
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",18870272,18870272,18870272
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",139456336,139456402,139456359
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.915173,0.915315,0.915241
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",33.720260%,33.755681%,33.735780%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",37.346469%,37.419873%,37.394626%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",3.513752,3.514731,3.514207
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.007597,0.007598,0.007597
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",69.949208%,69.949208%,69.949208%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.973372%,99.973372%,99.973372%
