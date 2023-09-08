class adder_agent extends uvm_agent;
    `uvm_component_utils(adder_agent)
    
    function new(string name = "adder_agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_driver drvr;
    adder_monitor mntr;
    uvm_sequencer#(adder_packet) sqncr;
    uvm_analysis_port#(adder_packet) port_to_scoreboard;
    
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
        
        drvr = adder_driver::type_id::create("drvr", this);
        mntr = adder_monitor::type_id::create("mntr", this);
        sqncr = uvm_sequencer#(adder_packet)::type_id::create("sqncr", this);
        port_to_scoreboard = new("port_to_scoreboard", this);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
    endfunction
    
    function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started connect_phase", UVM_LOW)
        
        drvr.seq_item_port.connect(sqncr.seq_item_export);
        this.port_to_scoreboard = mntr.port_to_agent;
        
        `uvm_info(get_type_name(), "Started finished_phase", UVM_LOW)
    endfunction
endclass
