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
    adjacent_values_sequence adjcnt_sqnc;
    random_no_constraint_sequence rand_sqnc;
    
    uvm_sequence test_case[$];
    
    virtual task pre_body();
        test_case.push_back(basic_operation_sequence::type_id::create("basic_sqnc"));
        test_case.push_back(single_bit_sequence::type_id::create("sngl_sqnc"));
        test_case.push_back(zero_propagation_sequence::type_id::create("zro_sqnc"));
        test_case.push_back(carry_propagation_sequence::type_id::create("crry_sqnc"));
        test_case.push_back(overflow_sequence::type_id::create("ovrfl_sqnc"));
        test_case.push_back(underflow_sequence::type_id::create("undrfl_sqnc"));
        test_case.push_back(adjacent_values_sequence::type_id::create("adjcnt_sqnc"));
        test_case.push_back(random_no_constraint_sequence::type_id::create("rand_sqnc"));
    endtask

    // seed no. = 2807422414
    
    virtual task body();
        foreach(test_case[i])
        begin
            $display("Started Sequence %0d", i);
            foreach(p_sequencer.sqncr[j])
            fork
                int temp = j;
                start_sequence(temp, test_case[i].clone());
            join_none
            wait fork;
            #2;
        end
    endtask
    
    task start_sequence(int sqncr_no, uvm_sequence sqnc);
        sqnc.start(p_sequencer.sqncr[sqncr_no]);
    endtask
endclass
