class underflow_sequence extends uvm_sequence;
    `uvm_object_utils(underflow_sequence)
    
    function new(string name = "underflow_sequence");
        super.new(name);
    endfunction
    
    int total_packets = 10;
    int threshold = 50;
    
    adder_packet packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
    
    virtual task body();
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            // Creating numbers close to the smallest representable values
            assert(packet_to_sequencer.randomize() with {(a < threshold) && (b < threshold);})
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
