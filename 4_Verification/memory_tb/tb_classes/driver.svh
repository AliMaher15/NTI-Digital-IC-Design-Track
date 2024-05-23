class driver extends uvm_driver#(seq_item);
    `uvm_component_utils(driver)

    virtual memory_intf vif;
    seq_item item;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of Driver", UVM_MEDIUM)
        
        if(!uvm_config_db#(virtual memory_intf)::get(this, "", "intf", vif))
            `uvm_fatal(get_type_name(), "failed to get intf")
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Run phase of Driver", UVM_MEDIUM)
        cleanup();
        forever begin
            @(negedge vif.rst);
            fork
                forever begin
                    @(negedge vif.clk);
                    seq_item_port.get_next_item(item);
                    vif.en      <= item.en;
                    vif.addr    <= item.addr;
                    vif.data_in <= item.data_in;
                    seq_item_port.item_done();
                end
            join_none
            @(posedge vif.rst);
            disable fork;
            cleanup();
        end
    endtask

    task cleanup();
        vif.en        <= 0;
        vif.addr      <= 0;
        vif.data_in   <= 0;
    endtask
endclass