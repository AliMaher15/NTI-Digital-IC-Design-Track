module lock_fsm (
    input  wire clk, rst,
    input  wire button0, button1, lock,
    output reg  unlocked, wrong_password
);

localparam [2:0]    idle   = 3'b000,
                    S1     = 3'b001,
                    S11    = 3'b010,
                    S011   = 3'b011,
                    S1011  = 3'b100,
                    S01011 = 3'b101;

reg [2:0] current_state, next_state;
reg wrong_pass;

// present state
always @(posedge clk, negedge rst) begin
    if(!rst) begin
        current_state <= 0;
        wrong_password <= 0;
    end else begin
        current_state <= next_state;
        wrong_password <= wrong_pass;
    end
end

// next state transition
always@(*) begin
    next_state = idle;
    case(current_state)
        idle  : begin
                    if(lock) begin
                        next_state = idle;
                    end else if(button0) begin
                        next_state = idle;
                    end else if (button1) begin
                            next_state = S1;
                    end else begin
                        next_state = idle;
                    end 
        end
        S1    : begin 
                    if(lock) begin
                        next_state = idle;
                    end else if(button0) begin
                        next_state = idle;
                    end else if (button1) begin
                            next_state = S11;
                    end else begin
                        next_state = idle;
                    end 
        end
        S11   : begin 
                    if(lock) begin
                        next_state = idle;
                    end else if(button0) begin
                        next_state = S011;
                    end else if (button1) begin
                            next_state = idle;
                    end else begin
                        next_state = idle;
                    end 
        end
        S011  : begin 
                    if(lock) begin
                        next_state = idle;
                    end else if(button0) begin
                        next_state = idle;
                    end else if (button1) begin
                            next_state = S1011;
                    end else begin
                        next_state = idle;
                    end 
        end
        S1011 : begin 
                    if(lock) begin
                        next_state = idle;
                    end else if(button0) begin
                        next_state = S01011;
                    end else if (button1) begin
                            next_state = idle;
                    end  else begin
                        next_state = idle;
                    end 
        end
        S01011: begin 
                    if(lock) begin
                        next_state = idle;
                    end else begin
                        next_state = S01011;
                    end 
        end
    endcase
end

// output logic
always@(*) begin
    unlocked = 0;
    wrong_pass = 0;
    case(current_state)
        idle  : begin
                    wrong_pass = 0; 
        end
        S1    : begin 
                    if(lock) begin
                        wrong_pass = 0;
                    end else if(button0) begin
                        wrong_pass = 1;
                    end else if (button1) begin
                            wrong_pass = 0;
                    end else begin
                        wrong_pass = 1;
                    end 
        end
        S11   : begin 
                    if(lock) begin
                        wrong_pass = 0;
                    end else if(button0) begin
                        wrong_pass = 0;
                    end else if (button1) begin
                            wrong_pass = 1;
                    end else begin
                        wrong_pass = 1;
                    end 
        end
        S011  : begin 
                    if(lock) begin
                        wrong_pass = 0;
                    end else if(button0) begin
                        wrong_pass = 1;
                    end else if (button1) begin
                            wrong_pass = 0;
                    end else begin
                        wrong_pass = 1;
                    end 
        end
        S1011 : begin 
                    if(lock) begin
                        wrong_pass = 0;
                    end else if(button0) begin
                        wrong_pass = 0;
                    end else if (button1) begin
                            wrong_pass = 1;
                    end  else begin
                        wrong_pass = 1;
                    end 
        end
        S01011: begin 
                    wrong_pass = 0; 
                    unlocked = 1;
        end
        default : begin 
                    unlocked = 0;
                    wrong_pass = 0;
        end
    endcase
end

endmodule


//*******************************//
//          TESTBENCH            //
//*******************************//
module lock_fsm_tb();

    `timescale 1ns/1ns

    reg clk, rst;

    reg   button0, button1, lock;
    wire  unlocked, wrong_password;

    lock_fsm dut (
        .clk(clk),
        .rst(rst),
        .button0(button0),
        .button1(button1),
        .lock(lock),
        .unlocked(unlocked),
        .wrong_password(wrong_password)
    );

    always #5 clk=!clk;

    initial begin
        clk = 0;
        rst = 0;
        button0 = 0;
        button1 = 0;
        lock = 0;
        #10;
        rst = 1;
        // password to unlock 1 1 0 1 0
        //         b0, b1
        // try correct passwords
        write_input(0, 1); // 1
        write_input(0, 1); // 1
        write_input(1, 0); // 0
        write_input(0, 1); // 1
        write_input(1, 0); // 0

        write_input(0, 0);

        lock = 1;
        #20;
        lock = 0;
        // try wrong passwords
        write_input(0, 1); // 1
        write_input(0, 1); // 1
        write_input(0, 1); // 1 // wrong

        write_input(0, 0);

        write_input(0, 1); // 1
        write_input(0, 1); // 1
        write_input(1, 0); // 0
        lock = 1;
        #20;
        lock = 0;
        write_input(1, 0); // 0 // wrong

        write_input(0, 0);

        write_input(0, 1); // 1
        write_input(0, 1); // 1
        write_input(1, 0); // 0
        write_input(1, 0); // 0 // wrong
        #100;
        $stop();

    end

    task write_input(input b0, input b1);
    begin
        button0 = b0;
        button1 = b1; 
        #10;
    end
    endtask

endmodule