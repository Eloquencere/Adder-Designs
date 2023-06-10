`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2023 14:28:50
// Design Name: 
// Module Name: Top
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



module TestBench_Top;
    DUT_interface intrf();
    test tst(intrf);
    CIA16bit DUT(.sum(intrf.sum), .cout(intrf.cout), .a(intrf.a), .b(intrf.b), .cin(intrf.cin));
endmodule
