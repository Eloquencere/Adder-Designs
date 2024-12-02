// it's impossible to implement this logic circuit via verilog simulation
// since it heavyly requires certain physics to take place like holding of
// charge by cout(necessary parasitic capacitance) in order to operate correctly
module carrygen1bit (
    input clk,
    input a, b, cin,
    output p, cout
);
    supply1 vdd;
    supply0 gnd;

    wire common;

    assign g = a & b;
    assign p = a ^ b;

    nmos n1(~cin, ncout, p);
    pmos p1(vdd, ncout, clk);
    nmos n2(ncout, common, g);
    nmos n3(common, gnd, clk);

    assign cout = ~ncout;
endmodule

module PFA1bit (
    input p, cin,
    output sum
);
    assign sum = p ^ cin;
endmodule

module MCCA_Dyn_1bit (
    input clk,
    input a, b,
    input cin,
    output sum,
    output cout
);
    wire p;

    carrygen1bit dyn1 (
        .clk(clk),
        .a(a), .b(b), .cin(cin),
        .p(p), .cout(cout)
    );

    PFA1bit add1 (
        .p(p), .cin(sum),
        .sum(sum)
    );
endmodule

module MCCA_Dyn_4bit (
    input clk,
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [2:0] carry;

    MCCA_Dyn_1bit bk1 [3:0] (
        .clk({4{clk}}),
        .a(a), .b(b),
        .cin({carry, cin}),
        .sum(sum),
        .cout({cout, carry})
    );
endmodule

module MCCA_Dyn_xbit #(
    parameter integer SIZE = 16
)(
    input clk,
    input [SIZE-1:0] a, b,
    input cin,
    output [SIZE-1:0] sum,
    output cout
);
    wire [SIZE>>2:0] carry;

    generate
        genvar i;
        assign carry[0] = cin;
        for(i = 0; i < SIZE; i = i+4) begin
            MCCA_Dyn_4bit blkx (
                .clk(clk),
                .a(a[i+:4]), .b(b[i+:4]),
                .cin(carry[i>>2]),
                .sum(sum[i+:4]),
                .cout(carry[(i>>2)+1])
            );
        end
        assign cout = carry[SIZE>>2];
    endgenerate
endmodule

module tb;
    parameter integer SIZE = 8;

    reg clk;
    reg [SIZE-1:0] a, b;
    reg cin;
    wire [SIZE-1:0] sum;
    wire cout;

    MCCA_Dyn_xbit #(
        .SIZE(SIZE)
    ) dut (
        .clk(clk),
        .a(a), .b(b), .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial
        $monitor(
            "time -> %3t, clk -> %b, a -> %b, b -> %b, cin -> %b, sum -> %b",
            $time, clk, a, b, cin, {cout,sum}
        );
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        a = 0; b = 0; cin = 0;
        @(negedge clk) cin = 1;
        @(negedge clk) a = 0; b = 1;
        @(negedge clk) cin = 0;
        @(negedge clk) a = 1; b = 0;
        @(negedge clk) cin = 1;
        @(negedge clk) a = 1; b = 1;
        @(negedge clk) cin = 0;
        #20 $finish;
    end
endmodule
