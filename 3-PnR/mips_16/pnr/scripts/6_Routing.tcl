##############################################
########### 6. Routing   #####################
##############################################

## Before starting to route, you should add spare cells
insert_spare_cells -lib_cell {NOR2_X4 NAND2_X4} \
		   -num_instances 20 \
		   -cell_name SPARE_PREFIX_NAME \
		   -tie

set_dont_touch  [all_spare_cells] true
set_attribute [all_spare_cells]  is_soft_fixed true

##############################################

puts "start_route"

check_physical_design -stage pre_route_opt; # dump check_physical_design result to file ./cpd_pre_route_opt_*/index.html
all_ideal_nets
all_high_fanout -nets -threshold 100
check_routeability


set_delay_calculation_options -arnoldi_effort low

#Defines the delay model used to compute a timing arc delay value for a cell or net
#set_delay_calculation_options -preroute     elmore | awe (Asymptotic Waveform Evaluation)
#                              -routed_clock elmore | arnoldi
#			       -postroute    elmore | arnoldi
#			       -awe_effort     low | medium | high
#			       -arnoldi_effort low | medium | high
			      

set_route_options -groute_timing_driven true \
	          -groute_incremental true \
	          -track_assign_timing_driven true \
	          -same_net_notch check_and_fix 

set_si_options -route_xtalk_prevention true\
	       -delta_delay true \
	       -min_delta_delay true \
	       -static_noise true\
	       -timing_window true 


## route_opt : global, track, and detail routing, S&R, logic and placement optimizations with ECO routing
##             End goal: Design that meets timing, crosstalk and route DRC rules

#route_opt -effort high \
#	  -stage track        : which stage to run optimization after
#	  -xtalk_reduction    : to reduce crosstalk in routing 
#	  -incremental        : to improve results of a routed design.
#	  -initial_route_only : This is to avoid full routing and post-routing optimizations. Only do the basic steps.

## To Consider Hold Fix
#   set_fix_hold_options -prioritize_tns
   set_fix_hold [all_clocks]
   set_prefer -min  [get_lib_cells "*/BUF_X2 */BUF_X1"]
   set_fix_hold_options -preferred_buffer


route_opt
psynopt  -only_hold_time -congestion
route_zrt_eco -open_net_driven true 
# run it in case of open routing
# when you delete a drc problem (delete all net using ctrl-shift-n then delete)

verify_zrt_route
route_zrt_detail -incremental true -initial_drc_from_input true

insert_zrt_redundant_vias
verify_zrt_route
route_zrt_detail -incremental true -initial_drc_from_input true

derive_pg_connection     -power_net VDD		\
			 -ground_net VSS	\
			 -power_pin VDD		\
			 -ground_pin VSS	




#report_noise
#report_timing -crosstalk_delta


#save_mw_cel -as ${design}_6_routed

puts "finish_route"
