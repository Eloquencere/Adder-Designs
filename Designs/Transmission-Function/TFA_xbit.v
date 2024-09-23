`timescale 1ns/1ps

module TFA_1bit (
    input a, b, cin,
    output sum, cout
);
    wire p = a ^ b;

    // cout -> (A & ~P) + (P & cin)
    pmos p1 (cout, a, p);
    nmos n1 (cout, a, ~p);
    pmos p2 (cout, cin, ~p);
    nmos n2 (cout, cin, p);

    // sum -> cin ^ P
    pmos p3 (sum, cin, p);
    nmos n3 (sum, cin, ~p);
    pmos p4 (sum, ~cin, ~p);
    nmos n4 (sum, ~cin, p);
endmodule

module TFA_xbit #(
    parameter integer WIDTH = 8
) (
    input [WIDTH-1:0] a, b,
    input cin,
    output [WIDTH-1:0] sum,
    output cout
);
    wire [WIDTH-2:0] carry_i;

    TFA_1bit adder [WIDTH-1:0] (
        .a(a), .b(b),
        .cin({carry_i, cin}),
        .sum(sum),
        .cout({cout, carry_i})
    );
endmodule
