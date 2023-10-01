class adder_agent1_config extends uvm_object;
    `uvm_object_utils(adder_agent1_config)
    
    function new(string name = "adder_agent1_config");
        super.new(name);
    endfunction
    
    virtual adder_interface1 intrf;
    
    int drvr_trans_count = 0;
    int mntr_trans_count = 0;
endclass
