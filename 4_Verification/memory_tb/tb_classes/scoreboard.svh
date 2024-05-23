class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    uvm_analysis_export#(seq_item) in_imp;
    uvm_analysis_export#(seq_item) out_imp;

    uvm_tlm_analysis_fifo#(seq_item) in_fifo;
    uvm_tlm_analysis_fifo#(seq_item) out_fifo;

    bit test_ended = 0;

    bit [31:0] memory [16];

    typedef enum int {
        valid_error, data_error
    } error_type;
    error_type error_array [int];

    int TEST_CNT, PASS_CNT, ERROR_CNT;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        in_imp   = new("in_imp", this);
        out_imp  = new("out_imp", this);
        in_fifo  = new("in_fifo", this);
        out_fifo = new("out_fifo", this);
    endfunction

    extern function void connect_phase(uvm_phase phase);

    extern task run_phase(uvm_phase phase);

    extern function void PASS(seq_item in, seq_item out); 

    extern function void ERROR(error_type err, seq_item in, seq_item out, int exp_value); 

    extern function void report_phase(uvm_phase phase);

    extern function void phase_ready_to_end(uvm_phase phase);

    extern task wait_for_ok_to_finish();
endclass


function void scoreboard::connect_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Connect phase of Scoreboard", UVM_MEDIUM)

    in_imp .connect(in_fifo.analysis_export);
    out_imp.connect(out_fifo.analysis_export);
endfunction


task scoreboard::run_phase(uvm_phase phase);
    seq_item in, out;
    `uvm_info(get_type_name(), "Run phase of Scoreboard", UVM_MEDIUM)
    memory = '{default: 0};
    memory[0] = 32'h12345678;
    memory[1] = 32'h9abcdef0;
    forever begin
        in_fifo.get(in);
        out_fifo.get(out);
        if(in.rst_op || out.rst_op) begin
            `uvm_info(get_type_name(), "flushing fifo", UVM_FULL)
            in_fifo.flush();
            out_fifo.flush();
            memory = '{default: 0};
            continue;
        end
        TEST_CNT++;
        if(in.en) begin
            // check for valid
            if(!out.valid_out) begin
                ERROR(valid_error, in, out, 1);
            end
            // check for data_out
            if(out.data_out != memory[in.addr]) begin
                ERROR(data_error, in, out, memory[in.addr]);
            end
            // pass
            if(out.valid_out && (out.data_out == memory[in.addr])) begin
                PASS(in, out);
            end
            // update the new value in memory
            memory[in.addr] = in.data_in;
        end else begin
            // check for valid
            if(out.valid_out) begin
                ERROR(valid_error, in, out, 0);
            end
            // pass
            if(!out.valid_out) begin
                PASS(in, out);
            end
        end
    end
endtask


function void scoreboard::PASS(seq_item in, seq_item out); 
    PASS_CNT++;
    `uvm_info (get_type_name(), $sformatf("\nInput=%s\nOutput=%s \n",
                                in.sprint(), 
                                out.sprint()), UVM_HIGH)
endfunction: PASS


function void scoreboard::ERROR(error_type err, seq_item in, seq_item out, int exp_value);
    ERROR_CNT++;
    error_array[TEST_CNT] = err;
    `uvm_error(get_type_name(), $sformatf("\n%s\nInput & Output =", err))
    in.print();
    out.print();
    `uvm_info (get_type_name(), $sformatf("\nExpected = %0h \n", exp_value), UVM_NONE)
endfunction: ERROR


function void scoreboard::report_phase(uvm_phase phase);
    if (TEST_CNT && !ERROR_CNT) begin
        `uvm_info(get_type_name(),$sformatf("\n\n\n*** TEST PASSED - %0d vectors ran, %0d vectors passed ***\n", 
                                            TEST_CNT, PASS_CNT), UVM_LOW) 
    end else begin
        `uvm_info(get_type_name(), $sformatf("\n\n\n*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***\n",
                                             TEST_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
    end
    for (int i=1; i<=TEST_CNT; i++) begin
        if(error_array.exists(i))
            `uvm_info(get_type_name(), $sformatf("\nerror at test index %0d : %0s", i, error_array[i].name()), UVM_LOW)
    end
endfunction: report_phase


function void scoreboard::phase_ready_to_end(uvm_phase phase);
    if(phase.is(uvm_run_phase::get)) begin
        if(!test_ended) begin
            phase.raise_objection(this);
            fork
                begin
                    wait_for_ok_to_finish();
                    phase.drop_objection(this);
                end
            join_none
        end
    end
endfunction


task scoreboard::wait_for_ok_to_finish();
    wait(in_fifo.used() == out_fifo.used());
    test_ended = 1;
endtask