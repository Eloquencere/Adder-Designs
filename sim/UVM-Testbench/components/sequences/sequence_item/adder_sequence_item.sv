class adder_packet extends uvm_sequence_item;
    rand bit [15:0]a, b;
    rand bit cin;
    bit [15:0]sum;
    bit cout;
    string dut_name;

    `uvm_object_utils_begin(adder_packet)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(cin, UVM_ALL_ON)
        `uvm_field_int(sum, UVM_ALL_ON)
        `uvm_field_int(cout, UVM_ALL_ON)
        `uvm_field_string(dut_name, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "adder_packet");
        super.new(name);
    endfunction
endclass
