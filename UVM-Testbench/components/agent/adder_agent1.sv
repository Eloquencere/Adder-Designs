class adder_agent1 extends uvm_agent;
    `uvm_component_utils(adder_agent1)
    
    function new(string name = "adder_agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    int agent_number;
    adder_agent1_config agnt1_cfg;
    uvm_sequencer#(adder_packet) sqncr;
    adder_driver1 drvr;
    adder_monitor1 mntr;
    uvm_analysis_imp #(adder_packet, adder_agent1) port_from_mntr;
    uvm_analysis_port #(adder_packet) port_to_scrbrd;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_agent1_config)::get(null, "*", $sformatf("agnt1_cfg[%0d]", agent_number), agnt1_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")
        
        sqncr = uvm_sequencer#(adder_packet)::type_id::create("sqncr", this);
        drvr = adder_driver1::type_id::create("drvr", this); drvr.agent_number = agent_number;
        mntr = adder_monitor1::type_id::create("mntr", this); mntr.agent_number = agent_number;
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
        packet_from_mntr.agent = $sformatf("DUT%0d", agent_number);
        port_to_scrbrd.write(packet_from_mntr);
    endfunction
endclass
