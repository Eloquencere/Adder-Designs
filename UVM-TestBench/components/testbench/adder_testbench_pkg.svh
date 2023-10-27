package adder_testbench_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	import adder_sequences_pkg::*;
	`include "../agent/adder_agent_config.sv"
	`include "../agent/adder_driver.sv"
	`include "../agent/adder_monitor.sv"
	`include "../agent/adder_agent.sv"
	`include "../environment/adder_environment_config.sv"
	`include "../environment/adder_virtual_sequencer.sv"
	`include "../environment/adder_scoreboard.sv"
	`include "../environment/adder_coverage_collector.sv"
	`include "../environment/adder_environment.sv"
	`include "../report_server/adder_report_server.sv"
	`include "../testbench/adder_test_config.sv"
	`include "../sequences/adder_virtual_sequence.sv"
	`include "../testbench/adder_test.sv"
endpackage
