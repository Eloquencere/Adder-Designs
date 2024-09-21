module tb;
    parameter integer SIZE = 16;

    reg clk;
    reg [SIZE-1:0] a, b;
    reg cin;
    wire [SIZE-1:0] sum;
    wire cout;

    MCCAxbit dut (
        .a(a), .b(b), .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial
        $monitor(
            "time -> %3t, a -> %b, b -> %b, cin -> %b, sum -> %b",
            $time, a, b, cin, {cout,sum}
        );

    initial begin
        a = 0; b = 0; cin = 0;
        #5; cin = 1;
        #5; a = 16'hCD; b = 16'hBD;
        #5; cin = 0;
        #5; a = 1; b = 0;
        #5; cin = 1;
        #5; a = 1; b = 1;
        #5; cin = 0;
        #20 $finish;
    end
endmodule

module MCCAxbit(sum,cout,a,b,cin);
parameter size = 16; //size >= 4;
    output [size-1:0]sum;
    output cout;
    input [size-1:0]a,b;
    input cin;
    wire [size>>2:0]carry;
genvar i;
generate
    for(i=0;i<size;i=i+4)
    begin
        assign carry[0]=cin;
        AdderBlock4bit10 blk1(.sum(sum[i+:4]),.cout(carry[(i>>2)+1]),.a(a[i+:4]),.b(b[i+:4]),.cin(carry[i>>2]));
        assign cout=carry[size>>2];
    end
endgenerate
endmodule

module AdderBlock4bit10(sum,cout,a,b,cin);
    output [3:0]sum;
    output cout;
    input [3:0]a,b;
    input cin;
    wire [2:0]carry;
AdderBlock1bit10 blk1 [3:0](.sum(sum),.cout({cout,carry}),.a(a),.b(b),.cin({carry,cin}));
endmodule

module AdderBlock1bit10(sum,cout,a,b,cin);
    output sum,cout;
    input a,b,cin;
    wire p;
carrygen1bit10 stat1(.cout(cout),.p(p),.a(a),.b(b),.cin(cin));
PFA1bit10 add1(.sum(sum),.p(p),.cin(cin));
endmodule


module carrygen1bit10(cout,p,a,b,cin);
    output cout,p;
    input a,b,cin;
    supply1 vdd;
    supply0 gnd;
    wire vp,vg,w,np,ncout,ncin;
xor x1(vp,a,b);
and a1(vg,a,b);
not no1(np,p);
not no2(ncin,cin);
rpmos p1(ncout,vdd,vg);
nmos n1(w,gnd,np);
nmos n2(ncout,w,vg);
nmos n3(ncout,ncin,vp);
pmos p2(ncout,ncin,np);
buf b1(p,vp);
not no3(cout,ncout);
endmodule

module PFA1bit10(sum,p,cin);
    output sum;
    input p,cin;
xor x1(sum,p,cin);
endmodule
