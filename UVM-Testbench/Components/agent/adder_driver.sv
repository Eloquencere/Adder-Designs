class adder_driver extends uvm_driver#(adder_packet);
    `uvm_component_utils(adder_driver)
    
    extern function new(string name = "adder_driver", uvm_component parent);
    
    adder_packet packet_from_sequencer;
    virtual adder_interface drvr_vintrf;
    
    extern function void build_phase(uvm_phase phase);
    
    extern task run_phase(uvm_phase phase);
endclass


function adder_driver::new(string name = "adder_driver", uvm_component parent);
    super.new(name, parent);
endfunction

function void adder_driver::build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
    
    assert(uvm_config_db#(virtual adder_interface)::get(null,"*", "Adder_Interface", drvr_vintrf));
    // else begin `uvm_fatal(get_type_name(), "Failed to get a handle to the interface") end
    
    `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
endfunction

task adder_driver::run_phase(uvm_phase phase);
    forever 
    begin
        seq_item_port.get_next_item(packet_from_sequencer);
        drvr_vintrf.a = packet_from_sequencer.a;
        drvr_vintrf.b = packet_from_sequencer.b;
        drvr_vintrf.cin = packet_from_sequencer.cin; 
        seq_item_port.item_done();
        `uvm_info(get_type_name(), "Driver sent something", UVM_LOW)
        #2;
    end
endtask