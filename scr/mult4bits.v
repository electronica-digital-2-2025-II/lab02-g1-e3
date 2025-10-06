module mult4bits(
    input [3:0] MD,        // Multiplicand
    input [3:0] MR,        // Multiplier  
    input clk,
    input init,
    input rst, 
    output reg [7:0] PP,   // Product (6 bits)
    output reg done,
    output reg overflow,
    output reg zero
);

    // Estados
    localparam START = 3'b000;
    localparam CHECK = 3'b001;
    localparam ADD   = 3'b010;
    localparam SHIFT = 3'b011;
    localparam END1  = 3'b100; 

    reg [2:0] fsm_state, next_state;
    reg [3:0] A;          // Multiplicand register
    reg [3:0] B;          // Multiplier register
    reg [1:0] shift_count; // lleva cuántos bits procesados (0..2)

    // Estado secuencial
    always @(posedge clk or posedge rst) begin
        if(rst)
            fsm_state <= START;
        else
            fsm_state <= next_state;
    end

    // Lógica de transición
    always @(*) begin
        case (fsm_state)
            START: next_state = init ? CHECK : START;
            CHECK: next_state = B[0] ? ADD : SHIFT;
            ADD:   next_state = SHIFT;
            SHIFT: next_state = (shift_count == 2) ? END1 : CHECK;
            END1:  next_state = START;
            default: next_state = START;
        endcase
    end

    // Datapath y control
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PP <= 8'b0;
            A <= 4'b0;
            B <= 4'b0;
            shift_count <= 0;
            done <= 0;
            overflow <= 0;
            zero <= 0;
        end else begin 
            case (fsm_state)
                START: begin
                    if (init) begin
                        PP <= 8'b0;
                        A <= MD;        
                        B <= MR;        
                        shift_count <= 0;
                        done <= 0;
                        overflow <= 0;
                        zero <= 0;
                    end
                end

                CHECK: begin
                    // nada, solo transición
                end

                ADD: begin
                    // suma el multiplicando desplazado según shift_count
                    PP <= PP + (A << shift_count);
                end

                SHIFT: begin
                    B <= B >> 1;           // siguiente bit del multiplicador
                    shift_count <= shift_count + 1;
                end

                END1: begin
                    done <= 1;
                    zero <= (PP==0);
                    overflow <=(PP > 8'd225);
                end
            endcase
        end
    end
endmodule