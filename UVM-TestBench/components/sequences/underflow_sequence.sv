class underflow_sequence extends uvm_sequence;
    `uvm_object_utils(underflow_sequence)
    
    function new(string name = "underflow_sequence");
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
            
            assert(packet_to_sequencer.randomize() with {(a < 50 && a > -50) && (b < 50 && b > -50);}) // not working
            else `uvm_fatal(get_name(), "Unable to randomize")
            
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
