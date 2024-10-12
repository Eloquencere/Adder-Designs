#!/bin/bash

set +x # Turning off command echo
clear
python3 credits.py
cd ../sim_data/
vlog -f "../components/top/verification_components_filelist.f" +VERBOSITY_LOW -coveropt 3 +cover +acc
vsim top -sv_seed random -logfile log_file.txt -voptargs=+acc=npr -coverage -vopt -c -do "../scripts/run.do" +UVM_NO_RELNOTES
vcover report -details -html code_coverage.ucdb
brave covhtmlreport/index.html
nvim log_file.txt
cd -

# Use the following commands during development

# set +x
# clear
# cd ../sim_data/
# vlog -f "../components/top/verification_components_filelist.f" +VERBOSITY_LOW -R -sv_seed random -c -do "../scripts/run.do" -solvefaildebug=2
# cd -
#
#
# dirs to be included
INC_DIRS=(
    $PROJECT_ROOT_DIR/Testbenches/UVM-Testbench/components/sequences
    $PROJECT_ROOT_DIR/Testbenches/UVM-Testbench/components/agent
    $PROJECT_ROOT_DIR/Testbenches/UVM-Testbench/components/environment
    $PROJECT_ROOT_DIR/Testbenches/UVM-Testbench/components/testbench
    $PROJECT_ROOT_DIR/Testbenches/UVM-Testbench/components/report_server
)
separator="+"
INC_DIRS=$(IFS="$separator"; echo "${INC_DIRS[*]}")
echo "$INC_DIRS"

