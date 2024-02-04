interface AdderInterface();
	logic [16]a, b;
	logic cin;
	logic [17]sum;
endinterface

program Testbench(a, b, cin, sum);
  	output bit [16]a, b;
	output bit cin;
  	input bit [17]sum;		

	initial $monitor("Sum = %0x", sum);
	initial
	begin
		a = 1; b = 1; cin = 0;
    		#10 $finish;
	end
endprogram

module top;
	AdderInterface intrf();
	adder dut(.a(intrf.a), .b(intrf.b), .cin(intrf.cin), .sum(intrf.sum));
	Testbench tb(.a(intrf.a), .b(intrf.b), .cin(intrf.cin), .sum(intrf.sum));
endmodule
