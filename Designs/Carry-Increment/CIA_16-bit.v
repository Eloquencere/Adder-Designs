`timescale 1ns/1ps

`define size 16 //size >= 4;

module CIAxbit(sum,cout,a,b,cin);
    output [`size-1:0]sum;
    output cout;
    input [`size-1:0]a,b;
    input cin;
    wire [`size>>2:0]carry;
genvar i;
generate
    for(i=0;i<`size;i=i+4)
    begin:CLA
        assign carry[0]=cin;
        AdderBlock4bit1 ad1(.sum(sum[i+:4]),.cout(carry[(i>>2)+1]),.a(a[i+:4]),.b(b[i+:4]),.cin(carry[i>>2]));
        assign cout=carry[`size>>2];
    end
endgenerate
endmodule

module AdderBlock4bit1(sum,cout,a,b,cin);
    output [3:0]sum;
    output cout;
    input cin;
    input [3:0]a,b;
    wire [3:0]vsum;
    wire vcout,vcarry;
FA4bit1 fab(.sum(vsum),.cout(vcout),.a(a),.b(b),.cin(1'b0));
HAChain4bit1 hab(.sum(sum),.cout(vcarry),.a(vsum),.cin(cin));
or(cout,vcarry,vcout);
endmodule

module HAChain4bit1(sum,cout,a,cin);
    output [3:0]sum;
    output cout;
    input [3:0]a;
    input cin;
    wire [2:0]carry;
HA1bit1 chain [3:0](.sum(sum),.cout({cout,carry}),.a(a),.b({carry,cin}));
endmodule

module FA4bit1(sum,cout,a,b,cin);
    output [3:0]sum;
    output cout;
    input [3:0]a,b;
    input cin;
    wire [2:0]carry;
FA1bit1 f1 [3:0](.sum(sum),.cout({cout,carry}),.a(a),.b(b),.cin({carry,cin}));
endmodule

module FA1bit1(sum,cout,a,b,cin);
    output sum,cout;
    input a,b,cin;
    wire w1,w2,w3;
HA1bit1 M1(w1,w2,a,b);
HA1bit1 M2(sum,w3,w1,cin);
or M3(cout,w2,w3);
endmodule

module HA1bit1(sum,cout,a,b);
    output sum,cout;
    input a,b;
xor(sum,a,b);
and (cout,a,b);
endmodule
