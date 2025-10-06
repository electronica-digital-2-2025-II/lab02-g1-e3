`timescale 1ns / 1ps

module alu4b(
    input [3:0] A,
    input [3:0] B,
    input [2:0] sel,   // Selecciona la operación
    input clk,
    input init,
    input rst,
    output reg [7:0] Y,
    output reg zero,
    output reg overflow,
    output reg done
);

    // Señales internas
    wire [3:0] sum_res, sub_res;
    wire [7:0] mul_res;
    wire sum_zero, sub_zero, mul_zero;
    wire sum_over, sub_over, mul_over, mul_done;

    // SUMA
    adder4b SUMA (
        .A(A),
        .B(B),
        .Ci(1'b0),
        .S(sum_res),
        .Co(),
        .overflow(sum_over),
        .zero(sum_zero)
    );

    // RESTA
    subs4b RESTA (
        .A(A),
        .B(B),
        .Ci(1'b0),
        .S(sub_res),
        .Co(),
        .overflow(sub_over),
        .zero(sub_zero)
    );

    // MULTIPLICACIÓN
    mult4bits MULT (
        .MD(A),
        .MR(B),
        .clk(clk),
        .init(init),
        .rst(rst),
        .PP(mul_res),
        .done(mul_done),
        .overflow(mul_over),
        .zero(mul_zero)
    );

    // MUX de selección de operación
    always @(*) begin
        case (sel)
            3'b000: begin // SUMA
                Y = {4'b0000, sum_res};
                zero = sum_zero;
                overflow = sum_over;
                done = 1'b1;
            end
            3'b001: begin // RESTA
                Y = {4'b0000, sub_res};
                zero = sub_zero;
                overflow = sub_over;
                done = 1'b1;
            end
            3'b010: begin // MULTIPLICACIÓN
                Y = mul_res;
                zero = mul_zero;
                overflow = mul_over;
                done = mul_done;
            end
            3'b011: begin // OR
                Y = {4'b0000, (A | B)};
                zero = ((A | B) == 0);
                overflow = 0;
                done = 1'b1;
            end
            3'b100: begin // SHIFT LEFT
                Y = {4'b0000, (A << 1)};
                zero = ((A << 1) == 0);
                overflow = 0;
                done = 1'b1;
            end
            default: begin
                Y = 0;
                zero = 1;
                overflow = 0;
                done = 0;
            end
        endcase
    end

endmodule


