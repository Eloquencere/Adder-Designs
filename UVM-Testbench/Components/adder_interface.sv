`timescale 1ns / 1ps

interface adder_interface();
    logic [15:0]a, b;
    logic cin;
    logic [16:0]sum;
endinterface : adder_interface
