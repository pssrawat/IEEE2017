==2651== NVPROF is profiling process 2651, command: ./jacobi-unroll
==2651== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==2651== Profiling application: ./jacobi-unroll
==2651== Profiling result:
==2651== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",81254400,81254400,81254400
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",4063232,4063232,4063232
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",3342336,3342336,3342336
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",21962567,21971594,21966636
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.568210,0.570959,0.569707
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",14.156607%,14.302041%,14.245467%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",50.041018%,50.379320%,50.182568%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",1.038684,1.042202,1.040189
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.269402,0.269924,0.269637
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.219697,0.219697,0.219697
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",22.791245%,22.791245%,22.791245%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",97.700084%,97.700084%,97.700084%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",162191400,162191400,162191400
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",8110592,8110592,8110592
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",3863296,3863296,3863296
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",37976898,38048164,38023780
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.566823,0.567602,0.567238
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",16.467842%,16.508132%,16.483054%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",37.912338%,38.019074%,37.961798%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",1.415274,1.419865,1.417000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.315310,0.317778,0.316934
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.262783,0.262783,0.262783
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",22.791245%,22.791245%,22.791245%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",97.635601%,97.635601%,97.635601%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",231664680,231664680,231664680
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",10995712,10995712,10995712
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",5629696,5629696,5629696
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",52451062,52570763,52502086
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.697344,0.698187,0.697830
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",13.204015%,13.268217%,13.246481%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",45.222805%,45.384732%,45.307412%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",1.502020,1.504900,1.503684
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.351007,0.354090,0.352321
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.262992,0.262992,0.262992
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",23.787172%,23.787172%,23.787172%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",93.706088%,93.706089%,93.706089%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",298511400,298511400,298511400
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",13618176,13618176,13618176
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",6550016,6550016,6550016
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",63522299,63567752,63540526
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.772068,0.774524,0.773383
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",13.223264%,13.282414%,13.248126%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",41.307687%,41.478507%,41.400601%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",1.737261,1.746458,1.741928
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.352656,0.353624,0.353044
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.267681,0.267681,0.267681
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",24.565598%,24.565598%,24.565598%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",91.366278%,91.366302%,91.366294%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1997537280,1997537280,1997537280
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",7077888,7077888,7077888
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",41549824,41549824,41549824
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_issued","Instructions Issued",353830884,353830898,353830891
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",31195136,31195136,31195136
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",7864320,7864320,7864320
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.727290,0.727358,0.727314
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",13.965186%,13.983092%,13.976425%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",51.357585%,51.370093%,51.364033%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",2.752674%,2.766987%,2.758926%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"issued_ipc","Issued IPC",3.658386,3.659504,3.658866
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001490,0.001490,0.001490
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",52.083333%,52.083333%,52.083333%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",38.768876%,38.768876%,38.768876%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, float*, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",95.780004%,95.780004%,95.780004%
