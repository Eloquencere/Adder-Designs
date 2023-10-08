class adder_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(adder_virtual_sequence)
    `uvm_declare_p_sequencer(adder_virtual_sequencer)
    
    function new(string name = "adder_virtual_sequence");
        super.new(name);
    endfunction
    
    basic_operation_sequence basic_sqnc;
    single_bit_sequence sngl_sqnc;
    zero_propagation_sequence zro_sqnc;
    carry_propagation_sequence crry_sqnc;
    overflow_sequence ovrfl_sqnc;
    underflow_sequence undrfl_sqnc;
    random_no_constraint_sequence rand_sqnc;
    
    // no of packets per sequence
    
    virtual task body();
        $display("Started Basic operation sequence");
        foreach(p_sequencer.sqncr[i])
        fork
            int temp = i;
            begin
                basic_sqnc = basic_operation_sequence::type_id::create("basic_sqnc");
                basic_sqnc.start(p_sequencer.sqncr[temp]);
            end
        join_none
        wait fork;
        #2;
        
        $display("Started Single bit sequence");
        foreach(p_sequencer.sqncr[i])
        fork
            int temp = i;
            begin
                sngl_sqnc = single_bit_sequence::type_id::create("sngl_sqnc");
                sngl_sqnc.start(p_sequencer.sqncr[temp]);
            end
        join_none
        wait fork;
        #2;
        
        // $display("Started Zero Propagation sequence");
        // foreach(p_sequencer.sqncr[i])
        // fork
        //     int temp = i;
        //     begin
        //         zro_sqnc = zero_propagation_sequence::type_id::create("zro_sqnc");
        //         zro_sqnc.start(p_sequencer.sqncr[temp]);
        //     end
        // join_none
        // wait fork;
        // #2;
        
        $display("Started Carry Propagation sequence");
        foreach(p_sequencer.sqncr[i])
        fork
            int temp = i;
            begin
                crry_sqnc = carry_propagation_sequence::type_id::create("crry_sqnc");
                crry_sqnc.start(p_sequencer.sqncr[temp]);
            end
        join_none
        wait fork;
        #2;
        
        // $display("Started overflow sequence");
        // foreach(p_sequencer.sqncr[i])
        // fork
        //     int temp = i;
        //     begin
        //         ovrfl_sqnc = overflow_sequence::type_id::create("ovrfl_sqnc");
        //         ovrfl_sqnc.start(p_sequencer.sqncr[temp]);
        //     end
        // join_none
        // wait fork;
        // #2;
        
        // $display("Started underflow sequence");
        // foreach(p_sequencer.sqncr[i])
        // fork
        //     int temp = i;
        //     begin
        //         undrfl_sqnc = underflow_sequence::type_id::create("undrfl_sqnc");
        //         undrfl_sqnc.start(p_sequencer.sqncr[temp]);
        //     end
        // join_none
        // wait fork;
        // #2;
        
        $display("Started Random sequence");
        foreach(p_sequencer.sqncr[i])
        fork
            int temp = i;
            begin
                rand_sqnc = random_no_constraint_sequence::type_id::create("rand_sqnc");
                rand_sqnc.start(p_sequencer.sqncr[temp]);
            end
        join_none
        wait fork;
        #2;
    endtask
endclass
