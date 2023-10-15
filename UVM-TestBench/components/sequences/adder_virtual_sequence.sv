class adder_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(adder_virtual_sequence)
    `uvm_declare_p_sequencer(adder_virtual_sequencer)
    
    function new(string name = "adder_virtual_sequence");
        super.new(name);
    endfunction
    
    typedef uvm_sequence sequences[$];
    sequences test_case[string];
    
    basic_operation_sequence basic_sqnc;
    single_bit_sequence sngl_sqnc;
    zero_propagation_sequence zro_sqnc;
    carry_propagation_sequence crry_sqnc;
    overflow_sequence ovrfl_sqnc;
    underflow_sequence undrfl_sqnc;
    adjacent_values_sequence adjcnt_sqnc;
    random_no_constraint_sequence rand_sqnc;
    
    virtual task pre_body();
        foreach(p_sequencer.sqncr[j])
        begin
            test_case["basic_sqnc"].push_back(basic_operation_sequence::type_id::create($sformatf("basic_sqnc[%0d]", j)));
            test_case["sngl_sqnc"].push_back(single_bit_sequence::type_id::create($sformatf("sngl_sqnc[%0d]", j)));
            test_case["zro_sqnc"].push_back(zero_propagation_sequence::type_id::create($sformatf("zro_sqnc[%0d]", j)));
            test_case["crry_sqnc"].push_back(carry_propagation_sequence::type_id::create($sformatf("crry_sqnc[%0d]", j)));
            test_case["ovrfl_sqnc"].push_back(overflow_sequence::type_id::create($sformatf("ovrfl_sqnc[%0d]", j)));
            test_case["undrfl_sqnc"].push_back(underflow_sequence::type_id::create($sformatf("undrfl_sqnc[%0d]", j)));
            test_case["adjcnt_sqnc"].push_back(adjacent_values_sequence::type_id::create($sformatf("adjcnt_sqnc[%0d]", j)));
            test_case["rand_sqnc"].push_back(random_no_constraint_sequence::type_id::create($sformatf("rand_sqnc[%0d]", j)));
        end
    endtask
    
    virtual task body();
        foreach(test_case[i])
        begin
            $display("Started %s", test_case[i][0].get_type_name());
            foreach(p_sequencer.sqncr[j])
            fork
                int temp = j;
                test_case[i][temp].start(p_sequencer.sqncr[temp]);
            join_none
            wait fork;
            #2;
        end
    endtask
endclass
