module shift_bi_register(out_0, out_3, clk, rst, in_data, Dir);
  output [3:0] out_0, out_3;
  input rst, clk;
  input [3:0] in_data, Dir;
  wire [3:0] D_0_Q, and_5_out, or_2_out, D_1_Q, and_6_out, or_3_out, and_2_out, or_1_out, D_2_Q, and_4_out, and_3_out, or_0_out, D_3_Q, and_1_out, and_0_out, not_0_out, and_7_out;
  DflipFlop #(4) D_0(D_0_Q, , clk, or_3_out, rst, , );
  assign and_5_out = not_0_out & D_0_Q;
  assign or_2_out = and_4_out | and_5_out;
  DflipFlop #(4) D_1(D_1_Q, , clk, or_2_out, rst, , );
  assign and_6_out = D_1_Q & Dir;
  assign or_3_out = and_6_out | and_7_out;
  assign and_2_out = not_0_out & D_1_Q;
  assign or_1_out = and_1_out | and_2_out;
  DflipFlop #(4) D_2(D_2_Q, , clk, or_1_out, rst, , );
  assign and_4_out = D_2_Q & Dir;
  assign and_3_out = not_0_out & D_2_Q;
  assign or_0_out = and_0_out | and_3_out;
  DflipFlop #(4) D_3(D_3_Q, , clk, or_0_out, rst, , );
  assign out_3 = D_3_Q;
  assign and_1_out = D_3_Q & Dir;
  assign out_0 = D_0_Q;
  assign and_0_out = in_data & Dir;
  assign not_0_out = ~Dir;
  assign and_7_out = in_data & not_0_out;
endmodule

module DflipFlop(q, q_inv, clk, d, a_rst, pre, en);
    parameter WIDTH = 1;
    output reg [WIDTH-1:0] q, q_inv;
    input clk, a_rst, pre, en;
    input [WIDTH-1:0] d;

    always @ (posedge clk or posedge a_rst)
    if (a_rst) begin
        q <= 'b0;
        q_inv <= 'b1;
    end else if (en == 0) ;
    else begin
        q <= d;
        q_inv <= ~d;
    end
endmodule