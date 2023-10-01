class adder_test_config extends uvm_object;
    `uvm_object_utils(adder_test_config)
    
    function new(string name = "adder_test_config");
        super.new(name);
    endfunction
    
    // passed down the hierarchy
    int no_of_designs;
    
    // not passed down the hierarchy
    bit need_timing_diagram = 1;
    int no_of_sequences;
endclass