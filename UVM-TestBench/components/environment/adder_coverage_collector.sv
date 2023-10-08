class adder_coverage_collector extends uvm_subscriber#(adder_packet);
    `uvm_component_utils(adder_coverage_collector)
    
    adder_packet packet_from_scrbrd;
    
    covergroup set;
        coverpoint packet_from_scrbrd.a
        {
            bins positive = {[0:$]};
            bins negative = {[$:0]};
            bins zeros = {'0};
        }
        coverpoint packet_from_scrbrd.b
        {
            bins positive = {[0:$]};
            bins negative = {[$:0]};
            bins zeros = {'0};
        }
        coverpoint packet_from_scrbrd.cin{}
        coverpoint packet_from_scrbrd.sum
        {
            bins positive = {[0:$]};
            bins negative = {[$:0]};
            bins zeros = {'0};
        }
        coverpoint packet_from_scrbrd.cout{}
    endgroup
    
    function new(string name = "adder_coverage_collector", uvm_component parent);
        super.new(name, parent);
        set = new();
    endfunction
    
    adder_environment_config env_cfg;
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        assert(uvm_config_db#(adder_environment_config)::get(null,"*", "env_cfg", env_cfg))
        else `uvm_fatal(get_type_name(), "Failed to get environment config")
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
    
    virtual function void write(adder_packet t);
        packet_from_scrbrd = t;
        if(env_cfg.need_coverage)
            set.sample();
    endfunction
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started report_phase", UVM_HIGH)
        
        if(env_cfg.need_coverage)
            `uvm_info(get_type_name(), $sformatf("Instance Coverage = %f", this.set.get_inst_coverage()), UVM_NONE)
        
        `uvm_info(get_type_name(), "Finished report_phase", UVM_HIGH)
    endfunction
endclass
