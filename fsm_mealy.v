module xi_nhan (
    input wire clk_div,
    input wire aresetn,
    input wire switch, // 0 : LEFT & 1 : RIGHT

    output reg[5:0] LED
);

reg[2:0] state_reg, state_next;

localparam IDLE   = 3'd0;
localparam STEP1  = 3'd1;
localparam STEP2  = 3'd2;
localparam STEP3  = 3'd3;


always @(posedge clk_div or negedge aresetn) begin
    if (~aresetn) begin
        state_reg <= IDLE;
    end 
    else if(aresetn) begin
        state_reg <= state_next;
    end 
end

always @(*) begin
    // gia tri mac dinh
    state_next = state_reg;
    LED = 6'b000000;
    
    case (state_reg)

        IDLE: begin
            LED   = 6'b000000;
            state_next = STEP1;
            end

        STEP1: begin
            if (switch) begin
                LED = 6'b000001;
            end
            else begin
                LED = 6'b001000;
            end
            state_next = STEP2;
        end

        STEP2: begin
            if (switch) begin
                LED = 6'b000011;
            end
            else begin
                LED = 6'b011000;
            end
            state_next = STEP3;
        end

        STEP3: begin
            if (switch) begin
                LED = 6'b000111;
            end
            else begin
                LED = 6'b111000;
            end
            state_next = IDLE;
        end
    endcase
end
    
endmodule

