module tb;
    parameter integer SIZE = 16;
    reg [SIZE-1:0]clk;
    reg [SIZE-1:0]a, b;
    reg cin;
    wire [SIZE-1:0]sum;
    wire cout;
    AdderBlock64bit dut(.sum(sum),.cout(cout),.a(a),.b(b),.cin(cin),.clk(clk));
    initial
        $monitor(
            "time -> %t, clk -> %d, a -> %b, b -> %b, cin -> %b, sum -> %b",
            $time, clk, a, b, cin, sum
        );
    initial begin
        clk = {SIZE-1{1'b0}};
        forever #10 clk = ~clk;
    end
    initial begin
        a=0;b=0;cin=0;
        @(posedge clk) cin=1;
        @(posedge clk) a=16'hCD;b=16'hFC;
        @(posedge clk) cin=0;
        @(posedge clk) a=16'h33;b=16'h77;
        @(posedge clk) cin=1;
        #20 $finish;
    end
endmodule

module AdderBlock64bit(sum,cout,a,b,cin,clk);
parameter integer SIZE = 16; //size >= 4;
    output [SIZE-1:0]sum;
    output cout;
    input [SIZE-1:0]a,b;
    input cin;
    input [SIZE-1:0]clk;
    wire [SIZE>>2:0]carry;
genvar i;
generate
    for(i=0;i<SIZE;i=i+4)
    begin
        assign carry[0]=cin;
        AdderBlock4bit blk1(
            .a(a[i+:4]), .b(b[i+:4]),.cin(carry[i>>2]),
            .sum(sum[i+:4]),.cout(carry[(i>>2)+1]),
            .clk(clk[i+:4])
        );
        assign cout=carry[SIZE>>2];
    end
endgenerate
endmodule

module AdderBlock4bit(sum,cout,a,b,cin,clk);
    output [3:0]sum;
    output cout;
    input [3:0]a,b;
    input cin;
    input [3:0] clk;
    wire [2:0]carry;
AdderBlock1bit blk1 [3:0](.sum(sum),.cout({cout,carry}),.a(a),.b(b),.cin({carry,cin}), .clk(clk));
endmodule

module AdderBlock1bit(sum,cout,a,b,cin, clk);
    output sum,cout;
    input a,b,cin;
    wire p;
    input clk;
carrygen1bit stat1(.cout(cout),.p(p),.a(a),.b(b),.cin(cin), .clk(clk));
PFA1bit add1(.sum(sum),.p(p),.cin(cin));
endmodule

module carrygen1bit(cout,p,a,b,cin,clk);
    output cout,p;
    input a,b,cin,clk;
    supply1 vdd;
    supply0 gnd;
    wire vp,vg,clkvp,clkvg;
    wire w;
    wire ncin,ncout;
not no1(ncin,cin);
xor x1(vp,a,b);
and a1(vg,a,b);
and a2(clkvp,vp,clk);
and a3(clkvg,vg,clk);
pmos p1(ncout,vdd,clk);
nmos n1(w,gnd,clk);
nmos n2(ncout,w,clkvg);
nmos n3(ncout,ncin,clkvp);
buf b1(p,vp);
not no3(cout,ncout);
endmodule

module PFA1bit(sum,p,cin);
    output sum;
    input p,cin;
xor x1(sum,p,cin);
endmodule

