class adder_environment_config extends uvm_object;
    `uvm_object_utils(adder_environment_config)
    
    function new(string name = "adder_environment_config");
        super.new(name);
    endfunction
    
    bit need_coverage;
endclass
