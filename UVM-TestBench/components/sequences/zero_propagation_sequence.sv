class zero_propagation_sequence extends uvm_sequence;
    `uvm_object_utils(zero_propagation_sequence)
    
    function new(string name = "zero_propagation_sequence");
        super.new(name);
    endfunction
    
    int total_packets = 9;
    adder_packet packet_to_sequencer;
    
    task pre_body();
        packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
    endtask
    
    task body();
        begin
            start_item(packet_to_sequencer);
            
            packet_to_sequencer.a = '0; packet_to_sequencer.b = '0; packet_to_sequencer.cin = 0;
            
            finish_item(packet_to_sequencer);
        end
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            assert(packet_to_sequencer.randomize() with {(a == 0) ^ (b == 0); /* b is constantly 0 */})
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
