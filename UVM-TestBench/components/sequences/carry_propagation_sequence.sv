class carry_propagation_sequence extends uvm_sequence;
    `uvm_object_utils(carry_propagation_sequence)
    
    function new(string name = "carry_propagation_sequence");
        super.new(name);
    endfunction
    
    adder_packet packet_to_sequencer;
    
    virtual task pre_body();
        packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
    endtask
    
    virtual task body();
        packet_to_sequencer.cin = 1;
        start_item(packet_to_sequencer);
        
        packet_to_sequencer.a = '1; packet_to_sequencer.b = 0;
        
        finish_item(packet_to_sequencer);
        start_item(packet_to_sequencer);
        
        packet_to_sequencer.a = 0; packet_to_sequencer.b = '1;
        
        finish_item(packet_to_sequencer);
    endtask
endclass
