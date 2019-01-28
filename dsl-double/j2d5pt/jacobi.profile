==2427== NVPROF is profiling process 2427, command: ./jacobi
==2427== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==2427== Profiling application: ./jacobi
==2427== Profiling result:
==2427== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",51445800,51445800,51445800
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1099770,1099770,1099770
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",12910592,12910592,12910592
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",62914046,62914058,62914053
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.640048,0.640211,0.640151
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",45.827267%,45.838775%,45.832038%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",33.701775%,33.737891%,33.717207%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.480663,2.480816,2.480738
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001108,0.001108,0.001108
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000024,0.000024,0.000024
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",43.117268%,43.117268%,43.117268%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__1__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.955154%,99.955154%,99.955154%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",101908520,101908520,101908520
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1182202,1182202,1182202
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",13234176,13234176,13234176
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",67828262,67828289,67828278
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.663863,0.664225,0.664050
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",41.667356%,41.690590%,41.679129%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",35.626265%,35.661172%,35.642908%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.620682,2.622437,2.621786
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001051,0.001051,0.001051
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000045,0.000045,0.000045
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",64.758162%,64.758162%,64.758162%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__2__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.945607%,99.945607%,99.945607%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",51445800,51445800,51445800
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1099770,1099770,1099770
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",12910592,12910592,12910592
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",62913979,62914004,62913990
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.640163,0.640298,0.640239
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",45.796657%,45.813803%,45.805708%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",33.729723%,33.752090%,33.743212%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.479938,2.482077,2.481222
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001107,0.001107,0.001107
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000024,0.000024,0.000024
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",43.117268%,43.117268%,43.117268%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__4__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.955154%,99.955154%,99.955154%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",101908520,101908520,101908520
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"gst_transactions","Global Store Transactions",1182202,1182202,1182202
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",13234176,13234176,13234176
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"inst_issued","Instructions Issued",67828256,67828486,67828341
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.663830,0.664137,0.663949
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",41.611195%,41.644380%,41.625598%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",35.681990%,35.736585%,35.706799%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"issued_ipc","Issued IPC",2.616872,2.619161,2.618381
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.001051,0.001054,0.001052
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.000045,0.000045,0.000045
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",64.758162%,64.758162%,64.758162%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__5__(float*, int, int, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",99.945607%,99.945607%,99.945607%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1188167680,1188167680,1188167680
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4521984,4521984,4521984
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",27590656,27590656,27590656
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"inst_issued","Instructions Issued",211420544,211420556,211420549
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",20119552,20119552,20119552
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",4063232,4063232,4063232
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.476785,0.476842,0.476816
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",8.747347%,8.790927%,8.764783%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",36.085691%,36.094392%,36.091083%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",22.302303%,22.359073%,22.338040%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"issued_ipc","Issued IPC",1.849703,1.852058,1.850640
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.010026,0.010026,0.010026
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.007514,0.007514,0.007514
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",77.272727%,77.272727%,77.272727%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",47.366192%,47.366192%,47.366192%
"Tesla K20c (0)","__kernel___forma_kernel__3__(float*, int, int, float*, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",94.424116%,94.424116%,94.424116%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"flop_count_sp","Floating Point Operations(Single Precision)",1188167680,1188167680,1188167680
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"gst_transactions","Global Store Transactions",4521984,4521984,4521984
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"cf_executed","Executed Control-Flow Instructions",27590656,27590656,27590656
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"inst_issued","Instructions Issued",211420539,211420561,211420549
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"shared_load_transactions","Shared Load Transactions",20119552,20119552,20119552
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"shared_store_transactions","Shared Store Transactions",4063232,4063232,4063232
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"achieved_occupancy","Achieved Occupancy",0.476780,0.476813,0.476800
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"stall_sync","Issue Stall Reasons (Synchronization)",8.748783%,8.822840%,8.797270%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",36.075592%,36.105734%,36.087770%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"stall_memory_dependency","Issue Stall Reasons (Data Request)",22.305442%,22.327194%,22.312866%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"issued_ipc","Issued IPC",1.849602,1.851670,1.850936
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"inst_replay_overhead","Instruction Replay Overhead",0.010025,0.010026,0.010026
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"global_replay_overhead","Global Memory Replay Overhead",0.007514,0.007514,0.007514
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"gst_efficiency","Global Memory Store Efficiency",77.272727%,77.272727%,77.272727%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"shared_efficiency","Shared Memory Efficiency",47.366192%,47.366192%,47.366192%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, float*, int, int, float*)",3,"warp_execution_efficiency","Warp Execution Efficiency",94.424116%,94.424116%,94.424116%
