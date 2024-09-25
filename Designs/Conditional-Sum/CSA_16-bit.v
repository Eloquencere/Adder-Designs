module adderblock1bit (sum1, sum0, a, b);
    input a, b;
    output [1:0]sum0, sum1;
        assign sum0 = {a & b, a ^ b};
        assign sum1 = {sum0[1] | sum0[0], !sum0[0]};
endmodule

module adderblock2bit (sum1, sum0, a, b);
    input [1:0]a, b;
    output [2:0]sum1, sum0;
    wire [3:0]vsum1, vsum0; //Output of the Adder
        adderblock1bit ab2 [1:0](.sum1(vsum1), .sum0(vsum0), .a(a), .b(b));
        assign sum0 = {(vsum0[1] ? vsum1[3:2] : vsum0[3:2]), vsum0[0+:1]}; 
        assign sum1 = {(vsum1[1] ? vsum1[3:2] : vsum0[3:2]), vsum1[0+:1]};
endmodule

module adderblock4bit (sum1, sum0, a, b);
    input [3:0]a, b;
    output [4:0]sum1, sum0;
    wire [5:0]vsum1, vsum0; //Output of the Previous Block
        adderblock2bit ab4 [1:0](.sum1(vsum1), .sum0(vsum0), .a(a), .b(b));
        assign sum0 = {(vsum0[2] ? vsum1[5:3] : vsum0[5:3]), vsum0[0+:2]};
        assign sum1 = {(vsum1[2] ? vsum1[5:3] : vsum0[5:3]), vsum1[0+:2]};
endmodule

module adderblock8bit (sum1, sum0, a, b);
    input [7:0]a, b;
    output [8:0]sum1, sum0;
    wire [9:0]vsum1, vsum0;
        adderblock4bit ab8 [1:0](.sum1(vsum1), .sum0(vsum0), .a(a), .b(b));   
        assign sum0 = {(vsum0[4] ? vsum1[9:5] : vsum0[9:5]), vsum0[0+:4]};
        assign sum1 = {(vsum1[4] ? vsum1[9:5] : vsum0[9:5]), vsum1[0+:4]};
endmodule

module adderblock16bit (sum,a,b,cin);
    input cin;
    input [15:0]a, b;
    output [16:0]sum;
    wire [16:0]sum1, sum0;
    wire [17:0]vsum1, vsum0;
        adderblock8bit ab16 [1:0](.sum1(vsum1), .sum0(vsum0), .a(a), .b(b));   
        assign sum0 = {(vsum0[8] ? vsum1[17:9] : vsum0[17:9]), vsum0[0+:8]};
        assign sum1 = {(vsum1[8] ? vsum1[17:9] : vsum0[17:9]), vsum1[0+:8]};
        assign sum = cin ? sum1 : sum0;
endmodule
