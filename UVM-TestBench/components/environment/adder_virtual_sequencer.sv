class adder_virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(adder_virtual_sequencer)
    
    function new(string name = "adder_virtual_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    uvm_sequencer #(adder_packet) sqncr[];
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started build_phase", UVM_FULL)
        
        sqncr = new[adder_testbench_constants_pkg::dut_list.size()];
        
        `uvm_info(get_type_name(), "Finished build_phase", UVM_FULL)
    endfunction
endclass
