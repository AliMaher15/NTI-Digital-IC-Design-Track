class seq_item extends uvm_sequence_item;
    `uvm_object_utils(seq_item)

    bit rst_op = 0;
    rand bit en;
    rand logic [3:0] addr;
    rand logic [31:0] data_in;
    rand logic [31:0] data_out;
    rand bit valid_out;

    function new(string name = "seq_item");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        printer.print_field (.name("rst_op"), .value(rst_op), .size(1), .radix(UVM_BIN));
        printer.print_field ("en", en, 1, UVM_BIN);
        printer.print_field ("addr", addr, $bits(addr), UVM_DEC);
        printer.print_field ("data_in", data_in, $bits(data_in), UVM_HEX);
        printer.print_field ("data_out", data_out, $bits(data_out), UVM_HEX);
        printer.print_field ("valid_out", valid_out, 1);
    endfunction
endclass