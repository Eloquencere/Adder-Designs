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
    
    string agnt_dut_association[string];
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        fifo_port_from_agnts = new("fifo_port_from_agnts", this);
        port_to_cov_cllctr = new("port_to_cov_cllctr", this);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started run_phase", UVM_MEDIUM)
        
        packet_from_agnt = adder_packet::type_id::create("packet_from_agnt");
        forever
        begin
            fifo_port_from_agnts.get(packet_from_agnt);
            expected_sum = packet_from_agnt.a + packet_from_agnt.b + packet_from_agnt.cin;
            `uvm_info(get_type_name(), $sformatf("Expected sum = 'h%x, obtained sum = 'h%x", expected_sum, {packet_from_agnt.cout, packet_from_agnt.sum}), UVM_NONE)
            if(expected_sum == {packet_from_agnt.cout, packet_from_agnt.sum})
            begin
                `uvm_info(get_type_name(), $sformatf("%s responded as expected", agnt_dut_association[packet_from_agnt.agent]), UVM_LOW)
                port_to_cov_cllctr.write(packet_from_agnt);
                ++matched_packets;
            end
            else
                `uvm_info(get_type_name(), $sformatf("%s didn't respond as expected", agnt_dut_association[packet_from_agnt.agent]), UVM_LOW)
            ++total_evaluated_packets;
        end
        
        `uvm_info(get_type_name(), "Finished run_phase", UVM_MEDIUM)
    endtask
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started report_phase", UVM_NONE)
        
        `uvm_info(get_full_name(), $sformatf("Packets evaluated = %0d", total_evaluated_packets), UVM_LOW)
        `uvm_info(get_full_name(), $sformatf("Packets Mismatched = %0d", total_evaluated_packets - matched_packets), UVM_LOW)
        
        `uvm_info(get_type_name(), "Finished report_phase", UVM_NONE)
    endfunction
endclass
