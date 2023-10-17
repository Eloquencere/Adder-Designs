class adder_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(adder_virtual_sequence)
    `uvm_declare_p_sequencer(adder_virtual_sequencer)
    
    function new(string name = "adder_virtual_sequence");
        super.new(name);
    endfunction
    
    uvm_sequence test_case[$];
    
    basic_operation_sequence basic_sqnc = basic_operation_sequence::type_id::create("basic_sqnc");
    single_bit_sequence sngl_sqnc = single_bit_sequence::type_id::create("sngl_sqnc");
    zero_propagation_sequence zro_sqnc = zero_propagation_sequence::type_id::create("zro_sqnc");
    carry_propagation_sequence crry_sqnc = carry_propagation_sequence::type_id::create("crry_sqnc");
    overflow_sequence ovrfl_sqnc = overflow_sequence::type_id::create("ovrfl_sqnc");
    underflow_sequence undrfl_sqnc = underflow_sequence::type_id::create("undrfl_sqnc");
    adjacent_values_sequence adjcnt_sqnc = adjacent_values_sequence::type_id::create("adjcnt_sqnc");
    random_no_constraint_sequence rand_sqnc = random_no_constraint_sequence::type_id::create("rand_sqnc");
    
    virtual task pre_body();
        test_case.push_back(basic_sqnc);
        test_case.push_back(sngl_sqnc);
        test_case.push_back(zro_sqnc);
        test_case.push_back(crry_sqnc);
        test_case.push_back(ovrfl_sqnc);
        test_case.push_back(undrfl_sqnc);
        test_case.push_back(adjcnt_sqnc);
        test_case.push_back(rand_sqnc);
    endtask
    
    virtual task body();
        foreach(test_case[i])
        begin
            $display("Started %s", test_case[i].get_type_name());
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
