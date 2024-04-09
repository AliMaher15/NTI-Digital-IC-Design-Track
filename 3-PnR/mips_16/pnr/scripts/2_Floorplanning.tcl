##############################################
########### 2. Floorplan #####################
##############################################

## Create Starting Floorplan
############################
create_floorplan -core_utilization $core_util \
	-start_first_row -flip_first_row \
	-left_io2core $io_dist -bottom_io2core $io_dist -right_io2core $io_dist -top_io2core $io_dist


## CONSTRAINTS
##############
## Here, We define more constraints on your design that are related to floorplan stage.
report_ignored_layers
remove_ignored_layers -all
set_ignored_layers -max_routing_layer metal6

## Initial Virtual Flat Placement
#################################
## Use the following command with any of its options to meet a specific target
#    create_fp_placement -timing -no_hierarchy_gravity -congestion 
#     create_fp_placement

##AH## ## To show design-specific blocks
##AH## gui_set_highlight_options -current_color yellow
##AH## change_selection [get_cells   alu_unit/*]

##AH## gui_set_highlight_options -current_color blue
##AH## change_selection [get_cells   ALU_Control_unit/*]

##AH## gui_set_highlight_options -current_color green
##AH## change_selection [get_cells   datamem/*]

##AH## gui_set_highlight_options -current_color orange
##AH## change_selection [get_cells   reg_file/*]

## ASSESSMENT
#############
## Analyze Congestion
#route_fp_proto -congestion_map_only -effort medium    
# View Congestion map : In GUI, Route > Global Route Congestion Map.

## Analyze Timing
#extract_rc; # Improves accuracy of timing after updated GR.

#report_timing -nosplit; # For Worst Setup violation report
#report_timing -nosplit -delay_type min; # For Worst Hold violation report

#report_constraint -all_violators -nosplit -max_delay; # For all Setup violation report
#report_constraint -all_violators -nosplit -min_delay; # For all Hold violations report

##Based on your assessment, you may need to do any of the following fixes

## FIXES
########
## You can use one or all of the follwoing based on your need.
#   set_fp_placement_strategy -virtual_IPO on 
#
#   create_bounds -name "temp" -coordinate {55 0 270 270} datamem
#   create_bounds -name "temp1" -coordinate {0 0 104 270} reg_file
#
#   set_congestion_options -max_util 0.4 -coordinate {x1 y1 x2 y2}; # if cell density is causing congestion.
#
#   create_placement_blockage -name PB -type hard -bbox {x1 y1 x2 y2}
#
#   set_fp_placement_strategy -congestion_effort high
#
## Then you need to re-run create_fp_placement
#   create_fp_placement -incremental; 
## Note:  use -incremental option if you want to refine the current virtual placement. Don't use it if you want to re-place the design from scratch 

## If there still congestion, change ignored layers, if it is still there, increase floorplan area.

#save_mw_cel -as ${design}_2_fp


