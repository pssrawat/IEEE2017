#!/bin/bash
set -e

echo
echo "-------------------- Forma Overtile Run ----------------------"
echo
htod=`grep "HtoD" forma-ot-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
echo "Untiled MemCopy Time from Host to Device (ms) : " ${htod}

dtoh=`grep "DtoH" forma-ot-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
echo "Untiled MemCopy Time from Host to Device (ms) : " ${dtoh}

time=`grep -E 'float|double' forma-ot-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
echo "Forma Overtile Run Time (ms) : " ${time}

