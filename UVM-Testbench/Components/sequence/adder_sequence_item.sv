class adder_packet extends uvm_sequence_item;
    
    function new(string name = "adder_packet");
        super.new(name);
    endfunction
    
    randc bit [15:0]a, b;
    randc bit cin;
    bit [16:0]sum;
    
    `uvm_object_utils_begin(adder_packet)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(cin, UVM_ALL_ON)
        `uvm_field_int(sum, UVM_ALL_ON)
    `uvm_object_utils_end
endclass