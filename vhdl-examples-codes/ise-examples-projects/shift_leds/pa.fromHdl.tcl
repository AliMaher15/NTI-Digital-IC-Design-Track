
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ali_shift_leds -dir "F:/ise_proj/ali_shift_leds/planAhead_run_5" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "fsm_led.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {fsm_butterfly.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top fsm_led $srcset
add_files [list {fsm_led.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
