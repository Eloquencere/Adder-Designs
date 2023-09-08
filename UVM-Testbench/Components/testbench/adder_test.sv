class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)
    
    function new(string name = "adder_test", uvm_component parent); // change to extrn
        super.new(name, parent);
    endfunction
    
    adder_environment envrnmnt;
    adder_sequence sqnc;
    
    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_LOW)
        
        envrnmnt = adder_environment::type_id::create("envrnmnt", this);
        sqnc = adder_sequence::type_id::create("sqnc", this);
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_LOW)
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_type_name(), "Started run_phase", UVM_LOW)
        
        sqnc.start(envrnmnt.agnt.sqncr);
        
        `uvm_info(get_type_name(), "Finished run_phase", UVM_LOW)
        phase.drop_objection(this);
    endtask
endclass
