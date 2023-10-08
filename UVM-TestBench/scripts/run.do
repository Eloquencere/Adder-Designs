# vlog -f "../components/top/xyz.f" +VERBOSITY_LOW -timescale 1ns/1ps -coveropt 1 +cover +acc
# vsim top -sv_seed random -voptargs=+acc=npr -logfile log_file.txt -coverage -vopt ++UVM_NO_RELNOTES
# coverage save -onexit -directive -codeAll code_coverage.ucdb
# vcover report -details -html code_coverage.ucdb
# vcd file vcd_file.vcd
# vcd add -r /top/*
run -all
exit