class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)
    
    function new(string name = "adder_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_test_config tst_cfg;
    adder_environment envrnmnt;
    adder_sequence sqnc[$];
    adder_environment_config env_cfg;
    int log_file;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_test_config)::get(null,"*", "tst_cfg", tst_cfg))
        else `uvm_fatal(get_type_name(), "Couldn't get test config")
        
        envrnmnt = adder_environment::type_id::create("envrnmnt", this);
        for(int i = 0; i < tst_cfg.no_of_sequences; i++)
        begin
            sqnc.push_back(adder_sequence::type_id::create($sformatf("sqnc[%0d]", i)));
            sqnc[i].total_packets = 10;
        end
        
        env_cfg = adder_environment_config::type_id::create("env_cfg");
        env_cfg.no_of_agents = tst_cfg.no_of_designs;
        uvm_config_db#(adder_environment_config)::set(null,"*", "env_cfg", env_cfg);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started end_of_elaboration_phase", UVM_FULL)
        
        uvm_top.print_topology();
        uvm_config_db#(int)::dump();
        
        `uvm_info(get_type_name(), "Finished end_of_elaboration_phase", UVM_FULL)
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started start_of_simulation_phase", UVM_FULL)
        
        log_file = $fopen("../../logs/Log_File.md", "w");
        assert(log_file);
        uvm_top.set_report_default_file_hier(log_file);
        uvm_top.set_report_severity_action_hier (UVM_INFO, UVM_DISPLAY+UVM_LOG);
        
        `uvm_info(get_type_name(), "Finished start_of_simulation_phase", UVM_FULL)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Started run_phase", UVM_MEDIUM)
        
        foreach(sqnc[i])
        fork
            int temp = i;
            sqnc[temp].start(envrnmnt.agnt[temp].sqncr);
        join_none
        wait fork;
        #3;
        
        if(tst_cfg.need_timing_diagram)
            $dumpfile("../../logs/Timing_Diagram.vcd"); $dumpvars;
        
        `uvm_info(get_type_name(), "Finished run_phase", UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
    
    virtual function void final_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started final_phase", UVM_FULL)
        
        $fclose(log_file);
        
        `uvm_info(get_type_name(), "Finished final_phase", UVM_FULL)
    endfunction
endclass
