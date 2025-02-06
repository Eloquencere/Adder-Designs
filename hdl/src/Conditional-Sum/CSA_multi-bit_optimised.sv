module mux2_1 (
    input [1:0] data_in,
    input       data_select,
    output      data_out
);
    bufif0(data_out, data_in[0], data_select);
    bufif1(data_out, data_in[1], data_select);
endmodule

module csa_block_1bit (
    input        a, b,
    output [1:0] sum0, sum1
);
    wire [1:0] w;

    xor(w[0], a, b);
    and(w[1], a, b);

    assign sum0 = w[1:0];
    assign sum1 = {|w, ~w[0]};
endmodule

module csa_block_2bit (
    input  [1:0] a, b,
    output [2:0] sum1, sum0
);
    wire [3:0] adsum1, adsum0;
    wire [1:0] msum1,  msum0;

    csa_block_1bit ad1 [1:0] (
        .a, .b,
        .sum1(adsum1), .sum0(adsum0)
    );
    
    generate
        for (genvar i=0; i<2; i++) begin
            mux2_1 mux [1:0] (
                .data_in({2{adsum1[i+2], adsum0[i+2]}}),
                .data_select({adsum1[1], adsum0[1]}),
                .data_out({msum1[i], msum0[i]})
            );
        end
    endgenerate

    assign sum0={msum0, adsum0[0+:1]};
    assign sum1={msum1, adsum1[0+:1]};
endmodule

module csa_block_4bit (
    input  [3:0] a, b,
    output [4:0] sum1, sum0
);
    wire [5:0] adsum1, adsum0;
    wire [2:0] msum1,  msum0;

    csa_block_2bit ad2 [1:0] (
        .a, .b,
        .sum1(adsum1), .sum0(adsum0)
    );
    
    generate
        for (genvar i=0; i<3; i++) begin
            mux2_1 mux [1:0] (
                .data_in({2{adsum1[i+3], adsum0[i+3]}}),
                .data_select({adsum1[2], adsum0[2]}),
                .data_out({msum1[i], msum0[i]})
            );
        end
    endgenerate

    assign sum0={msum0, adsum0[0+:2]};
    assign sum1={msum1, adsum1[0+:2]};
endmodule

module csa_block_8bit (
    input  [7:0] a, b,
    output [8:0] sum1, sum0
);
    wire [9:0] adsum1, adsum0;
    wire [4:0] msum1,  msum0;

    csa_block_4bit ad4 [1:0] (
        .a, .b,
        .sum1(adsum1), .sum0(adsum0)
    );
    
    generate
        for (genvar i=0; i<5; i++) begin
            mux2_1 mux [1:0] (
                .data_in({2{adsum1[i+5], adsum0[i+5]}}),
                .data_select({adsum1[4], adsum0[4]}),
                .data_out({msum1[i], msum0[i]})
            );
        end
    endgenerate

    assign sum0={msum0, adsum0[0+:4]};
    assign sum1={msum1, adsum1[0+:4]};
endmodule

module csa_block_16bit (
    input  [15:0] a, b,
    output [16:0] sum1, sum0
);
    wire [17:0] adsum1, adsum0;
    wire [8:0] msum1,  msum0;

    csa_block_8bit ad8 [1:0] (
        .a, .b,
        .sum1(adsum1), .sum0(adsum0)
    );
    
    generate
        for (genvar i=0; i<9; i++) begin
            mux2_1 mux [1:0] (
                .data_in({2{adsum1[i+9], adsum0[i+9]}}),
                .data_select({adsum1[8], adsum0[8]}),
                .data_out({msum1[i], msum0[i]})
            );
        end
    endgenerate

    assign sum0={msum0, adsum0[0+:8]};
    assign sum1={msum1, adsum1[0+:8]};
endmodule

module csa_block_32bit (
    input  [31:0] a, b,
    output [32:0] sum1, sum0
);
    wire [33:0] adsum1, adsum0;
    wire [16:0] msum1,  msum0;

    csa_block_16bit ad16 [1:0] (
        .a, .b,
        .sum1(adsum1), .sum0(adsum0)
    );
    
    generate
        for (genvar i=0; i<17; i++) begin
            mux2_1 mux [1:0] (
                .data_in({2{adsum1[i+17], adsum0[i+17]}}),
                .data_select({adsum1[16], adsum0[16]}),
                .data_out({msum1[i], msum0[i]})
            );
        end
    endgenerate

    assign sum0={msum0, adsum0[0+:16]};
    assign sum1={msum1, adsum1[0+:16]};
endmodule

module csa_block_64bit (
    input  [63:0] a, b,
    output [64:0] sum1, sum0
);
    wire [65:0] adsum1, adsum0;
    wire [32:0] msum1,  msum0;

    csa_block_16bit ad16 [1:0] (
        .a, .b,
        .sum1(adsum1), .sum0(adsum0)
    );
    
    generate
        for (genvar i=0; i<33; i++) begin
            mux2_1 mux [1:0] (
                .data_in({2{adsum1[i+33], adsum0[i+33]}}),
                .data_select({adsum1[32], adsum0[32]}),
                .data_out({msum1[i], msum0[i]})
            );
        end
    endgenerate

    assign sum0={msum0, adsum0[0+:32]};
    assign sum1={msum1, adsum1[0+:32]};
endmodule

module csa_block #(
    parameter DATA_WIDTH = 2
)(
    input  [DATA_WIDTH-1:0] a, b,
    input                   cin,
    output [DATA_WIDTH-1:0] sum,
    output                  cout
);
    wire [DATA_WIDTH:0] sum1, sum0;

    generate
        case (DATA_WIDTH)
            1: begin
                csa_block_1bit csa_1bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            2: begin
                csa_block_2bit csa_2bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            4 : begin
                csa_block_4bit csa_4bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            8 : begin
                csa_block_8bit csa_8bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            16 : begin
                csa_block_16bit csa_16bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            32 : begin
                csa_block_32bit csa_32bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            64 : begin
                csa_block_64bit csa_64bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            default : begin
                csa_block_2bit csa_2bit (
                    .a, .b,
                    .sum0, .sum1
                );
            end
            endcase
    endgenerate

    assign sum[DATA_WIDTH-1:0] = cin? sum1[DATA_WIDTH-1:0] : sum0[DATA_WIDTH-1:0];
    assign cout = cin? sum1[DATA_WIDTH] : sum0[DATA_WIDTH];
endmodule

// module tb;
//     parameter int DATA_WIDTH = 1;
// 
//     reg  [DATA_WIDTH-1:0] a, b;
//     reg                   cin;
//     wire [DATA_WIDTH-1:0] sum;
//     wire                  cout;
// 
//     csa_block #(
//         .DATA_WIDTH(DATA_WIDTH)
//     ) dut (
//         .a, .b, .cin,
//         .sum, .cout
//     );
// 
//     initial
//         $monitor(
//             "time -> %5t: a -> 0x%h, b -> 0x%h, cin -> 0x%h, real-sum -> 0x%h",
//             $time, a, b, cin, {cout, sum}
//         );
//     initial begin
// 
//         // // single bit sequence
//         // for(int A = 0; A < 16; A++) begin
//         //     a = A;
//         //     for(int B = 0; B < 16; B++) begin
//         //         b = B;
//         //         #5;
//         //     end
//         // end
// 
//         a = 'h0C; b = 'h0F; cin = 'b1;
//         #5;
//         a = 'h9A; b = 'h88; cin = 'b0;
// 
//         #10 $finish;
//     end
// endmodule
// 
