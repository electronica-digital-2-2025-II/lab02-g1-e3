`include "shift_bi_register.v"
`timescale 1ps/1ps
module shift_bi_register_tb();

  reg rst, clk;
  reg [3:0] in_data, Dir;

  wire [3:0] out_0, out_3;

  shift_bi_register DUT0(out_0, out_3, clk, rst, in_data, Dir);

  always begin
    #10
    clk = 0;
    #10
    clk = 1;
  end

  initial begin
    rst = 0;
    in_data = 0;
    Dir = 0;

    #15
    $display("out_0 = %b", out_0);
    $display("out_3 = %b", out_3);

    #10
    $display("out_0 = %b", out_0);
    $display("out_3 = %b", out_3);

    $finish;

  end


endmodule