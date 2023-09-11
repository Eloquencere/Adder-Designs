class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)
    
    extern function new(string name = "adder_monitor", uvm_component parent);
    
    virtual adder_interface mntr_vintrf;
    adder_packet packet_from_design;
    uvm_analysis_port#(adder_packet) port_to_agnt;
    
    extern function void build_phase(uvm_phase phase);
    
    extern task run_phase(uvm_phase phase);
endclass


function adder_monitor::new(string name = "adder_monitor", uvm_component parent);
    super.new(name, parent);
endfunction

function void adder_monitor::build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
    
    assert(uvm_config_db#(virtual adder_interface)::get(null,"*", "Adder_Interface", mntr_vintrf));
    // else `uvm_fatal(get_type_name(), "Failed to get a handle to the interface")
    port_to_agnt = new("port_to_agnt", this);
    
    `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
endfunction

task adder_monitor::run_phase(uvm_phase phase);
    packet_from_design = adder_packet::type_id::create("packet_from_design");
    forever
    begin
        #2;
        packet_from_design.a = mntr_vintrf.a;
        packet_from_design.b = mntr_vintrf.b;
        packet_from_design.cin = mntr_vintrf.cin;
        packet_from_design.sum = mntr_vintrf.sum;
        port_to_agnt.write(packet_from_design);
    end
endtask