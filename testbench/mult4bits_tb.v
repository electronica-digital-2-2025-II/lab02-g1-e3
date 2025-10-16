`include "mult3bits2.v"
`timescale 1ps/1ps


module mult4bits_tb();
    
reg [3:0] MD_tb, MR_tb;
reg clk_tb, init_tb, rst_tb;
wire [7:0] PP_tb;
wire done_tb;
wire overflow_tb;
wire zero_tb;

mult4bits uut (.MD(MD_tb), 
    .MR(MR_tb), 
    .clk(clk_tb), 
    .init(init_tb), 
    .rst(rst_tb), 
    .PP(PP_tb), 
    .done(done_tb),
    .overflow(overflow_tb),
    .zero(zero_tb)
);

always #5 clk_tb = ~clk_tb;

initial begin
    clk_tb = 0;
    rst_tb = 1;
    init_tb = 0;
    #20;
    rst_tb = 0;
    
    MR_tb = 4'b0011;

    MD_tb = 4'b0011;
    
    #10;
    init_tb = 1;

    #20;
    init_tb = 0;

    #90;
    rst_tb=1;
    #20;
    rst_tb = 0;
    MR_tb = 3'b100;
    MD_tb = 3'b110;
    #20;
    init_tb = 1; 
    rst_tb = 0;
    #20;
    init_tb = 0;


    #90;
    rst_tb=1;
    #20;
    rst_tb = 0;
    MR_tb = 3'b110;
    MD_tb = 3'b110;
    #20;
    init_tb = 1; 
    rst_tb = 0;
    #20;
    init_tb = 0;

    #90;
    rst_tb=1;
    #20;
    rst_tb = 0;
    MR_tb = 3'b111;
    MD_tb = 3'b110;
    #20;
    init_tb = 1; 
    rst_tb = 0;
    #20;
    init_tb = 0;

    #90;
    rst_tb=1;
    #20;
    rst_tb = 0;
    MR_tb = 3'b111;
    MD_tb = 3'b111;
    #20;
    init_tb = 1; 
    rst_tb = 0;
    #20;
    init_tb = 0;

end

initial begin: TEST_CASE
    $dumpfile("mult4bits_tb.vcd");
    $dumpvars(-1,uut);
    #800 $finish;
end  
endmodule