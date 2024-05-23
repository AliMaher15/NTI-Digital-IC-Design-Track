class agent extends uvm_agent;
    `uvm_component_utils(agent)

    driver  drv0;
    monitor mon0;
    sequencer seqr0;
    virtual memory_intf vif;
    uvm_analysis_port#(seq_item) in_port;
    uvm_analysis_port#(seq_item) out_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        in_port = new("in_port", this);
        out_port = new("out_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of Agent", UVM_MEDIUM)

        if(!uvm_config_db#(virtual memory_intf)::get(this, "", "intf", vif))
            `uvm_fatal(get_type_name(), "failed to get intf")
        uvm_config_db#(virtual memory_intf)::set(this, "drv0", "intf", vif);
        uvm_config_db#(virtual memory_intf)::set(this, "mon0", "intf", vif);

        drv0  = driver   ::type_id::create("drv0" , this);
        mon0  = monitor  ::type_id::create("mon0" , this);
        seqr0 = sequencer::type_id::create("seqr0", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of Agent", UVM_MEDIUM)

        drv0.seq_item_port.connect(seqr0.seq_item_export);
        mon0.in_port.connect(in_port);
        mon0.out_port.connect(out_port);
    endfunction
endclass