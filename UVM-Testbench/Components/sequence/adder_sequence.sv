class adder_sequence extends uvm_sequence;
    `uvm_object_utils(adder_sequence)
    
    function new(string name = "adder_sequence");
        super.new(name);
    endfunction
    
    adder_packet packet_to_sequencer;
    
    task body();
        repeat(5)
        begin
            packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");
            
            start_item(packet_to_sequencer);
            packet_to_sequencer.randomize();
            finish_item(packet_to_sequencer);
        end
    endtask
endclass
