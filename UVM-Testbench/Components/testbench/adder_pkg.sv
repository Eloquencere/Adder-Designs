package adder_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	`include "../sequence/adder_sequence_item.sv"
	`include "../sequence/adder_sequence.sv"
	`include "../agent/adder_driver.sv"
	`include "../agent/adder_monitor.sv"
	`include "../agent/adder_agent.sv"
	`include "../environment/adder_scoreboard.sv"
	`include "../environment/adder_environment.sv"
	`include "../testbench/adder_test.sv"
endpackage