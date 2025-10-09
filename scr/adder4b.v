

module  adder4b (
    input[3:0] A,
    input [3:0] B,
    input Ci,
    output [3:0] S,
    output Co,
    output overflow,
    output zero
);

wire c0; 
wire c1; 
wire c2;

adder bit0(.A(A[0]), .B(B[0]), .Ci(1'b0), .S(S[0]), .Co(c0));
adder bit1(.A(A[1]), .B(B[1]), .Ci(c0), .S(S[1]), .Co(c1));
adder bit2(.A(A[2]), .B(B[2]), .Ci(c1), .S(S[2]), .Co(c2));
adder bit3(.A(A[3]), .B(B[3]), .Ci(c2), .S(S[3]), .Co(Co));
assign zero = (S == 4'b0000);

endmodule