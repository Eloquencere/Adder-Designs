class single_bit_sequence extends uvm_sequence;
    `uvm_object_utils(single_bit_sequence)

    function new(string name = "single_bit_sequence");
        super.new(name);
    endfunction

    int total_packets = 10;

    adder_packet packet_to_sequencer = adder_packet::type_id::create("packet_to_sequencer");

    virtual task body();
        repeat(total_packets)
        begin
            start_item(packet_to_sequencer);

            // Any random bit in a and b can be set to 1
            assert(packet_to_sequencer.randomize() with {$onehot(a) && $onehot(b);})
            else `uvm_fatal(get_name(), "Unable to randomize")

            finish_item(packet_to_sequencer);
        end
    endtask
endclass
