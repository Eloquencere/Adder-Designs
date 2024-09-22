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
        // a = 0; b = 0; cin = 0;
        // #5; a = 0; b = 0; cin = 1;
        // #5; a = 0; b = 1; cin = 0;
        // #5; a = 0; b = 1; cin = 1;
        // #5; a = 1; b = 0; cin = 0;
        // #5; a = 1; b = 0; cin = 1;
        // #5; a = 1; b = 1; cin = 0;
        // #5; a = 1; b = 1; cin = 1;
        for(a = 0; a <= 1; a++) begin
            #5;
            for(b = 0; b <= 1; b++) begin
                #5;
                for(cin = 0; cin <= 1; cin++) begin
                    #5;
                end
            end
        end

        #10 $finish;
    end
endprogram
