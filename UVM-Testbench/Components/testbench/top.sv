`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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


`include "adder_test.sv"

module top;
    adder_interface intrf();
    adderblock16bit DUT(.sum(intrf.sum),.a(intrf.a),.b(intrf.b),.cin(intrf.cin));
    
    initial
    begin
        uvm_config_db#(virtual adder_interface)::set(null,"*", "Adder_Interface", intrf);
        run_test("adder_test");
    end
endmodule
