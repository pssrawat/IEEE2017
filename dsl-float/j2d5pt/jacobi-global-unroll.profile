==1715== NVPROF is profiling process 1715, command: ./jacobi-global-unroll
==1715== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==1715== Profiling application: ./jacobi-global-unroll
==1715== Profiling result:
==1715== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",92733480,92733480,92733480
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1167866,1167866,1167866
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",13307904,13307904,13307904
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",67668936,67669007,67668963
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.667694,0.667837,0.667779
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",44.953117%,44.979984%,44.964555%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",34.177935%,34.204533%,34.193097%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.616504,2.618375,2.617147
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.002024,0.002025,0.002024
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000045,0.000045,0.000045
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",59.360460%,59.360460%,59.360460%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.957461%,99.957462%,99.957462%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",183173160,183173160,183173160
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1316346,1316346,1316346
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",13889536,13889536,13889536
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",74843705,74843784,74843753
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.711780,0.711829,0.711804
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",39.983851%,39.993177%,39.988480%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",36.880292%,36.886430%,36.882976%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.785822,2.789563,2.788071
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001872,0.001873,0.001873
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000082,0.000082,0.000082
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",79.290962%,79.290962%,79.290962%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.950665%,99.950665%,99.950665%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",270991400,270991400,270991400
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1450490,1450490,1450490
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",14413824,14413824,14413824
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",79565375,79565554,79565494
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.761776,0.761854,0.761824
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",38.650663%,38.713012%,38.685480%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",38.989140%,39.071921%,39.024602%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.863945,2.864657,2.864403
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001799,0.001802,0.001801
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000116,0.000116,0.000116
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",88.948795%,88.948795%,88.948795%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.953596%,99.953596%,99.953596%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",356188200,356188200,356188200
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1584634,1584634,1584634
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",14938112,14938112,14938112
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",84024936,84024973,84024959
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.804973,0.805195,0.805073
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",36.260099%,36.314196%,36.278400%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",41.762306%,41.853543%,41.817531%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.882482,2.888542,2.886437
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001741,0.001741,0.001741
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000146,0.000146,0.000146
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",94.153443%,94.153443%,94.153443%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.956062%,99.956062%,99.956062%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1779957760,1779957760,1779957760
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",6160384,6160384,6160384
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",51118080,51118080,51118080
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_issued","Instructions Issued",345835530,345835552,345835538
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",31981568,31981568,31981568
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",6815744,6815744,6815744
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.704345,0.704424,0.704378
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",21.186189%,21.239136%,21.219613%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",37.848789%,37.874008%,37.858383%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",12.359288%,12.373902%,12.366357%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"issued_ipc","Issued IPC",2.858605,2.859775,2.859113
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.007259,0.007259,0.007259
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.005726,0.005726,0.005726
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",74.299065%,74.299065%,74.299065%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",46.537162%,46.537162%,46.537162%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",93.297862%,93.297862%,93.297862%
