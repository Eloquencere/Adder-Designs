class adder_agent extends uvm_agent;
    `uvm_component_utils(adder_agent)
    
    function new(string name = "adder_agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    int agent_number;
    adder_agent_config agnt_cfg;
    uvm_sequencer#(adder_packet) sqncr;
    adder_driver drvr;
    adder_monitor mntr;
    uvm_analysis_imp #(adder_packet, adder_agent) port_from_mntr;
    uvm_analysis_port #(adder_packet) port_to_scrbrd;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_agent_config)::get(null, "*", $sformatf("agnt_cfg[%0d]", agent_number), agnt_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")
        
        sqncr = uvm_sequencer#(adder_packet)::type_id::create("sqncr", this);
        drvr = adder_driver::type_id::create("drvr", this); drvr.agent_number = agent_number;
        mntr = adder_monitor::type_id::create("mntr", this); mntr.agent_number = agent_number;
        port_from_mntr = new("port_from_mntr", this);
        port_to_scrbrd = new("port_to_scrbrd", this);
        
        `uvm_info(get_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started connect_phase", UVM_FULL)
        
        drvr.seq_item_port.connect(sqncr.seq_item_export);
        mntr.port_to_agnt.connect(port_from_mntr);
        
        `uvm_info(get_name(), "Finished connect_phase", UVM_FULL)
    endfunction
    
    function void write(adder_packet packet_from_mntr);	
        packet_from_mntr.dut_name = $sformatf("%s", adder_testbench_constants_pkg::dut_list[agent_number]);
        port_to_scrbrd.write(packet_from_mntr);
        // packet_from_mntr.print()
    endfunction
endclass
