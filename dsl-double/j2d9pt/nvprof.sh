#!/bin/bash
set -e
METRICS="flop_count_sp,gld_transactions,gst_transactions,cf_executed,inst_issued,shared_load_transactions,shared_store_transactions,achieved_occupancy,stall_sync,stall_exec_dependency,stall_memory_dependency,issued_ipc,inst_replay_overhead,shared_replay_overhead,global_replay_overhead,gld_efficiency,gst_efficiency,shared_efficiency,warp_execution_efficiency"
METRICS_ADD="flop_count_sp,gld_transactions,gst_transactions,cf_executed,inst_issued,shared_load_transactions,shared_store_transactions"
METRICS_AVERAGE="achieved_occupancy,global_replay_overhead,stall_sync,stall_exec_dependency,stall_memory_dependency,issued_ipc,inst_replay_overhead,shared_replay_overhead,global_replay_overhead,gld_efficiency,gst_efficiency,shared_efficiency,warp_execution_efficiency"

nvprof --normalized-time-unit ms --csv ./$1  2> $1.time >/dev/null
nvprof --print-gpu-trace --csv ./$1 2> $1.trace >/dev/null
nvprof --csv --metrics ${METRICS} ./$1  2> $1.profile >/dev/null

IFS=","
kernel=`grep "__kernel_" $1.time | awk -F, 'BEGIN {time = 0.0} {time += $4} END {print time}'`
echo "Time(ms)" ${kernel}
kernel=`grep "__kernel_" $1.trace | awk -F, 'BEGIN {nregs = 0; count = 0;} {nregs += $9; count+=1; } END {print nregs/count}'`
echo "NRegs " ${kernel}
kernel=`grep "__kernel_" $1.trace | awk -F, 'BEGIN {SHMem = 0.0; count = 0;} {SHMem += $11; count+=1;} END {print SHMem/count}'`
echo "Shared Mem " ${kernel}
for metric in ${METRICS_ADD}
do
    kernel=`grep "__kernel_" $1.profile | grep "${metric}" | awk -F, 'BEGIN {metric = 0;} {metric += $NF} END {print metric}'`
    echo ${metric},${kernel}
done
for metric in ${METRICS_AVERAGE}
do
    kernel=`grep "__kernel_" $1.profile | grep "${metric}" | awk -F, 'BEGIN {metric = 0.0; count = 0;} {metric += $NF; count+=1;} END {print metric/count}'`
    echo ${metric},${kernel}
done
unset NVJIT_TARGET NVJIT_TILED_LOAD
