@REM cd ../sim_data/
@REM cls
@REM vsim -c -do "../scripts/run.do"
@REM @echo off
@REM start covhtmlreport/index.html
@REM start notepads log_file.txt
@REM cd ../scripts/


cd ../sim_data/
cls
vlog -f "../components/top/xyz.f" +VERBOSITY_LOW -R -sv_seed random -c -do "../scripts/run.do"
@echo off
cd ../scripts/