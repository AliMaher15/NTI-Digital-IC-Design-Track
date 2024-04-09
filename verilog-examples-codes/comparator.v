module comparator (
    input wire [2:0] a,b,
    output wire gt, lt, eq
);

// is a greater than b
assign gt = (a > b) ? 1 : 0;
// is a less than b
assign lt = (a < b) ? 1 : 0;
// is a equal b
assign eq = (a == b) ? 1 : 0;

endmodule

`timescale 1ns/1ps

// TESTBENCH
module comparator_tb();
reg [2:0] a,b;
wire gt,lt,eq;

comparator dut (
    .a(a),
    .b(b),
    .gt(gt),
    .lt(lt),
    .eq(eq)
);

// testbench
initial begin
    a = 1;
    b = 3;
    #5;
    $display("a = %0d, b = %0d:\n gt = %b \n lt = %b \n eq = %b",
             a, b, gt, lt, eq);

    a = 3;
    b = 1;
    #5;
    $display("a = %0d, b = %0d:\n gt = %b\n lt = %b\n eq = %b",
             a, b, gt, lt, eq);
             
    a = 1;
    b = 1;
    #5;
    $display("a = %0d, b = %0d:\n gt = %b\n lt = %b\n eq = %b",
             a, b, gt, lt, eq);
end
endmodule