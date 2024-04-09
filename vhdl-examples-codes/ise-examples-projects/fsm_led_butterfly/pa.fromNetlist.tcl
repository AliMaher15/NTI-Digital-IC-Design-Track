
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name butter -dir "F:/ise_proj/butter/planAhead_run_2" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "F:/ise_proj/butter/fsm_led.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {F:/ise_proj/butter} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "fsm_led.ucf" [current_fileset -constrset]
add_files [list {fsm_led.ucf}] -fileset [get_property constrset [current_run]]
link_design
