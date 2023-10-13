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
    for(genvar i = 0; i < $size(adder_testbench_constants_pkg::dut_list); i++)
    begin
        adder_interface intrf();
        case(i)
            0: CIAxbit DUT0(.sum(intrf.sum), .cout(intrf.cout), .a(intrf.a), .b(intrf.b), .cin(intrf.cin));
            1: CLAxbit DUT1(.A(intrf.a), .B(intrf.b), .cin(intrf.cin), .sum(intrf.sum), .cout(intrf.cout));
            2: CSelAxbit DUT2(.a(intrf.a), .b(intrf.b), .c(intrf.cin), .s(intrf.sum), .cout(intrf.cout));
            3: CSkAxbit DUT3(.sum(intrf.sum), .cout(intrf.cout), .a(intrf.a), .b(intrf.b), .cin(intrf.cin));
            4: RCAxbit DUT4(.sum(intrf.sum), .cout(intrf.cout), .a(intrf.a), .b(intrf.b), .cin(intrf.cin));
            5: MCCAxbit DUT5(.sum(intrf.sum), .cout(intrf.cout), .a(intrf.a), .b(intrf.b), .cin(intrf.cin));
        endcase
        initial uvm_config_db#(virtual adder_interface)::set(null,"*", $sformatf("Adder_Interface[%0d]", i), intrf);
    end
    /// Instintiation end ///
    
    initial
    begin
        static adder_test_config tst_cfg = adder_test_config::type_id::create("tst_cfg");
        uvm_config_db#(adder_test_config)::set(null,"*", "tst_cfg", tst_cfg);
        // $timeformat(-9, 2, " ns", 20);
        run_test("adder_test");
    end
endmodule
