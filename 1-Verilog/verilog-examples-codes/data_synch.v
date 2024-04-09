module data_synch #(parameter N=2, DWIDTH = 8) (
    input   wire              clk, rst,
    input   wire              bus_enable,
    input   wire [DWIDTH-1:0] unsync_bus,
    output  reg  [DWIDTH-1:0] sync_bus,
    output  reg               enable_pulse
);

reg    [N-1:0]   multiflop_enable_out;

reg     pulse_gen_ff;
wire    pulse_gen_enable_out;


//********* Multi Flop ************//
always @(posedge clk, negedge rst) begin
    if(!rst) begin
        multiflop_enable_out <= 'b0;
    end else begin
        multiflop_enable_out <= {multiflop_enable_out[N-2:0],bus_enable};
    end
end


//********* Pulse Gen flip flop ************//
always @(posedge clk, negedge rst) begin
    if(!rst) begin
        pulse_gen_ff <= 1'b0;
    end else begin
        pulse_gen_ff <= multiflop_enable_out[N-1];
    end
end
// Pulse Gen out
assign pulse_gen_enable_out = (!pulse_gen_ff && multiflop_enable_out[N-1]);


//********* Output mux sync bus ************//
always @(posedge clk, negedge rst) begin
    if(!rst) begin
        sync_bus <= 'b0;
    end else if(pulse_gen_enable_out) begin
        sync_bus <= unsync_bus;
    end
end

//*********  Output enable_pulse ************//
always @(posedge clk, negedge rst) begin
    if(!rst) begin
        enable_pulse <= 1'b0;
    end else begin
        enable_pulse <= pulse_gen_enable_out;
    end
end

endmodule

//**********************************************//
//                TESTBENCH                     //
//**********************************************//
module data_synch_tb();

    parameter N=2;
    parameter DWIDTH=4;

    reg                clk, rst;
    reg                bus_enable;
    reg   [DWIDTH-1:0] unsync_bus;
    wire  [DWIDTH-1:0] sync_bus;
    wire               enable_pulse;

    data_synch dut(
        .clk(clk),
        .rst(rst),
        .bus_enable(bus_enable),
        .unsync_bus(unsync_bus),
        .sync_bus(sync_bus),
        .enable_pulse(enable_pulse)
    );

    `timescale 1ns/1ns
    always #5 clk=!clk;

    initial begin
        clk = 0;
        rst = 0;
        bus_enable = 0;
        unsync_bus = 'b1001;
        #15; 
        rst = 1;
        #10;
        bus_enable = 1;
        #10;
        bus_enable = 0;
        #100;
        $stop();
    end
endmodule