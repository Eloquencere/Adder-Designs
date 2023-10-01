module CSkAxbit(sum,cout,a,b,cin);
parameter size=16; // size >=4;
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
        AdderBlock4bit6 AB4(.sum(sum[i+:4]),.cout(carry[(i>>2)+1]),.a(a[i+:4]),.b(b[i+:4]),.cin(carry[i>>2]));
        assign cout=carry[size>>2];
    end
endgenerate
endmodule

module AdderBlock4bit6(sum,cout,a,b,cin);
    output [3:0]sum;
    output cout;
    input [3:0]a,b;
    input cin;
    wire [3:0]p;
    wire c1;
FA4bit6 add1(.sum(sum),.p(p),.cout(c1),.a(a),.b(b),.cin(cin));
CarGen4bit6 gen1(.cout(cout),.p(p),.cin(cin),.vcout(c1));
endmodule

module CarGen4bit6(cout,p,cin,vcout);
    output cout;
    input [3:0]p;
    input cin,vcout;
    assign cout=(p[0]&p[1]&p[2]&p[3]&cin)|vcout; 
endmodule

module FA4bit6(sum,p,cout,a,b,cin);
    output [3:0]sum,p;
    output cout;
    input [3:0]a,b;
    input cin;
    wire [2:0]carry;
FA1bit6 f1 [3:0](.sum(sum),.p(p),.cout({cout,carry}),.a(a),.b(b),.cin({carry,cin}));
endmodule

module FA1bit6(sum,p,cout,a,b,cin);
    output sum,p,cout;
    input a,b,cin;
    wire w1,w2,w3;
HA1bit6 M1(w1,w2,a,b);
HA1bit6 M2(sum,w3,w1,cin);
or M3(cout,w2,w3);
assign p=w1;
endmodule

module HA1bit6(sum,cout,a,b);
    output sum,cout;
    input a,b;
xor(sum,a,b);
and (cout,a,b);
endmodule
