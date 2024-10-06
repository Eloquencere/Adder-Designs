`timescale 1ns/1ps

import uvm_pkg::*;

module top;
    for(genvar i = 0; i < 1; i++) begin
        adder_interface intrf();
        case(i)
            0: CIAxbit DUT0(.sum(intrf.sum), .cout(intrf.cout), .a(intrf.a), .b(intrf.b), .cin(intrf.cin));
        endcase
        initial
            uvm_config_db#(virtual adder_interface)::set (
                uvm_root::get(), "*", $sformatf("%s_Interface", "HELOO"), intrf
            );
    end
    initial begin
        static adder_test_config tst_cfg = adder_test_config::type_id::create("tst_cfg");
        uvm_config_db#(adder_test_config)::set(uvm_root::get(), "uvm_test_top", "tst_cfg", tst_cfg);
        // $timeformat(-9, 2, " ns", 20);
        run_test("adder_test");
    end
endmodule
