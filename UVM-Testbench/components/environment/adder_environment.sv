class adder_environment extends uvm_env;
    `uvm_component_utils(adder_environment)
    
    function new(string name = "adder_environment", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    adder_environment_config env_cfg;
    adder_agent1 agnt[$];
    adder_scoreboard scrbrd;
    adder_coverage_collector cov_cllctr;
    adder_agent1_config agnt1_cfg;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_environment_config)::get(null,"*", "env_cfg", env_cfg))
        else `uvm_fatal(get_type_name(), "Failed to get environment config")
        
        for(int i = 0; i < env_cfg.no_of_agents; i++)
        begin
            agnt.push_back(adder_agent1::type_id::create($sformatf("agnt[%0d]", i), this));
            agnt[i].agent_number = i;
        end
        scrbrd = adder_scoreboard::type_id::create("scrbrd", this);
        cov_cllctr = adder_coverage_collector::type_id::create("cov_cllctr", this);
        
        for(int i = 0; i < env_cfg.no_of_agents; i++)
        begin
            agnt1_cfg = adder_agent1_config::type_id::create($sformatf("agnt1_cfg[%0d]", i));
            assert(uvm_config_db#(virtual adder_interface1)::get(null,"*", $sformatf("Adder_Interface[%0d]", i), agnt1_cfg.intrf))
            else `uvm_fatal(get_type_name(), "Failed to get a handle to the interface")
            uvm_config_db#(adder_agent1_config)::set(null,"*", $sformatf("agnt1_cfg[%0d]", i), agnt1_cfg);
        end
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started connect_phase", UVM_FULL)
        
        foreach(agnt[i])
            agnt[i].port_to_scrbrd.connect(scrbrd.fifo_port_from_agnts.analysis_export);
        scrbrd.port_to_cov_cllctr.connect(cov_cllctr.analysis_export);
        
        `uvm_info(get_type_name(), "Finished connect_phase", UVM_FULL)
    endfunction
    
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        scrbrd.agnt_dut_association["DUT0"] = "CIAxbit";
        scrbrd.agnt_dut_association["DUT1"] = "CLAxbit";
        scrbrd.agnt_dut_association["DUT2"] = "CSelAxbit";
        scrbrd.agnt_dut_association["DUT3"] = "CSkAxbit";
        scrbrd.agnt_dut_association["DUT4"] = "RCAxbit";
    endfunction
endclass
