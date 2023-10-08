class overflow_sequence extends uvm_sequence;
    `uvm_object_utils(overflow_sequence)
    
    function new(string name = "overflow_sequence");
        super.new(name);
    endfunction
    
    int total_packets = 10;
    adder_packet packet_to_sequencer;
    
    task pre_body();
        packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
    endtask
    
    task body();
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            assert(packet_to_sequencer.randomize() with {((~a + 1) > 200) && ((~b + 1) > 200);}) // not working
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            assert(packet_to_sequencer.randomize() with {((~a + 1) < -200) && ((~b + 1) < -200);}) // not working
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
