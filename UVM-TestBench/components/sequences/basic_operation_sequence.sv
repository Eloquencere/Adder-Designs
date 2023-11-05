class basic_operation_sequence extends uvm_sequence;
    `uvm_object_utils(basic_operation_sequence)
    
    function new(string name = "basic_operation_sequence");
        super.new(name);
    endfunction
    
    int total_packets = 10;
    
    adder_packet packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
    
    virtual task body();
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            // Creating a -> +ve & b -> +ve cases
            assert(packet_to_sequencer.randomize() with {a[15] == 0 && b[15] == 0;})
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            // Creating a -> +ve or -ve & b -> +ve or -ve cases
            assert(packet_to_sequencer.randomize() with {a[15] == 1 || b[15] == 1;})
            else `uvm_fatal(get_name(), "Unable to randomize") 
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
