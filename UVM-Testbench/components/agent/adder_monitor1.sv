class adder_monitor1 extends uvm_monitor;
    `uvm_component_utils(adder_monitor1)
    
    function new(string name = "adder_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    int agent_number;
    adder_agent1_config agnt1_cfg;
    virtual adder_interface1.mntr_modprt mntr_vintrf;
    adder_packet packet_from_design;
    uvm_analysis_port#(adder_packet) port_to_agnt;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_agent1_config)::get(null, "*", $sformatf("agnt1_cfg[%0d]", agent_number), agnt1_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")
        
        port_to_agnt = new("port_to_agnt", this);
        
        `uvm_info(get_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started connect_phase", UVM_FULL)
        
        mntr_vintrf = agnt1_cfg.intrf;
        
        `uvm_info(get_name(), "Finished connect_phase", UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started run_phase", UVM_MEDIUM)
        
        packet_from_design = adder_packet::type_id::create("packet_from_design");
        forever
        begin
            @(mntr_vintrf.a, mntr_vintrf.b, mntr_vintrf.cin, mntr_vintrf.sum, mntr_vintrf.cout);
            packet_from_design.a = mntr_vintrf.a;
            packet_from_design.b = mntr_vintrf.b;
            packet_from_design.cin = mntr_vintrf.cin;
            packet_from_design.sum = mntr_vintrf.sum;
            packet_from_design.cout = mntr_vintrf.cout;
            port_to_agnt.write(packet_from_design);
            ++agnt1_cfg.mntr_trans_count;
        end
        
        `uvm_info(get_name(), "Finished run_phase", UVM_MEDIUM)
    endtask
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started report_phase", UVM_NONE)
        
        `uvm_info(get_full_name(), $sformatf("Packets received = %0d", agnt1_cfg.mntr_trans_count), UVM_LOW)
        
        `uvm_info(get_type_name(), "Finished report_phase", UVM_NONE)
    endfunction
endclass
