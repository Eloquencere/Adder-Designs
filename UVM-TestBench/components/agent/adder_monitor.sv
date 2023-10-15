class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)
    
    function new(string name = "adder_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    int agent_number;
    adder_agent_config agnt_cfg;
    virtual adder_interface.mntr_modprt mntr_vintrf;
    adder_packet packet_from_design;
    uvm_analysis_port#(adder_packet) port_to_agnt;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_agent_config)::get(this, $sformatf("agnt[%0d].mntr", agent_number), "agnt_cfg", agnt_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")
        
        assert(uvm_config_db#(virtual adder_interface)::get(this, $sformatf("agnt[%0d].mntr", agent_number), "Adder_Interface", mntr_vintrf))
        else `uvm_fatal(get_type_name(), "Failed to get a handle to the interface")
        
        port_to_agnt = new("port_to_agnt", this);
        
        `uvm_info(get_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), "Started run_phase", UVM_MEDIUM)
        
        packet_from_design = adder_packet::type_id::create("packet_from_design");
        forever @(mntr_vintrf.a, mntr_vintrf.b, mntr_vintrf.cin, mntr_vintrf.sum, mntr_vintrf.cout)
        begin
            packet_from_design.a = mntr_vintrf.a;
            packet_from_design.b = mntr_vintrf.b;
            packet_from_design.cin = mntr_vintrf.cin;
            packet_from_design.sum = mntr_vintrf.sum;
            packet_from_design.cout = mntr_vintrf.cout;
            port_to_agnt.write(packet_from_design);
            ++agnt_cfg.mntr_trans_count;
            $display("a = %b, b = %b, cin = %b", packet_from_design.a, packet_from_design.b, packet_from_design.cin);
        end
        
        `uvm_info(get_name(), "Finished run_phase", UVM_MEDIUM)
    endtask
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started report_phase", UVM_MEDIUM)
        
        `uvm_info(get_full_name(), $sformatf("Packets received = %0d", agnt_cfg.mntr_trans_count), UVM_LOW)
        
        `uvm_info(get_type_name(), "Finished report_phase", UVM_MEDIUM)
    endfunction
endclass
