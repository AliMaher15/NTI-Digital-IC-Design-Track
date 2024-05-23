class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    virtual memory_intf vif;
    seq_item in_item;
    seq_item out_item;

    uvm_analysis_port#(seq_item) in_port;
    uvm_analysis_port#(seq_item) out_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        in_port  = new("in_port", this);
        out_port = new("out_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of Monitor", UVM_MEDIUM)
        
        if(!uvm_config_db#(virtual memory_intf)::get(this, "", "intf", vif))
            `uvm_fatal(get_type_name(), "failed to get intf")
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Run phase of Monitor", UVM_MEDIUM)
        cleanup();
        forever begin
            @(negedge vif.rst);
            fork
                //*******************************************//
                //**************  INPUT MONITOR   ***********//
                forever begin
                    in_item = seq_item::type_id::create("in_item");
                    @(posedge vif.clk);
                    #1;
                    in_item.en       = vif.en;
                    in_item.addr     = vif.addr;
                    in_item.data_in  = vif.data_in;
                    `uvm_info(get_type_name(), $sformatf("Print input item: %s", 
                                                        in_item.sprint()), UVM_FULL)
                    in_port.write(in_item);
                end
                //*******************************************//
                //*************  OUTPUT MONITOR   ***********//
                forever begin
                    out_item = seq_item::type_id::create("out_item");
                    @(posedge vif.clk);
                    #1;
                    out_item.data_out  = vif.data_out;
                    out_item.valid_out = vif.valid_out;
                    `uvm_info(get_type_name(), $sformatf("Print output item: %s", 
                                                        out_item.sprint()), UVM_FULL)
                    out_port.write(out_item);
                end
            join_none
            @(posedge vif.rst);
            disable fork;
            cleanup();
        end
    endtask

    task cleanup();
        seq_item item = seq_item::type_id::create("rst_item");
        item.rst_op = 1;
        in_port.write(item);
        out_port.write(item);
    endtask
endclass