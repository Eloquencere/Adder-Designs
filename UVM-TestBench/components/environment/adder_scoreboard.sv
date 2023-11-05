class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    function new(string name = "adder_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    int total_evaluated_packets, matched_packets;
    adder_packet packet_from_agnt;
    uvm_tlm_analysis_fifo #(adder_packet) fifo_port_from_agnts;
    int expected_sum;
    uvm_analysis_export #(adder_packet) port_to_cov_cllctr;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)
        
        fifo_port_from_agnts = new("fifo_port_from_agnts", this);
        port_to_cov_cllctr = new("port_to_cov_cllctr", this);
        
        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_MEDIUM)
        
        packet_from_agnt = adder_packet::type_id::create("packet_from_agnt");
        forever
        begin
            fifo_port_from_agnts.get(packet_from_agnt);
            
            // Golden reference model
            expected_sum = packet_from_agnt.a + packet_from_agnt.b + packet_from_agnt.cin;
            
            // Printing the expected and obtained sum
            // `uvm_info(get_type_name(), $sformatf("Expected sum = 'h%x, obtained sum = 'h%x", expected_sum, {packet_from_agnt.cout, packet_from_agnt.sum}), UVM_NONE)
            if(expected_sum == {packet_from_agnt.cout, packet_from_agnt.sum})
            begin
                `uvm_info(get_type_name(), $sformatf("%s responded as expected", packet_from_agnt.dut_name), UVM_LOW)
                port_to_cov_cllctr.write(packet_from_agnt);
                ++matched_packets;
            end
            else
                `uvm_info
                (
                    get_type_name(), $sformatf("%s %s to respond as expected", packet_from_agnt.dut_name, adder_colours_pkg::colourise(adder_colours_pkg::RED, "failed")), UVM_LOW
                )
            ++total_evaluated_packets;
        end
        
        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_MEDIUM)
    endtask
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_LOW)
        
        `uvm_info(get_full_name(), $sformatf("Packets evaluated = %0d", total_evaluated_packets), UVM_LOW)
        `uvm_info(get_full_name(), $sformatf("Packets Mismatched = %0d", total_evaluated_packets - matched_packets), UVM_LOW)
        
        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_LOW)
    endfunction
endclass
