source /home/ahesham/Desktop/Teaching/ali_maher/tool_variables_container.tcl

set link_path  "/home/standard_cell_libraries/NangateOpenCellLibrary_PDKv1_3_v2010_12/lib/Front_End/Liberty/NLDM/NangateOpenCellLibrary_ff1p25v0c.db"

read_verilog "../../../pnr/output/mips_16_icc.v"

current_design mips_16
link

source ../../../syn/cons/cons.tcl
#read_parasitics ../../rcxt/cmin/mips_16_cmin_t125.spef
read_parasitics ../../../pnr/output/mips_16.spef.min

update_timing

save_session mips_16_min_solveddrc1.session
#restore_session <session_name>

report_constraint -all_violators -significant_digits 4 > ./mips_16.min_constr.rpt
report_timing -delay_type min -significant_digits 4 > ./mips_16.min_timing.rpt
#-nworst 40
#-max_path
#-nets : to see fanout

#insert_buffer <net_name> <BUF_X<size>>
#remove_buffer <net_name of buffer>

#report_timing -delay_type <min/max> -from <startpoint> -to <endpoint> -significant_digits 4

# BUF_X1  : 0.0221
# BUF_X2  : 0.0254
# BUF_X4  : 0.0340
# BUF_X8  : 0.0548
# BUF_X16 : 0.0904
# BUF_X32 : 0.1759

#fix_eco_timing -type hold -methods {insert_buffer size_cell} -buffer_list {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32}

#type : setup hold

#methods: {size_cell insert_buffer_at_load_pins insert_buffer}
# if fixing setup, only allow size_cell and not inserting buffers

#slack_lesser_than <slack_limit> : fix paths with slack less than <slack_limit>, default=0
#slack_greater_than <slack_limit>: fix paths with slack more than <slack_limit>

#setup_margin: give bigger fixing margin if you want, dafault is 0
#hold_margin : give bigger fixing margin if you want, dafault is 0

#ignore_drc: make primetime fix timing and not care for drc

#write_changes -format icc -output eco_min01.tcl


write_sdf ./mips_16.min.sdf




