`include "subs4b.v"
`timescale 1ps/1ps


module subs4b_tb();

reg [3:0] A_tb;
reg [3:0] B_tb;
reg Ci_tb;

subs4b uut(
    .A(A_tb),
    .B(B_tb),
    .Ci(Ci_tb)
);
initial begin
    A_tb = 4'b0000;
    B_tb = 4'b0000;
    Ci_tb = 1'b1;
    #10;
    A_tb = 4'b0101;
    B_tb = 4'b0011;
    Ci_tb = 1'b1;
    #10;   
    A_tb = 4'b1010;
    B_tb = 4'b1100;
    Ci_tb = 1'b1;
    #10;
    A_tb = 4'b1111;
    B_tb = 4'b1111;
    Ci_tb = 1'b1;
end

initial begin:TEST_CASE
    $dumpfile("subs4b_tb.vcd");
    $dumpvars(-1,uut);
    #100 $finish;
end

endmodule