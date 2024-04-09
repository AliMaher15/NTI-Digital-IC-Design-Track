##############################################
########## CLOCK CONSTRAINTS  ################
##############################################

# variables used in create_clock
set clock_period 2
set posedge_time {0 1}
# variable used in uncertainty
set clk_uncertainty [ expr $clock_period/11.42857142857143 ]
# input and output delay
set inout_delay [ expr $clock_period/2 ]

##############################################
########### 2. Floorplan #####################
##############################################

# core utilization option in create_floorplan
set core_util 0.4
# distance between dye and core in floorplan
set io_dist   12.4

##################################################
########### 3. POWER NETWORK #####################
##################################################

set ring_space 0.8 
set ring_width 5
set ring_offset 0.8

##############################################
########### 5. CTS       #####################
##############################################

set max_skew 0.5
