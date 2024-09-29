class adder_virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(adder_virtual_sequencer)
    
    function new(string name = "adder_virtual_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    uvm_sequencer #(adder_packet) sqncr[];
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("Started %s_phase", phase.get_name()), UVM_FULL)
        
        // Creating a sequencer handle for every agent to be created
        sqncr = new[adder_testbench_constants_pkg::dut_list.size()];
        
        `uvm_info(get_name(), $sformatf("Finished %s_phase", phase.get_name()), UVM_FULL)
    endfunction
endclass
