vlog tb_top.sv

transcript file test.txt

vsim tb_top -c -coverage -assertdebug -voptargs=+cover
set NoQuitOnFinish 1
onbreak {resume}
run -all

transcript file {}

coverage save memory.ucdb


vcover report memory.ucdb  -cvg  -details         -output fun_coverage.txt
vcover report memory.ucdb  -details -instance=/tb_top/dut  -output code_coverage.txt