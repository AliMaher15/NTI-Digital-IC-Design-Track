class env extends uvm_env;
    `uvm_component_utils(env)

    virtual memory_intf vif;

    agent      agent0;
    scoreboard sb0;
    coverage   cvg0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of ENV", UVM_MEDIUM)

        if(!uvm_config_db#(virtual memory_intf)::get(this, "", "intf", vif))
            `uvm_fatal(get_type_name(), "failed to get intf")
        uvm_config_db#(virtual memory_intf)::set(this, "agent0", "intf", vif);
        
        agent0 = agent     ::type_id::create("agent0", this);
        sb0    = scoreboard::type_id::create("sb0"   , this);
        cvg0   = coverage  ::type_id::create("cvg0"  , this);

        agent0.vif = vif;
    endfunction

    function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of ENV", UVM_MEDIUM)

        agent0.in_port.connect(cvg0.analysis_export);

        agent0.in_port.connect(sb0.in_imp);
        agent0.out_port.connect(sb0.out_imp);
    endfunction
endclass