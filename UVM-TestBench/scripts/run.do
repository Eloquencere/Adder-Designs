coverage save -onexit -directive -codeAll code_coverage.ucdb
vcd file vcd_file.vcd
vcd add -r /top/*
run -all
exit
