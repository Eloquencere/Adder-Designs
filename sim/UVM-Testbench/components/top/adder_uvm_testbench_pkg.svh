package adder_uvm_testbench_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import adder_sequences_pkg::*;

    //agent
    `include "adder_agent_config.sv"
    `include "adder_driver.sv"
    `include "adder_monitor.sv"
    `include "adder_agent.sv"

    // environment
    `include "adder_environment_config.sv"
    `include "adder_virtual_sequencer.sv"
    `include "adder_scoreboard.sv"
    `include "adder_coverage_collector.sv"
    `include "adder_environment.sv"

    `include "adder_virtual_sequence.sv"
    `include "adder_report_server.sv"

    // test
    `include "adder_test_config.sv"
    `include "adder_test.sv"
endpackage
