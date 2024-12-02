class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)

    function new(string name = "adder_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    adder_agent_config agnt_cfg;
    virtual adder_interface mntr_vintrf;
    adder_packet packet_from_design;
    uvm_analysis_port#(adder_packet) port_to_agnt;

    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)

        assert(uvm_config_db#(adder_agent_config)::get(this, "mntr", "agnt_cfg", agnt_cfg))
        else `uvm_fatal(get_name(), "Failed to get agent config")

        port_to_agnt = new("port_to_agnt", this);

        `uvm_info(get_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)

        assert(uvm_config_db#(virtual adder_interface)::get(this, "mntr", $sformatf("%s_Interface", agnt_cfg.dut_name), mntr_vintrf))
        else `uvm_fatal(get_name(), "Failed to get a handle to the interface")

        `uvm_info(get_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_MEDIUM)

        packet_from_design = adder_packet::type_id::create("packet_from_design");
        forever @(mntr_vintrf.a or mntr_vintrf.b or mntr_vintrf.cin or mntr_vintrf.sum or mntr_vintrf.cout)
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

        `uvm_info(get_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_MEDIUM)
    endtask

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_MEDIUM)

        `uvm_info(get_full_name(), $sformatf("Packets received = %0d", agnt_cfg.mntr_trans_count), UVM_LOW)

        `uvm_info(get_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_MEDIUM)
    endfunction
endclass
