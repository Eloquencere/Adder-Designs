`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sriranga
// 
// Create Date: 07.09.2023 16:30:26
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;
import adder_testbench_pkg::*;

module top;
    /// Instintiation begin ///
    parameter int no_of_designs = 5;
    for(genvar i = 0; i < no_of_designs; i++)
    begin:intrf1
        adder_interface1 intrf();
        initial uvm_config_db#(virtual adder_interface1)::set(null,"*", $sformatf("Adder_Interface[%0d]", i), intrf);
    end:intrf1
    
    for(genvar i = 0; i < no_of_designs; i++)
        case(i)
            0: CIAxbit DUT0(.sum(intrf1[i].intrf.sum), .cout(intrf1[i].intrf.cout), .a(intrf1[i].intrf.a), .b(intrf1[i].intrf.b), .cin(intrf1[i].intrf.cin));
            1: CLAxbit DUT1(.A(intrf1[i].intrf.a), .B(intrf1[i].intrf.b), .cin(intrf1[i].intrf.cin), .sum(intrf1[i].intrf.sum), .cout(intrf1[i].intrf.cout));
            2: CSelAxbit DUT2(.a(intrf1[i].intrf.a), .b(intrf1[i].intrf.b), .c(intrf1[i].intrf.cin), .s(intrf1[i].intrf.sum), .cout(intrf1[i].intrf.cout));
            3: CSkAxbit DUT3(.sum(intrf1[i].intrf.sum), .cout(intrf1[i].intrf.cout), .a(intrf1[i].intrf.a), .b(intrf1[i].intrf.b), .cin(intrf1[i].intrf.cin));
            4: RCAxbit DUT4(.sum(intrf1[i].intrf.sum), .cout(intrf1[i].intrf.cout), .a(intrf1[i].intrf.a), .b(intrf1[i].intrf.b), .cin(intrf1[i].intrf.cin));
        endcase
    /// Instintiation end ///
    
    initial
    begin
        static adder_test_config tst_cfg = adder_test_config::type_id::create("tst_cfg");
        tst_cfg.no_of_designs = no_of_designs;
        tst_cfg.no_of_sequences = tst_cfg.no_of_designs;
        uvm_config_db#(adder_test_config)::set(null,"*", "tst_cfg", tst_cfg);
        run_test("adder_test");
    end
endmodule