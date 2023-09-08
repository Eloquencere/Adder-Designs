class adder_environment extends uvm_env;
    `uvm_component_utils(adder_environment)
    
    function new(string name = "adder_environment", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_agent agnt;
    adder_scoreboard scrbrd;
    
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
        
        agnt = adder_agent::type_id::create("agnt", this);
        scrbrd = adder_scoreboard::type_id::create("scrbrd", this);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
    endfunction
    
    function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started connect_phase", UVM_LOW)
        
        agnt.port_to_scoreboard.connect(scrbrd.port_from_agent);
        
        `uvm_info(get_type_name(), "Finished connect_phase", UVM_LOW)
    endfunction
endclass
