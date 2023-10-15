class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)
    
    function new(string name = "adder_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_test_config tst_cfg;
    adder_virtual_sequence vsqnc;
    adder_environment envrnmnt;
    adder_environment_config env_cfg;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_test_config)::get(null,"*", "tst_cfg", tst_cfg))
        else `uvm_fatal(get_type_name(), "Couldn't get test config")
        
        vsqnc = adder_virtual_sequence::type_id::create("vsqnc");
        
        envrnmnt = adder_environment::type_id::create("envrnmnt", this);
        
        env_cfg = adder_environment_config::type_id::create("env_cfg");
        uvm_config_db#(adder_environment_config)::set(null,"*", "env_cfg", env_cfg);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started end_of_elaboration_phase", UVM_FULL)
        
        uvm_top.print_topology();
        uvm_config_db#(int)::dump();
        
        `uvm_info(get_type_name(), "Finished end_of_elaboration_phase", UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Started run_phase", UVM_MEDIUM)
        
        vsqnc.start(envrnmnt.vsqncr);
        #2;
        
        `uvm_info(get_type_name(), "Finished run_phase", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
endclass
