module mux2_1(y,i,s);
    output y;
    input[1:0] i;
    input s;    
bufif1 (y,i[1],s);
bufif0 (y,i[0],s);
endmodule

module adderblock1bit(sum1,sum0,a,b);
    output [1:0]sum0,sum1;
    input a,b;
    wire w1,w2;
xor (w1,a,b);
and (w2,a,b);
assign sum0={w2   ,  w1};
assign sum1={w2|w1, ~w1};
endmodule

module adderblock2bit(sum1,sum0,a,b);
    output [2:0]sum1,sum0;
    wire [1:0]msum1,msum0; //outptut of mux
    wire [3:0]adsum1,adsum0; //output of adder
    input [1:0]a,b;
adderblock1bit ad2 [1:0](.sum1(adsum1),.sum0(adsum0),.a(a),.b(b));
genvar i;
generate
    for(i=0;i<2;i=i+1)
    begin
        mux2_1 mu1 (.y(msum0[i]),.i({adsum1[i+2],adsum0[i+2]}),.s(adsum0[1]));
        mux2_1 mu2 (.y(msum1[i]),.i({adsum1[i+2],adsum0[i+2]}),.s(adsum1[1]));
    end
endgenerate
assign sum0={msum0,adsum0[0+:1]};
assign sum1={msum1,adsum1[0+:1]};
endmodule

module adderblock4bit(sum1,sum0,a,b);
    output [4:0]sum1,sum0;
    wire [2:0]msum1,msum0; 
    wire [5:0]adsum1,adsum0; 
    input [3:0]a,b;
adderblock2bit ab2 [1:0](.sum1(adsum1),.sum0(adsum0),.a(a),.b(b));
genvar i;
generate
    for(i=0;i<3;i=i+1)
    begin
        mux2_1 mu1 (.y(msum0[i]),.i({adsum1[i+3],adsum0[i+3]}),.s(adsum0[2]));
        mux2_1 mu2 (.y(msum1[i]),.i({adsum1[i+3],adsum0[i+3]}),.s(adsum1[2]));
    end
endgenerate  
assign sum0={msum0,adsum0[0+:2]};
assign sum1={msum1,adsum1[0+:2]};
endmodule

module adderblock8bit(sum1,sum0,a,b);
    output [8:0]sum1,sum0;
    wire [4:0]msum1,msum0;
    wire [9:0]adsum1,adsum0;
    input [7:0]a,b;
adderblock4bit ab8 [1:0](.sum1(adsum1),.sum0(adsum0),.a(a),.b(b));   
genvar i;
generate
    for(i=0;i<5;i=i+1)
    begin
        mux2_1 mu1 (.y(msum0[i]),.i({adsum1[i+5],adsum0[i+5]}),.s(adsum0[4]));
        mux2_1 mu2 (.y(msum1[i]),.i({adsum1[i+5],adsum0[i+5]}),.s(adsum1[4]));
    end
endgenerate 
assign sum0={msum0,adsum0[0+:4]};
assign sum1={msum1,adsum1[0+:4]};
endmodule

module adderblock16bit(sum,a,b,cin);
    output [16:0]sum;
    wire [16:0]sum1,sum0;
    wire [8:0]msum1,msum0;
    wire [17:0]adsum1,adsum0;
    input [15:0]a,b;
    input cin;
adderblock8bit ab16 [1:0](.sum1(adsum1),.sum0(adsum0),.a(a),.b(b));   
genvar i;
generate
    for(i=0;i<9;i=i+1)
    begin
        mux2_1 mu1 (.y(msum0[i]),.i({adsum1[i+9],adsum0[i+9]}),.s(adsum0[8]));
        mux2_1 mu2 (.y(msum1[i]),.i({adsum1[i+9],adsum0[i+9]}),.s(adsum1[8]));
    end
endgenerate 
assign sum0={msum0,adsum0[0+:8]};
assign sum1={msum1,adsum1[0+:8]};
assign sum=cin?sum1:sum0;
endmodule

