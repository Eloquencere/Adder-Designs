module CSA64bit(a,b,c,s,cout);
parameter size=16; //size >= 4;
    input[size-1:0] a,b;
    input c;
    output[size-1:0] s;
    output cout;
    wire[size>>2:0] w0;
assign w0[0]=c;
generate
    genvar i;
    for(i=0;i<size;i=i+4)
    begin
        CSA4bit fourbitsca (.a(a[i+:4]),.b(b[i+:4]),.c(w0[i/4]),.s(s[i+:4]),.cout(w0[(i/4)+1]));
    end
endgenerate
assign cout=w0[size>>2];
endmodule

module CSA4bit(a,b,c,s,cout);
    input[3:0] a,b;
    output[3:0] s;
    wire[4:0] w1,w0;
    output cout;
    input c;
FA4bit single_calc [1:0] (.a({a,a}),.b({b,b}),.c({1'b1,1'b0}),.s({w1[3:0],w0[3:0]}),.cout({w1[4],w0[4]}));
genvar i;
generate
    for(i=0;i<4;i=i+1)
    begin
        mux2_1 selector (.d({w1[i],w0[i]}),.s(c),.f(s[i]));
    end
endgenerate
mux2_1 selector_carry (.d({w1[4],w0[4]}),.s(c),.f(cout));
endmodule

module mux2_1(d,s,f);
    input[1:0] d;
    input s;
    output f;    
assign f=s?d[1]:d[0];
endmodule

module FA4bit(a,b,c,s,cout);
    input[3:0] a,b;
    input c;
    wire[3:1] w;
    output[3:0] s;
    output cout;
FA1bit fulladder [3:0] (.a(a),.b(b),.c({w,c}),.s(s),.cout({cout,w})); 
endmodule

module FA1bit(a,b,c,s,cout);
    input a,b,c;
    output s,cout;    
assign s=a^b^c;
assign cout=(a&b)|(c&b)|(a&c);
endmodule