
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name prj2 -dir "G:/ise_proj/prj2/planAhead_run_4" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "johnson_leds.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {sequence_led.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top johnson_leds $srcset
add_files [list {johnson_leds.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
