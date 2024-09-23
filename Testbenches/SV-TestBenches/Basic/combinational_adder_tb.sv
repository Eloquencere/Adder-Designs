`timescale 1ns/1ps

program combi_adder_testbench #(
    parameter int WIDTH=8
)(
    output bit [WIDTH-1:0] a, b,
    output bit cin,
    input bit [WIDTH-1:0] sum,
    input cout
);
    initial
        $monitor(
            "time -> %4t: a -> %b, b -> %b, cin -> %b, real-sum -> %b",
            $time, a, b, cin, {cout, sum}
        );
    initial begin
        // single bit sequence
        for(int A = 0; A < 16; A++) begin
            a = A;
            for(int B = 0; B < 16; B++) begin
                b = B;
                for(int Cin = 0; Cin < 16; Cin++) begin
                    cin = Cin;
                    #5;
                end
            end
        end

        #10 $finish;
    end
endprogram
