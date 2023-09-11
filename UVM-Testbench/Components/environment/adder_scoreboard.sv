class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    extern function new(string name = "adder_scoreboard", uvm_component parent);
    
    uvm_analysis_imp#(adder_packet, adder_scoreboard) port_from_agnt;
    adder_packet packets_received[$];
    int expected_sum;
    
    extern function void build_phase(uvm_phase phase);
    extern function void write(adder_packet packet_from_monitor);
    
    extern task run_phase(uvm_phase phase);
endclass


function adder_scoreboard::new(string name = "adder_scoreboard", uvm_component parent);
    super.new(name, parent);
endfunction

function void adder_scoreboard::build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
    
    port_from_agnt = new("port_from_agnt", this);
    
    `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
endfunction

function void adder_scoreboard::write(adder_packet packet_from_monitor);
    packets_received.push_back(packet_from_monitor);
endfunction

task adder_scoreboard::run_phase(uvm_phase phase);
    adder_packet packet_to_evaluate;
    repeat(5) // endofpackets class
    begin
        wait(packets_received.size());
        packet_to_evaluate = packets_received.pop_front();
        expected_sum = packet_to_evaluate.a + packet_to_evaluate.b + packet_to_evaluate.cin;
        if(expected_sum == packet_to_evaluate.sum)
            `uvm_info(get_type_name(), "DUT responded as expected", UVM_NONE)
        else
            `uvm_info(get_type_name(), $sformatf("Expected %s & received %s", expected_sum, packet_to_evaluate.sum), UVM_NONE)
    end
endtask