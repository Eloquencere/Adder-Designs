module testbench_top;
    parameter int WIDTH = 1;

    adder_interface #(
        .WIDTH(WIDTH)
    ) intrf ();

    CSaA_xbit #(
        .WIDTH(WIDTH)
    ) dut (
        .a(intrf.a), .b(intrf.b),
        .cin(intrf.cin),
        .sum(intrf.sum),
        .cout(intrf.cout)
    );

    combi_adder_testbench #(
        .WIDTH(WIDTH)
    ) tb (
        .a(intrf.a), .b(intrf.b),
        .cin(intrf.cin),
        .sum(intrf.sum),
        .cout(intrf.cout)
    );
endmodule
