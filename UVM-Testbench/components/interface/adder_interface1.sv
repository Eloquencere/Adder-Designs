`timescale 1ns / 1ps

interface adder_interface1();
    logic [15:0]a, b;
    logic cin;
    logic [15:0]sum;
    logic cout;
    
    modport drvr_modprt(output a, b, cin);
    modport mntr_modprt(input a, b, cin, sum, cout);
endinterface
