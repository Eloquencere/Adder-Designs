package adder_testbench_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	`include "../sequence/adder_sequence_item1.sv"
	`include "../sequence/adder_sequence.sv"
	`include "../agent/adder_agent1_config.sv"
	`include "../agent/adder_driver1.sv"
	`include "../agent/adder_monitor1.sv"
	`include "../agent/adder_agent1.sv"
	`include "../environment/adder_scoreboard.sv"
	`include "../environment/adder_coverage_collector.sv"
	`include "../environment/adder_environment_config.sv"
	`include "../environment/adder_environment.sv"
	`include "../testbench/adder_test_config.sv"
	`include "../testbench/adder_test.sv"
endpackage
