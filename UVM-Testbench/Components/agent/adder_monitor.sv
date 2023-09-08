class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)
    
    function new(string name = "adder_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual adder_interface mntr_vintrf;
    adder_packet packet_from_design;
    uvm_analysis_port#(adder_packet) port_to_agent;
    
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
        
        assert(uvm_config_db#(virtual adder_interface)::get(null,"*", "Adder_Interface", mntr_vintrf));
        
        port_to_agent = new("port_to_agent", this);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
    endfunction
    
    task run_phase(uvm_phase phase);
        packet_from_design = adder_packet::type_id::create("packet_from_design");
        forever
        begin
            #2;
            packet_from_design.a = mntr_vintrf.a;
            packet_from_design.b = mntr_vintrf.b;
            packet_from_design.cin = mntr_vintrf.cin;
            packet_from_design.sum = mntr_vintrf.sum;
            `uvm_info(get_type_name(), "Received something", UVM_LOW)
            port_to_agent.write(packet_from_design);
        end
    endtask
endclass