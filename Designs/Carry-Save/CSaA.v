`timescale 1ns/1ps

module FA_1bit (
    input a, b, c_in,
    output s, c_o
);
    assign {c_o, s} = a + b + c_in;
endmodule

module CSaA_xbit #(
    parameter integer WIDTH = 2
)(
    input [WIDTH-1:0] x, y, z, // WIDTH-1:0 ideally
    output [WIDTH:0] sum, // [WIDTH:0]sum -> ideally
    output cout
);
    wire [WIDTH:0] sum_i_upper;
    wire [WIDTH-1:0] carry_i_upper;
    wire [WIDTH:0] carry_i_lower;

    // The very last, left-most adder expects the sum from the following adder
    // but, since it doesn't exist we are driving it with 0.
    assign sum_i_upper[WIDTH] = 1'b0;
    // The very first carry in is 0.
    assign carry_i_lower[0] = 1'b0;

    generate
        genvar i;
        for (i = 0; i < WIDTH; i=i+1) begin
            FA_1bit adder0 [1:0] (
                .a({sum_i_upper[i+1], x[i]}), .b({carry_i_upper[i], y[i]}), .c_in({carry_i_lower[i], z[i]}),
                .c_o({carry_i_lower[i+1], carry_i_upper[i]}), .s({sum[i+1], sum_i_upper[i]})
            );
        end
    endgenerate

    assign sum[0] = sum_i_upper[0];
    assign cout = carry_i_lower[WIDTH];
endmodule

module CSaA_tb;
    parameter int WIDTH = 4;

    reg [WIDTH-1:0] x, y, z;
    wire [WIDTH:0]sum;
    wire cout;

    CSaA_xbit #(
        .WIDTH(WIDTH)
    ) dut (
        .x(x), .y(y), .z(z),
        .sum(sum), .cout(cout)
    );

    initial
        $monitor(
            "time -> %5t: x -> 0x%h, y -> 0x%h, z -> 0x%h, real-sum -> 0x%h",
            $time, x, y, z, {cout, sum}
        );
    initial begin
        // single bit sequence
        for(int A = 0; A < 16; A++) begin
            x = A;
            for(int B = 0; B < 16; B++) begin
                y = B;
                for(int C = 0; C < 16; C++) begin
                    z = C;
                    #5;
                end
            end
        end

        // x = 4'hC; y = 4'hF; z = 4'h9;

        #10 $finish;
    end
endmodule

