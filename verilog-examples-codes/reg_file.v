module reg_file #(parameter width_addr=2,
                            width_data=8,
                            memory_depth=4
                 ) 
(
    input  wire clk, rst,
    // Write 
    input  wire  wr_en,
    input  wire  [width_addr-1:0]  wr_addr,
    input  wire  [width_data-1:0]  wr_data,
    // Read
    input  wire  rd_en,
    input  wire  [width_addr-1:0]  rd_addr,
    output reg   [width_data-1:0]  rd_data,
    output wire                    invalid_access;
);

// type width name depth
reg [width_data-1:0] mem [0:memory_depth-1];
integer i;

// Memory Behaviour
always@(posedge clk or negedge rst) begin
    if (!rst) begin
        for (i=0; i<memory_depth; i=i+1) begin
            mem[i] <= 0;
        end
    // Write operation    
    end else if(wr_en && !rd_en) begin
        mem[wr_addr] <= wr_data;
    end
end

// Output read data 
always@(posedge clk or negedge rst) begin
    if (!rst) begin
        rd_data <= 0;
    // Write operation    
    end else if(rd_en && !wr_en) begin
        rd_data <= mem[rd_addr];
    end
end

assign invalid_access = (wr_en && rd_en) ? 1'b1 : 1'b0;

endmodule


//*****************************************//
//************* TESTBENCH *****************//
module reg_file_tb();

    `timescale 1ns/1ns

    parameter width_addr=2;
    parameter width_data=8;
    parameter memory_depth=4;

    integer i;

    reg clk, rst;
    // Write 
    reg  wr_en;
    reg   [width_addr-1:0]  wr_addr;
    reg   [width_data-1:0]  wr_data;
    // Read
    reg                     rd_en;
    reg   [width_addr-1:0]  rd_addr;
    wire  [width_data-1:0]  rd_data;

    reg_file#(.width_addr(width_addr), 
              .width_data(width_data), 
            .memory_depth(memory_depth)) 
    dut (
    .clk(clk), 
    .rst(rst),
    // Write 
    .wr_en(wr_en),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    // Read
    .rd_en(rd_en),
    .rd_addr(rd_addr),
    .rd_data(rd_data)
    );

    always #5 clk=~clk;

    initial begin
        clk = 0;
        rst = 0;
        wr_en=0;
        wr_addr = 0;
        wr_data = 0;
        rd_addr = 0;
        rd_en = 0;
        #20;
        rst = 1;
        #10;
        read_op('d0);
        for (i=1; i<memory_depth; i=i+1) begin
            #10;
            read_op(i);
        end
        #10;
        write_op('d0, 'd2);
        #10;
        write_op('d2, 'd3);
        #10;
        write_op('d1, 'd5);
        #10;
        for (i=0; i<memory_depth; i=i+1) begin
            #10;
            read_op(i);
        end
        #200;
        $stop();
    end

task read_op(input [width_addr-1:0] addr);
    begin
        rd_en = 1;
        rd_addr = addr;
        #10;
        rd_en = 0;
    end
endtask

task write_op(input [width_addr-1:0] addr, input [width_data-1:0] data);
    begin
        wr_en = 1;
        wr_addr = addr;
        wr_data = data;
        #10;
        wr_en = 0;
    end
endtask
    
endmodule