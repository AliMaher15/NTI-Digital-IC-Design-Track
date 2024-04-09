create_clock -name clk -period $clock_period -waveform $posedge_time [get_ports clk]

set_input_delay -max $inout_delay -clock [get_clocks clk] [remove_from_collection [all_inputs] [get_ports clk]]

set_output_delay -max $inout_delay -clock [get_clocks clk] [all_outputs]

set_clock_uncertainty $clk_uncertainty [get_clocks]

set_false_path -hold -from [remove_from_collection [all_inputs] [get_ports clk]]

set_false_path -hold -to [all_outputs]

