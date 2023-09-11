class adder_agent extends uvm_agent;
    `uvm_component_utils(adder_agent)
    
    extern function new(string name = "adder_agent", uvm_component parent);
    
    uvm_sequencer#(adder_packet) sqncr;
    adder_driver drvr;
    adder_monitor mntr;
    uvm_analysis_port#(adder_packet) port_to_scrbrd;
    
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass


function adder_agent::new(string name = "adder_agent", uvm_component parent);
    super.new(name, parent);
endfunction

function void adder_agent::build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
    
    sqncr = uvm_sequencer#(adder_packet)::type_id::create("sqncr", this);
    drvr = adder_driver::type_id::create("drvr", this);
    mntr = adder_monitor::type_id::create("mntr", this);
    port_to_scrbrd = new("port_to_scrbrd", this);
    
    `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
endfunction

function void adder_agent::connect_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started connect_phase", UVM_LOW)
    
    drvr.seq_item_port.connect(sqncr.seq_item_export);
    this.port_to_scrbrd = mntr.port_to_agnt;
    
    `uvm_info(get_type_name(), "Started finished_phase", UVM_LOW)
endfunction