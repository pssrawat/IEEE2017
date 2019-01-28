#!/bin/bash
set -e

echo
echo "-------------------- Untiled Run ----------------------"
echo
time=`grep -E 'float|double' untiled-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
echo "Untiled Run Time (ms) : " ${time}

echo
echo "-------------------- Opt Run ----------------------"
echo
time=`grep -E 'float|double' opt-results | awk 'BEGIN {time = 0.0} {time += $2} END {print time}'`
echo "Opt Run Time (ms) : " ${time}
