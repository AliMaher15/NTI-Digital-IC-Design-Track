##############################################
########### 5. CTS       #####################
##############################################

puts "start_cts"

## CHECKS
#########
check_physical_design -stage pre_clock_opt 
check_clock_tree 
report_clock_tree


## CONSTRAINTS 
##############
## Here, We define more constraints on your design that are related to CTS stage.

set_driving_cell -lib_cell BUF_X16 -pin Z [get_ports clk]
###OR
# set_input_transition -rise 0.3 [get_ports clk]
# set_input_transition -fall 0.2 [get_ports clk]


#### Set Clock Exceptions


### Set Clock Control/Targets
set_clock_tree_options \
                -clock_trees clk \
		-target_early_delay 0.1 \
		-target_skew $max_skew \
		-max_capacitance 300 \
		-max_fanout 10 \
		-max_transition 0.3

set_clock_tree_options -clock_trees clk \
		-buffer_relocation true \
		-buffer_sizing true \
		-gate_relocation true \
		-gate_sizing true 

## Selection of CTS cells
set_clock_tree_references -references [get_lib_cells */CLKBUF*] 
#set_clock_tree_references -references [get_lib_cells */BUF*] 
#set_clock_tree_references -references [get_lib_cells */INV*] 

## Selection of CTO cells
#set_clock_tree_references -sizing_only -references "BEST_PRACTICE_buffers_for_CTS_CTO_sizing"
#set_clock_tree_references -delay_insertion_only -references "BEST_PRACTICE_cels_for_CTS_CTO_delay_insertion" 



### Set Clock Physical Constraints
## Clock Non-Default Ruls (NDR) - Set it to be double width and double spacing 
define_routing_rule my_route_rule  \
  -widths   {metal3 0.14 metal4 0.28 metal5 0.28} \
  -spacings {metal3 0.14 metal4 0.28 metal5 0.28} 

set_clock_tree_options -clock_trees clk \
                       -routing_rule my_route_rule  \
		       -layer_list "metal3 metal4 metal5"

## To avoid NDR at clock sinks
set_clock_tree_options -use_default_routing_for_sinks 1

report_clock_tree -settings


## Clock Tree : Synhtesis, Optimization, and Routing
####################################################
## The 3 steps can be done with the combo command clock_opt. But below, we do them individually.

## 1- CTS 
clock_opt -only_cts -no_clock_route
## analyze
    report_design_physical -utilization
    report_clock_tree -summary ; # reports for the clock tree, regardless of relation between FFs
    report_clock_tree
    report_clock_timing -type summary ; # reports for the clock tree, considering relation between FFs
    report_timing
    report_timing -delay_type min
    report_constraints -all_violators -max_delay -min_delay
    # Check Congestion
    # Check Timing


## 2- CTO
## To Consider Hold Fix -- Design Dependent
set_fix_hold [all_clocks]
set_fix_hold_options -prioritize_tns
clock_opt -only_psyn -no_clock_route #-only_hold_time
#analyze


## 3- Clock Tree Routing
route_group -all_clock_nets
#analyze


## If any issue at analysis, update CT constraints 
##################################################

# DEFINING POWER/GROUND NETS AND PINS			 
derive_pg_connection     -power_net VDD		\
			 -ground_net VSS	\
			 -power_pin VDD		\
			 -ground_pin VSS	
			 
#save_mw_cel -as ${design}_5_cts

puts "finish_cts"
