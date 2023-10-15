class adder_environment extends uvm_env;
    `uvm_component_utils(adder_environment)
    
    function new(string name = "adder_environment", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_environment_config env_cfg;
    adder_virtual_sequencer vsqncr;
    adder_agent agnt[$];
    adder_scoreboard scrbrd;
    adder_coverage_collector cov_cllctr;
    adder_agent_config agnt_cfg;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_environment_config)::get(this, "envrnmnt", "env_cfg", env_cfg))
        else `uvm_fatal(get_type_name(), "Failed to get environment config")
        
        vsqncr = adder_virtual_sequencer::type_id::create("vsqncr", this);
        
        for(int i = 0; i < adder_testbench_constants_pkg::dut_list.size(); i++)
        begin
            agnt.push_back(adder_agent::type_id::create($sformatf("agnt[%0d]", i), this));
            agnt[i].agent_number = i;
        end
        scrbrd = adder_scoreboard::type_id::create("scrbrd", this);
        
        cov_cllctr = adder_coverage_collector::type_id::create("cov_cllctr", this);
        
        for(int i = 0; i < adder_testbench_constants_pkg::dut_list.size(); i++)
        begin
            agnt_cfg = adder_agent_config::type_id::create("agnt_cfg");
            assert(uvm_config_db#(virtual adder_interface)::get(this, "", $sformatf("Adder_Interface[%0d]", i), agnt_cfg.intrf))
            else `uvm_fatal(get_type_name(), "Failed to get a handle to the interface")
            uvm_config_db#(adder_agent_config)::set(this, $sformatf("agnt[%0d].*", i), "agnt_cfg", agnt_cfg);
        end
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started connect_phase", UVM_FULL)
        
        foreach(agnt[i])
            vsqncr.sqncr[i] = agnt[i].sqncr;
        
        foreach(agnt[i])
            agnt[i].port_to_scrbrd.connect(scrbrd.fifo_port_from_agnts.analysis_export);
        
        scrbrd.port_to_cov_cllctr.connect(cov_cllctr.analysis_export);
        
        `uvm_info(get_type_name(), "Finished connect_phase", UVM_FULL)
    endfunction
endclass
