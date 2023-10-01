Use these commands to run:
vlog -coveropt 1 +cover +acc +VERBOSITY_LOW -sv -f xyz.f
vsim top -sv_seed random -coverage -vopt  -c -do "coverage save -onexit -directive -codeAll ../../logs/code_coverage.ucdb;run -all;exit”
vcover report -details -html ../../logs/code_coverage.ucdb
