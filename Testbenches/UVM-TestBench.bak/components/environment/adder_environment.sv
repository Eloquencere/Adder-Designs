class adder_environment extends uvm_env;
    `uvm_component_utils(adder_environment)
    
    function new(string name = "adder_environment", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_environment_config env_cfg;
    adder_virtual_sequencer vsqncr;
    adder_agent agnt[$]; // Queue, for dynamic creation of an array of agents
    adder_agent_config agnt_cfg;
    adder_scoreboard scrbrd;
    adder_coverage_collector cov_cllctr;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)
        
        assert(uvm_config_db#(adder_environment_config)::get(this, "envrnmnt", "env_cfg", env_cfg))
        else `uvm_fatal(get_type_name(), "Failed to get environment config")
        
        vsqncr = adder_virtual_sequencer::type_id::create("vsqncr", this);
        
        // Dynamic creation of agents & assignment of DUT name to agent config
        foreach(adder_testbench_constants_pkg::dut_list[i])
        begin
            agnt.push_back(adder_agent::type_id::create($sformatf("agnt[%0d]", i), this));
            agnt_cfg = adder_agent_config::type_id::create("agnt_cfg");
            agnt_cfg.dut_name = adder_testbench_constants_pkg::dut_list[i];
            uvm_config_db#(adder_agent_config)::set(this, $sformatf("agnt[%0d].*", i), "agnt_cfg", agnt_cfg);
        end
        
        scrbrd = adder_scoreboard::type_id::create("scrbrd", this);
        cov_cllctr = adder_coverage_collector::type_id::create("cov_cllctr", this);
        
        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)
        
        
        foreach(agnt[i])
        begin
            // Connecting the handle of the virtual sequencer to the agent's sequencer
            vsqncr.sqncr[i] = agnt[i].sqncr;
            
            agnt[i].port_to_scrbrd.connect(scrbrd.fifo_port_from_agnts.analysis_export);
        end
        
        scrbrd.port_to_cov_cllctr.connect(cov_cllctr.analysis_export);
        
        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction
endclass
