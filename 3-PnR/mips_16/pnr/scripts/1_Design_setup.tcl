##############################################
########### 1. DESIGN SETUP ##################
##############################################
source /home/ahesham/Desktop/Teaching/ali_maher/tool_variables_container.tcl
set design mips_16

# this line is dangerous, deletes all previous saved cells
#sh rm -rf $design

set sc_dir "/home/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12"

set_app_var search_path "/home/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12/lib/Front_End/Liberty/NLDM"

set_app_var link_library "* NangateOpenCellLibrary_ss0p95vn40c.db"
set_app_var target_library "NangateOpenCellLibrary_ss0p95vn40c.db"


create_mw_lib   ./${design} \
                -technology $sc_dir/tech/techfile/milkyway/FreePDK45_10m.tf \
		-mw_reference_library $sc_dir/lib/Back_End/mdb \
		-hier_separator {/} \
		-bus_naming_style {[%d]} \
		-open

set tlupmax "$sc_dir/tech/rcxt/FreePDK45_10m_Cmax.tlup"
set tlupmin "$sc_dir/tech/rcxt/FreePDK45_10m_Cmin.tlup"
set tech2itf "$sc_dir/tech/rcxt/FreePDK45_10m.map"

set_tlu_plus_files -max_tluplus $tlupmax \
                   -min_tluplus $tlupmin \
     		   -tech2itf_map $tech2itf


import_designs  ../syn/output/${design}.v \
                -format verilog \
		-top ${design} \
		-cel ${design}


source  ../syn/cons/cons.tcl
set_propagated_clock [get_clocks clk]

#save_mw_cel -as ${design}_1_imported
