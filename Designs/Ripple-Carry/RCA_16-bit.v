`timescale 1ns/1ps

module RCAxbit(sum,cout,a,b,cin);
parameter size=16; //size >= 4;
    output [size-1:0]sum;
    output cout;
    input [size-1:0]a,b;
    input cin;
    wire [size>>2:0]carry;
genvar i;
generate
    for(i=0;i<size;i=i+4)
    begin:FA
        assign carry[0]=cin;
        FA4bit4 f16(.sum(sum[i+:4]),.cout(carry[(i>>2)+1]),.a(a[i+:4]),.b(b[i+:4]),.cin(carry[i>>2]));
        assign cout=carry[size>>2];
    end
endgenerate
endmodule

module FA4bit4(sum,cout,a,b,cin);
    output [3:0]sum;
    output cout;
    input [3:0]a,b;
    input cin;
    wire [4:0]carry;
genvar i;
generate
    for(i=0;i<4;i=i+1)
    begin:FA
    assign carry[0]=cin;
        FA1bit4 f1(.sum(sum[i]),.cout(carry[i+1]),.a(a[i]),.b(b[i]),.cin(carry[i]));
    assign cout=carry[4];
    end
endgenerate
endmodule

module FA1bit4(sum,cout,a,b,cin);
    output sum,cout;
    input a,b,cin;
    wire w1,w2,w3;
HA1bit M1(w1,w2,a,b);
HA1bit M2(sum,w3,w1,cin);
or M3(cout,w2,w3);
endmodule

module HA1bit(sum,cout,a,b);
    output sum,cout;
    input a,b;
xor(sum,a,b);
and (cout,a,b);
endmodule
