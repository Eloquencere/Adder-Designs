class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)

    adder_report_server srvr;

    function new(string name = "adder_test", uvm_component parent);
        super.new(name, parent);
        srvr = new();
        // Assign custom report server to global report server
        uvm_report_server::set_server(srvr);
    endfunction

    adder_test_config tst_cfg;
    adder_virtual_sequence vsqnc;
    adder_environment envrnmnt;
    adder_environment_config env_cfg;

    // UVM phase to build environment component & create virtual sequence
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)

        assert(uvm_config_db#(adder_test_config)::get(this, "", "tst_cfg", tst_cfg))
        else `uvm_fatal(get_type_name(), "Couldn't get test config")

        vsqnc = adder_virtual_sequence::type_id::create("vsqnc");

        envrnmnt = adder_environment::type_id::create("envrnmnt", this);

        env_cfg = adder_environment_config::type_id::create("env_cfg");
        env_cfg.enable_functional_coverage = 0;
        uvm_config_db#(adder_environment_config)::set(this, "envrnmnt.*", "env_cfg", env_cfg);

        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction

    // UVM phase to print the testbench configurations
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)

        uvm_top.print_topology();
        uvm_config_db#(int)::dump();

        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction

    // UVM phase to start the test
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_type_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_MEDIUM)

        vsqnc.start(envrnmnt.vsqncr);
        #2;

        `uvm_info(get_type_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
endclass
