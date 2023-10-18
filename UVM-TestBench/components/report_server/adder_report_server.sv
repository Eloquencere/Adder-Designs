class adder_report_server extends uvm_report_server;
    function string compose_message
    (
        uvm_severity severity,
        string name,
        string id,
        string message,
        string filename,
        int line
    );
    uvm_severity_type sev = uvm_severity_type'(severity);
    
    adder_colours_pkg::colour_t colour = adder_colours_pkg::WHITE;
    if(adder_testbench_constants_pkg::colourise_report_message)
        case(sev.name())
            "UVM_INFO": colour = adder_colours_pkg::BLUE;
            "UVM_WARNING": colour = adder_colours_pkg::YELLOW;
            "UVM_ERROR", "UVM_FATAL": colour = adder_colours_pkg::RED;
        endcase
    
    return adder_colours_pkg::colourise(colour, $sformatf("%s %s(%0d) @ %0t: %s [%s] %s",
                        sev.name(), filename.substr(27, filename.len()-1), line, $time, name, id, message));
    endfunction
endclass
