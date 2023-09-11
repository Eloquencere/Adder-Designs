class adder_environment extends uvm_env;
    `uvm_component_utils(adder_environment)
    
    extern function new(string name = "adder_environment", uvm_component parent);
    
    adder_agent agnt;
    adder_scoreboard scrbrd;
    
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass


function adder_environment::new(string name = "adder_environment", uvm_component parent);
    super.new(name, parent);
endfunction

function void adder_environment::build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
    
    agnt = adder_agent::type_id::create("agnt", this);
    scrbrd = adder_scoreboard::type_id::create("scrbrd", this);
    
    `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
endfunction

function void adder_environment::connect_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started connect_phase", UVM_LOW)
    
    agnt.port_to_scrbrd.connect(scrbrd.port_from_agnt);
    
    `uvm_info(get_type_name(), "Finished connect_phase", UVM_LOW)
endfunction
