##############################################
########### 4. Placement #####################
##############################################
puts "start_place"

## CHECKS
#########
report_ignored_layers ; # To Make sure they are as wanted.
check_physical_design -stage pre_place_opt
check_physical_constraints

## CONSTRAINTS 
##############
## Here, We define more constraints on your design that are related to placement stage.

#### Scenario Creation ####create_scenario pw
#### Scenario Creation ####set_operating_conditions worst_low
#### Scenario Creation ####set_tlu_plus_files -max_tluplus $tlupmax \
#### Scenario Creation ####                   -min_tluplus $tlupmin \
#### Scenario Creation ####     		   -tech2itf_map $tech2itf
#### Scenario Creation ####
#### Scenario Creation ####set_scenario_options -leakage_power true; #If we need to optimize leakage power, more effective for multi-Vth designs.
#### Scenario Creation ####set power_default_toggle_rate 0.003
#### Scenario Creation ####set_scenario_options -dynamic_power true
#### Scenario Creation ####
#### Scenario Creation ####source  ../syn/cons/cons.tcl
#### Scenario Creation ####set_propagated_clock [get_clocks clk]
#### Scenario Creation ####
#### Scenario Creation ####set_optimize_pre_cts_power_options -low_power_placement true
#### Scenario Creation ####
#### Scenario Creation ####report_scenario_options


## INITIAL PLACEMENT
####################
## Initial Placement can be done using the following command using any of its target options 
#place_opt -area_recovery |-power |-congestion|
place_opt

## ASSESSMENT
#############
## Open Congestion Map. == > If congested, improve congestion similar to floorplanning.
## Report Timing 

## FIXES
########
# For seriuos congestion issue use the following commands:
#   set placer_enable_enhanced_router TRUE; # enabling the actual GR instead of GR estimator. Increased run time!
#   refine_placement ==> Optimizes congestion only

# If there are violating timing paths, apply optimization -focus- as needed: 
#   report_path_group
#   group_path -name clk -critical_range 1 -weight 5


## OPTIMIZATION
###############
# psynopt -area_recovery |-power| |-congestion| 
psynopt

#The  psynopt  command  performs incremental preroute or postroute opti-
#mization on the current design. Performs incremental timing-driven  (setup timing, by default) logic optimization with placement legalization.
# It considers other targets using different options
# ex : psynopt -no_design_rule | -only_design_rule | -size_only ==> Used for Focused placment optimization

## FINAL ASSESSMENT
###################

check_legality
## If no legalized cells => legalize_placement -effort high -incremental 
# Check Congestion
# Check Timing 
# report_design_physical -utilization

# DEFINING POWER/GROUND NETS AND PINS			 
derive_pg_connection     -power_net VDD		\
			 -ground_net VSS	\
			 -power_pin VDD		\
			 -ground_pin VSS	

## Tie fixed values
set tie_pins [get_pins -all -filter "constant_value == 0 || constant_value == 0 && name !~ V* && is_hierarchical == false "]

derive_pg_connection 	 -power_net VDD		\
			 -ground_net VSS	\
			 -tie

if {[sizeof_collection $tie_pins] > 0 } {
	connect_tie_cells -objects $tie_pins \
                  -obj_type port_inst \
		  -tie_low_lib_cell  */LOGIC0_X1 \
		  -tie_high_lib_cell */LOGIC1_X1
}




puts "finish_place"

#save_mw_cel -as ${design}_4_placed
