==29682== NVPROF is profiling process 29682, command: ./test
==29682== Warning: Some kernel(s) will be replayed on device 0 in order to collect all events/metrics.
==29682== Profiling application: ./test
==29682== Profiling result:
==29682== Metric result:
"Device","Kernel","Invocations","Metric Name","Metric Description","Min","Max","Avg"
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"flop_count_sp","Floating Point Operations(Single Precision)",7956773160,7956773160,7956773160
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"gld_transactions","Global Load Transactions",0,0,0
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"gst_transactions","Global Store Transactions",8826060,8826060,8826060
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"cf_executed","Executed Control-Flow Instructions",41064928,41064928,41064928
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"inst_issued","Instructions Issued",549713591,549713817,549713704
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"shared_load_transactions","Shared Load Transactions",195689550,195689550,195689550
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"shared_store_transactions","Shared Store Transactions",32871292,32871292,32871292
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"achieved_occupancy","Achieved Occupancy",0.994005,0.994895,0.994450
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"stall_sync","Issue Stall Reasons (Synchronization)",25.121768%,25.152320%,25.137044%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"stall_exec_dependency","Issue Stall Reasons (Execution Dependency)",16.125685%,16.129597%,16.127641%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"stall_memory_dependency","Issue Stall Reasons (Data Request)",9.991244%,10.006861%,9.999052%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"issued_ipc","Issued IPC",1.669000,1.669591,1.669295
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"inst_replay_overhead","Instruction Replay Overhead",0.007162,0.007162,0.007162
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"shared_replay_overhead","Shared Memory Replay Overhead",0.000000,0.000000,0.000000
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"global_replay_overhead","Global Memory Replay Overhead",0.007134,0.007134,0.007134
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"gld_efficiency","Global Memory Load Efficiency",0.000000%,0.000000%,0.000000%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"gst_efficiency","Global Memory Store Efficiency",77.591463%,77.591463%,77.591463%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"shared_efficiency","Shared Memory Efficiency",44.172242%,44.172242%,44.172242%
"Tesla K20c (0)","__kernel___forma_kernel__0__(float*, int, int, int, int, int, int, float*)",2,"warp_execution_efficiency","Warp Execution Efficiency",100.000000%,100.000000%,100.000000%
