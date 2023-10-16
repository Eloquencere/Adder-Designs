class adder_driver extends uvm_driver#(adder_packet);
    `uvm_component_utils(adder_driver)
    
    function new(string name = "adder_driver", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_agent_config agnt_cfg;
    adder_packet packet_from_sequencer;
    virtual adder_interface.drvr_modprt drvr_vintrf;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_agent_config)::get(this, "drvr", "agnt_cfg", agnt_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")
        
        assert(uvm_config_db#(virtual adder_interface)::get(this, "drvr", "Adder_Interface", drvr_vintrf))
        else `uvm_fatal(get_type_name(), "Failed to get a handle to the interface")
        
        `uvm_info(get_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started run_phase", UVM_MEDIUM)
        
        forever
        begin
            seq_item_port.get_next_item(packet_from_sequencer);
            
            drvr_vintrf.a = packet_from_sequencer.a;
            drvr_vintrf.b = packet_from_sequencer.b;
            drvr_vintrf.cin = packet_from_sequencer.cin;
            
            seq_item_port.item_done();
            
            ++agnt_cfg.drvr_trans_count;
            #2;
        end
        
        `uvm_info(get_name(), "Finished run_phase", UVM_MEDIUM)
    endtask
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started report_phase", UVM_MEDIUM)
        
        `uvm_info(get_full_name(), $sformatf("Packets driven = %0d", agnt_cfg.drvr_trans_count), UVM_LOW)
        
        `uvm_info(get_type_name(), "Finished report_phase", UVM_MEDIUM)
    endfunction
endclass
