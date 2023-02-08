module AdderBlock64bit(sum,cout,a,b,cin);
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
        AdderBlock4bit blk1(.sum(sum[i+:4]),.cout(carry[(i>>2)+1]),.a(a[i+:4]),.b(b[i+:4]),.cin(carry[i>>2]));
        assign cout=carry[size>>2];
    end
endgenerate
endmodule

module AdderBlock4bit(sum,cout,a,b,cin);
    output [3:0]sum;
    output cout;
    input [3:0]a,b;
    input cin;
    wire [2:0]carry;
AdderBlock1bit blk1 [3:0](.sum(sum),.cout({cout,carry}),.a(a),.b(b),.cin({carry,cin}));
endmodule

module AdderBlock1bit(sum,cout,a,b,cin);
    output sum,cout;
    input a,b,cin;
    wire p;
carrygen1bit stat1(.cout(cout),.p(p),.a(a),.b(b),.cin(cin));
PFA1bit add1(.sum(sum),.p(p),.cin(cin));
endmodule


module carrygen1bit(cout,p,a,b,cin);
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

module PFA1bit(sum,p,cin);
    output sum;
    input p,cin;
xor x1(sum,p,cin);
endmodule
