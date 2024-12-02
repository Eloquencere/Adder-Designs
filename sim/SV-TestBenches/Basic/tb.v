module tb;
  reg [16]a, b;
  reg cin;
  wire sum;

  adder DUT(.a(a), .b(b), .cin(cin), .sum(sum));
  initial
  begin
    #2 a = 1; b = 1; cin = 0;
  end
endmodule
