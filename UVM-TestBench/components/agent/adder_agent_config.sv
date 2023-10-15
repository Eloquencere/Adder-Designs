class adder_agent_config extends uvm_object;
    `uvm_object_utils(adder_agent_config)
    
    function new(string name = "adder_agent_config");
        super.new(name);
    endfunction
    
    int drvr_trans_count;
    int mntr_trans_count;
endclass
