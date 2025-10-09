`timescale 1ps/1ps

module alu4b_tb();

    reg [3:0] A, B;
    reg [2:0] sel;
    reg clk, init, rst;
    wire [7:0] Y;
    wire zero, overflow, done;

    alu4b uut (
        .A(A), .B(B), .sel(sel),
        .clk(clk), .init(init), .rst(rst),
        .Y(Y), .zero(zero), .overflow(overflow), .done(done)
    );

    // Reloj: periodo 10 ps (porque timescale es 1ps)
    initial clk = 0;
    always #5 clk = ~clk;

    // VCD
    initial begin
        $dumpfile("alu4b_tb.vcd");
        $dumpvars(0, alu4b_tb);
    end

    initial begin
        // Reset
        rst = 1; init = 0; A = 0; B = 0; sel = 0;
        #20; rst = 0;

        // --- SUMA (3 + 5 = 8 -> 0x08) ---
        sel = 3'b000; A = 4'b0011; B = 4'b0101;
        @(posedge clk);

        // --- RESTA (6 - 3 = 3 -> 0x03) ---
        sel = 3'b001; A = 4'b0110; B = 4'b0011;
        @(posedge clk);

        // --- MULT (3 * 4 = 12 -> 0x0C) ---
        sel = 3'b010; A = 4'b0011; B = 4'b0100;
        init = 1; @(posedge clk); init = 0;  // pulso de 1 ciclo sincronizado
        wait (done == 1);                     // espera resultado válido
        @(posedge clk);                       // margen para verlo estable

        // --- OR (5 | 3 = 7 -> 0x07) ---
        sel = 3'b011; A = 4'b0101; B = 4'b0011;
        @(posedge clk);

        // --- SHL (5 << 1 = 10 -> 0x0A) ---
        sel = 3'b100; A = 4'b0101; B = 4'b0000;
        @(posedge clk);

        #20; $finish;
    end
endmodule
