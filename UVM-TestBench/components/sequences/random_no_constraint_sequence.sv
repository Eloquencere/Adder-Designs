class random_no_constraint_sequence extends uvm_sequence;
    `uvm_object_utils(random_no_constraint_sequence)
    
    function new(string name = "random_no_constraint_sequence");
        super.new(name);
    endfunction
    
    int total_packets = 10;
    adder_packet packet_to_sequencer;
    
    virtual task pre_body();
        packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
        packet_to_sequencer.constraint_mode(0); // disable constraints
    endtask
    
    virtual task body();
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);
            
            assert(packet_to_sequencer.randomize())
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
