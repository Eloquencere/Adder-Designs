program Testbench(a, b, cin, sum);
  output bit[16]a, b;
	output bit cin;
  input logic[17]sum;		
	
	initial
	begin
    $monitor("Sum = %0x", sum);
		#2 a = 1; b = 1; cin = 0;
    #10 $finish;
	end
endprogram

module top;
	wire [16]a, b;
	wire cin;
  wire [17]sum;
  adder dut(.a, .b, .cin, .sum);
  Testbench tb(.a, .b, .cin, .sum);
endmodule
