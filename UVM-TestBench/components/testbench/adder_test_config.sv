class adder_test_config extends uvm_object;
    `uvm_object_utils(adder_test_config)
    
    adder_report_server srvr;
    
    function new(string name = "adder_test_config");
        super.new(name);
        srvr = new();
        uvm_report_server::set_server(srvr);
    endfunction
endclass
