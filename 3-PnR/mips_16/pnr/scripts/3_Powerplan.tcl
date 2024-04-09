##################################################
########### 3. POWER NETWORK #####################
##################################################

## Defining Logical POWER/GROUND Connections
############################################
derive_pg_connection 	 -power_net VDD		\
			 -ground_net VSS	\
			 -power_pin VDD		\
			 -ground_pin VSS	


## Define Power Ring 
####################
set_fp_rail_constraints  -set_ring -nets  {VDD VSS}  \
                         -horizontal_ring_layer { metal7 metal9 } \
                         -vertical_ring_layer { metal8 metal10 } \
			 -ring_spacing $ring_space \
			 -ring_width $ring_width \
			 -ring_offset $ring_offset \
			 -extend_strap core_ring

## Define Power Mesh 
####################
set_fp_rail_constraints -add_layer  -layer metal10 -direction vertical   -max_strap 128 -min_strap 20 -min_width 2.5 -spacing minimum
set_fp_rail_constraints -add_layer  -layer metal9  -direction horizontal -max_strap 128 -min_strap 20 -min_width 2.5 -spacing minimum
set_fp_rail_constraints -add_layer  -layer metal8  -direction vertical   -max_strap 128 -min_strap 20 -min_width 2.5 -spacing minimum
set_fp_rail_constraints -add_layer  -layer metal7  -direction horizontal -max_strap 128 -min_strap 20 -min_width 2.5 -spacing minimum
set_fp_rail_constraints -add_layer  -layer metal6  -direction vertical   -max_strap 128 -min_strap 20 -min_width 2.5 -spacing minimum

#set_fp_rail_constraints -add_layer  -layer metal10 -direction vertical   -max_pitch 12 -min_pitch 12 -min_width 5 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer metal9  -direction horizontal -max_pitch 12 -min_pitch 12 -min_width 5 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer metal8  -direction vertical   -max_pitch 12 -min_pitch 12 -min_width 5 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer metal7  -direction horizontal -max_pitch 12 -min_pitch 12 -min_width 5 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer metal6  -direction vertical   -max_pitch 12 -min_pitch 12 -min_width 5 -spacing minimum


set_fp_rail_constraints -set_global

## Creating virtual PG pads
###########################
# you can create them with gui. Preroute > Create Virtual Power Pad
# you can create them with gui. Preroute > Create Virtual Power Pad
set llx  [lindex [lindex [get_attribute [get_die_area] bbox] 0] 0]
set llu  [lindex [lindex [get_attribute [get_die_area] bbox] 0] 1]
set urx  [lindex [lindex [get_attribute [get_die_area] bbox] 1] 0]
set ury  [lindex [lindex [get_attribute [get_die_area] bbox] 1] 1]

for {set i $llx} {$i <= $urx } {set i  [expr $i+40]} {
    # Loop body
	
	create_fp_virtual_pad -net VSS -point "{$i $llu }"
	create_fp_virtual_pad -net VDD -point "{[expr $i+20] $llu}"

	create_fp_virtual_pad -net VSS -point "{$i $ury }"
	create_fp_virtual_pad -net VDD -point "{[expr $i+20] $ury}"
	
}

for {set i [expr $llx+40]} {$i <= [expr $ury-40] } {set i  [expr $i+40]} {
    # Loop body
	
	create_fp_virtual_pad -net VSS -point "{$llx $i}"
	create_fp_virtual_pad -net VDD -point "{$llx [expr $i+20]}"

	create_fp_virtual_pad -net VSS -point "{$urx $i}"
	create_fp_virtual_pad -net VDD -point "{$urx [expr $i+20]}"
	
}


synthesize_fp_rail  -nets {VDD VSS} -synthesize_power_plan -target_voltage_drop 22 -voltage_supply 1.1 -power_budget 500
## Analyze IR-drop; Modify power network constraints and re-synthesize, as needed.
## Max IR is 2% of Nominal Supply. In our case, 0.02 x 1.1v= 22mv

commit_fp_rail

set_preroute_drc_strategy -max_layer metal6
preroute_standard_cells -fill_empty_rows -remove_floating_pieces

## If you want to remove power and recreate it
#remove_net_shape  [get_net_shapes -of_objects [get_nets -all "VSS VDD"]]
#remove_via  [get_vias -of_objects [get_nets -all "VSS VDD"]]
## MAy need => remove_fp_virtual_pad -all

## Analyze IR-drop; Modify power network constraints and re-synthesize, as needed.
analyze_fp_rail  -nets {VDD VSS} -power_budget 500 -voltage_supply 1.1


## Final Floorplan Assessment
create_fp_placement -incremental all; # Updates fp placement after PG mesh creation.
#### Analyze Congestion
#### Analyze Timing


## Add Well Tie Cells
#####################
add_tap_cell_array -master   TAP \
     		   -distance 30 \
     		   -pattern  stagger_every_other_row

#save_mw_cel -as ${design}_3_power
