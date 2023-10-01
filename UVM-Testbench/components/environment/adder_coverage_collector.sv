class adder_coverage_collector extends uvm_subscriber#(adder_packet);
    `uvm_component_utils(adder_coverage_collector)
    adder_packet packet_from_scrbrd;
    
    covergroup set1;
        coverpoint packet_from_scrbrd.a
        {
            bins positive = {[0:$]};
            bins negative = {[$:0]};
            bins zeros = {'0};
        }
        coverpoint packet_from_scrbrd.b
        {
            bins positive = {[0:$]};
            bins negative = {[$:0]};
            bins zeros = {'0};
        }
        coverpoint packet_from_scrbrd.cin{}
        coverpoint packet_from_scrbrd.sum
        {
            bins positive = {[0:$]};
            bins negative = {[$:0]};
            bins zeros = {'0};
        }
        coverpoint packet_from_scrbrd.cout{}
    endgroup
    
    function new(string name = "adder_coverage_collector", uvm_component parent);
        super.new(name, parent);
        set1 = new();
    endfunction
    
    virtual function void write(adder_packet t);
        packet_from_scrbrd = t;
        // `uvm_info(get_type_name(), $sformatf("\n%s", packet_from_scrbrd.sprint()), UVM_LOW)
        set1.sample();
    endfunction
    
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Started report_phase", UVM_NONE)
        
        `uvm_info(get_type_name(), $sformatf("Instance Coverage = %f", this.set1.get_inst_coverage()), UVM_NONE)
        
        `uvm_info(get_type_name(), "Finished report_phase", UVM_NONE)
    endfunction
endclass
