class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    function new(string name = "adder_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    uvm_analysis_imp#(adder_packet, adder_scoreboard) port_from_agent;
    
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
        
        port_from_agent = new("port_from_agent", this);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
    endfunction
    
    function void write(adder_packet packet_from_monitor);
        packet_from_monitor.print();
    endfunction
endclass
