class adder_sequence extends uvm_sequence;
    `uvm_object_utils(adder_sequence)
    
    function new(string name = "adder_sequence");
        super.new(name);
    endfunction
    
    int total_packets;
    adder_packet packet_to_sequencer;
    
    task body();        
        packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
        repeat(total_packets)
        begin    
            start_item(packet_to_sequencer);
            
            assert(packet_to_sequencer.randomize())
            else `uvm_fatal(get_name(), "Unable to randomize") //change this to error when adding other test cases
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass