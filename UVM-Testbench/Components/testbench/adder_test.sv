class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)
    
    extern function new(string name = "adder_test", uvm_component parent);
    
    adder_environment envrnmnt;
    adder_sequence sqnc;
    
    extern function void build_phase(uvm_phase phase);
    extern function void end_of_elaboration_phase(uvm_phase phase);
    
    extern task run_phase(uvm_phase phase);
endclass


function adder_test::new(string name = "adder_test", uvm_component parent);
    super.new(name, parent);
endfunction

function void adder_test::build_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Started build_phase", UVM_LOW) // change to an appropriate level
    
    envrnmnt = adder_environment::type_id::create("envrnmnt", this);
    sqnc = adder_sequence::type_id::create("sqnc", this);
    
    `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
endfunction

function void adder_test::end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction

task adder_test::run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(), "Started run_phase", UVM_LOW)
    
    sqnc.start(envrnmnt.agnt.sqncr);
    
    `uvm_info(get_type_name(), "Finished run_phase", UVM_LOW)
    phase.drop_objection(this);
endtask