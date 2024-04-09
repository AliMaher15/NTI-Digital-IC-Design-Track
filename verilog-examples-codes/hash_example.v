module hash_example();

    reg [2:0] A = 3'b101,
              B = 3'b111,
              C = 3'b001;

    initial begin
        $monitor("[%0t] A=%b, B=%b, C=%b", $time, A, B, C);
    end
        

    initial begin
        #5 A = B-C;
    end

    initial begin
        #3 B = 3'b100;
    end


endmodule