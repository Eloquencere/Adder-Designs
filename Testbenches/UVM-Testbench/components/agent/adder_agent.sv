class adder_agent extends uvm_agent;
    `uvm_component_utils(adder_agent)

    function new(string name = "adder_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    adder_agent_config agnt_cfg;
    uvm_sequencer#(adder_packet) sqncr;
    adder_driver drvr;
    adder_monitor mntr;
    uvm_analysis_imp #(adder_packet, adder_agent) port_from_mntr;
    uvm_analysis_port #(adder_packet) port_to_scrbrd;

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)

        assert(uvm_config_db#(adder_agent_config)::get(this, "agnt", "agnt_cfg", agnt_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")

        sqncr = uvm_sequencer#(adder_packet)::type_id::create("sqncr", this);
        drvr = adder_driver::type_id::create("drvr", this); 
        mntr = adder_monitor::type_id::create("mntr", this);
        port_from_mntr = new("port_from_mntr", this);
        port_to_scrbrd = new("port_to_scrbrd", this);

        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)

        drvr.seq_item_port.connect(sqncr.seq_item_export);
        mntr.port_to_agnt.connect(port_from_mntr);

        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction

    function void write(adder_packet packet_from_mntr);

        // Agent tagging packet to scoreboard with it's associated DUT name
        packet_from_mntr.dut_name = agnt_cfg.dut_name;
        port_to_scrbrd.write(packet_from_mntr);

        // Printing packet from monitor
        // packet_from_mntr.print();
    endfunction
endclass
