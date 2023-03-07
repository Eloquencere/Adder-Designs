module Mux(In1, In2, Sel, Out);
input In1, In2, Sel;
output Out;

assign Out = Sel?In2:In1;
endmodule


module Conditional_Cell(A, B, Sum0, Sum1, Carry0, Carry1);
input A, B;
output Sum0, Sum1;
output Carry0, Carry1;

assign Sum0 = A^B;
assign Carry0 = A&B;

assign Sum1 = ~Sum0;
assign Carry1 = Sum0|Carry0;
endmodule


module RepBlock(A, B, Sum0, Sum1, pCarry0, pCarry1, nCarry0, nCarry1);
input A, B;
input pCarry0, pCarry1;
output Sum0,Sum1;
output nCarry0, nCarry1;

wire tSum0, tSum1;
wire tCarry0, tCarry1;

Conditional_Cell c1 (.A(A), .B(B), .Sum0(tSum0), .Sum1(tSum1), .Carry0(tCarry0), .Carry1(tCarry1));

Mux m0 [1:0](.In1({tSum0,tCarry0}), .In2({tSum1,tCarry1}), .Sel({2{pCarry0}}), .Out({Sum0,nCarry0}));
Mux m1 [1:0](.In1({tSum0,tCarry0}), .In2({tSum1,tCarry1}), .Sel({2{pCarry1}}), .Out({Sum1,nCarry1}));
endmodule


module AdderBlock(A, B, Cin, Sum, Cout);
parameter size = 16; // Minimum 2 bit

input [size-1:0]A, B;
input Cin;
output [size-1:0]Sum;
output Cout;

wire [size-1:0]Sum0, Sum1; 
wire [size-1:0]Carry0, Carry1;

Conditional_Cell b0 (.A(A[0]), .B(B[0]), .Sum0(Sum0[0]), .Sum1(Sum1[0]), .Carry0(Carry0[0]), .Carry1(Carry1[0])); // static

RepBlock b1 [size-2:0](.A({A[size-1:1]}), .B({B[size-1:1]}),
                    .Sum0({Sum0[size-1:1]}), .Sum1({Sum1[size-1:1]}),
                    .pCarry0({Carry0[size-2:0]}), .pCarry1({Carry1[size-2:0]}),
                    .nCarry0(Carry0[size-1:1]), .nCarry1(Carry1[size-1:1]));

Mux b2 [size-1:0](.In1(Sum0), .In2(Sum1), .Sel({size-1{Cin}}), .Out(Sum));
Mux CarryOut (.In1(Carry0[size-1]), .In2(Carry1[size-1]), .Sel(Cin), .Out(Cout)); // Static
endmodule