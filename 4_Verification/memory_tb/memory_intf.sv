interface memory_intf (
    input logic clk,
    input logic rst
);

logic en;
logic [3:0] addr;
logic [31:0] data_in;
logic [31:0] data_out;
logic valid_out;

endinterface