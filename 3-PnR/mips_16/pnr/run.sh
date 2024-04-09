# to open saved versions:
# open_mw_lib <lib_name>
# list_mw_cels 
# open_mw_cel <cel_name>

rm -rf log/* output/*

icc_shell -f scripts/1_Design_setup.tcl 

save_mw_cel -as ${design}_1_imported

source ./scripts/2_Floorplanning.tcl > log/floorplanning.rpt

save_mw_cel -as ${design}_2_fp

source ./scripts/3_Powerplan.tcl > log/powerplan.rpt

save_mw_cel -as ${design}_3_power

source ./scripts/4_Placement.tcl > log/placement.rpt

save_mw_cel -as ${design}_4_placed

source ./scripts/5_CTS.tcl
# > log/cts.rpt

save_mw_cel -as ${design}_5_cts

source ./scripts/6_Routing.tcl 
#> log/routing.rpt
# view drc errors: ctrl+shift+e
save_mw_cel -as ${design}_6_routed

verify_zrt_route
report_timing
report_timing -delay_type min
report_constraints -all_violators -max_delay -min_delay
 
source ./scripts/7_Finishing.tcl 
#> log/finishing.rpt
save_mw_cel -as ${design}_7_finished
save_mw_cel -as ${design}

source ./scripts/8_checks_and_outputs.tcl 
#> log/final_checks_and_output.rpt
#exit

#run eco.tcl after sta


#icwbev -debug -nodisplay -run scripts/swap

#| tee log/all_logs.log
