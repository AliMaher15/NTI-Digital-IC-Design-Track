# reset
set_fp_rail_constraints -remove_all_layers
remove_fp_virtual_pad -all              
set_fp_rail_strategy -reset             
set_fp_block_ring_constraints -remove_all
set_fp_rail_region_constraints  -remove 
# global constraints
set_fp_rail_constraints -set_global 

# layer constraints
set_fp_rail_constraints -add_layer  -layer metal10 -direction vertical -max_strap 128 -min_strap 20 -max_width 5.000000 -min_width 2.500000 -spacing minimum 
set_fp_rail_constraints -add_layer  -layer metal9 -direction horizontal -max_strap 128 -min_strap 20 -max_width 5.000000 -min_width 2.500000 -spacing minimum 
set_fp_rail_constraints -add_layer  -layer metal8 -direction vertical -max_strap 128 -min_strap 20 -max_width 5.000000 -min_width 2.500000 -spacing minimum 
set_fp_rail_constraints -add_layer  -layer metal7 -direction horizontal -max_strap 128 -min_strap 20 -max_width 5.000000 -min_width 2.500000 -spacing minimum 
set_fp_rail_constraints -add_layer  -layer metal6 -direction vertical -max_strap 128 -min_strap 20 -max_width 5.000000 -min_width 2.500000 -spacing minimum 

# ring and strap constraints
set_fp_rail_constraints  -set_ring -nets { VDD VSS } -horizontal_ring_layer { metal7,metal9 } -vertical_ring_layer { metal8,metal10 } -ring_width 5.000000 -ring_spacing 0.800000 -ring_offset 0.800000 -extend_strap core_ring 

# strategies
set_fp_rail_strategy  -use_tluplus true 

# block ring constraints

# regions

# virtual pads
create_fp_virtual_pad -net VSS -point { 0.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 20.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 20.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 40.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 60.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 40.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 60.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 80.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 100.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 80.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 100.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 120.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 140.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 120.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 140.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 160.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 180.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 160.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 180.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 200.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 220.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 200.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 220.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 240.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 260.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 240.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 260.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 280.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 300.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 280.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 300.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 320.000000 0.000000 }
create_fp_virtual_pad -net VDD -point { 340.000000 0.000000 }
create_fp_virtual_pad -net VSS -point { 320.000000 327.200012 }
create_fp_virtual_pad -net VDD -point { 340.000000 327.200012 }
create_fp_virtual_pad -net VSS -point { 0.000000 40.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 60.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 40.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 60.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 80.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 100.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 80.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 100.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 120.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 140.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 120.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 140.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 160.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 180.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 160.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 180.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 200.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 220.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 200.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 220.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 240.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 260.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 240.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 260.000000 }
create_fp_virtual_pad -net VSS -point { 0.000000 280.000000 }
create_fp_virtual_pad -net VDD -point { 0.000000 300.000000 }
create_fp_virtual_pad -net VSS -point { 327.850006 280.000000 }
create_fp_virtual_pad -net VDD -point { 327.850006 300.000000 }

# synthesize_fp_rail 
synthesize_fp_rail -nets { VDD VSS } -voltage_supply 1.100000 -power_budget 500.000000  -target_voltage_drop 22.000000  
