class test extends uvm_test;
    `uvm_component_utils(test)

    virtual memory_intf vif;
    env env0;
    my_sequence seq0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Build phase of Test", UVM_MEDIUM)

        if(!uvm_config_db#(virtual memory_intf)::get(this, "", "intf", vif))
            `uvm_fatal(get_type_name(), "failed to get intf")
        uvm_config_db#(virtual memory_intf)::set(this, "env0", "intf", vif);
        
        env0 = env::type_id::create("env0", this);
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Run phase of Test", UVM_MEDIUM)
        seq0 = my_sequence::type_id::create("seq0");
        phase.raise_objection(this);
        repeat(1000) begin
            seq0.start(env0.agent0.seqr0);
        end
        phase.drop_objection(this);
    endtask

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Start of Simulation phase of Test", UVM_MEDIUM)
        if (uvm_report_enabled(UVM_MEDIUM)) begin
            this.print();
            factory.print();
        end
    endfunction
endclass