module CLA4bit(A,B,cin,sum,cout);
	input [3:0]A, B;
    input cin;
    output [3:0]sum;
    output cout;

	wire [3:0]G, P;
	wire group_P,group_G;
    
    //PG generation
    assign P = A^B;
	assign G = A&B;
	assign group_P = &P;
	assign group_G = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];

    assign cout = group_G | group_P&cin;

    assign sum[0] = P[0] ^ cin;
	assign sum[1] = P[1] ^ ( G[0] | P[0]&cin);
	assign sum[2] = P[2] ^ ( G[1] | P[1]&G[0] | P[1]&P[0]&cin);
	assign sum[3] = P[3] ^ ( G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&cin);

endmodule

module CLAxbit #(parameter size = 8)(A,B,cin,sum,cout);
	input [size-1:0]A, B;
	input cin;
	output [size-1:0]sum;
	output cout;

	wire [size>>2:0]carry;
	genvar i;
    generate
        assign carry[0]=cin;
		for (i=0;i<size;i=i+4)
		begin:Adder
			AdderBlock4bit ab (.A(A[i+:4]), .B(B[i+:4]),.cin(carry[i>>2]),.sum(sum[i+:4]),.cout(carry[(i>>2)+1]));
		end:Adder
        assign cout=carry[size>>2];
	endgenerate
endmodule