@echo off
cls
python3 credits.py
cd ../sim_data/
vlog -f "../components/top/verification_components_filelist.f" +VERBOSITY_LOW -coveropt 3 +cover +acc
vsim top -sv_seed random -logfile log_file.txt -voptargs=+acc=npr -coverage -vopt -c -do "../scripts/run.do" +UVM_NO_RELNOTES
vcover report -details -html code_coverage.ucdb
start covhtmlreport/index.html
start log_file.txt
cd ../scripts/


@REM cd ../sim_data/
@REM cls
@REM vlog -f "../components/top/verification_components_filelist.f" +VERBOSITY_LOW -R -sv_seed random -c -do "../scripts/run.do" -solvefaildebug=2
@REM @echo off
@REM cd ../scripts/

@REM -sv_seed 3051038994
