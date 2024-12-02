`timescale 1ns / 1ps

interface adder_interface();
    logic [15:0]a, b;
    logic cin;
    logic [15:0]sum;
    logic cout;
    
    // Setting port directions for the testbench accessing interface signals
    modport drvr_modprt(output a, b, cin);
    modport mntr_modprt(input a, b, cin, sum, cout);
endinterface

// use a clock signal here & a clocking block
