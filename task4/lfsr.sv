module lfsr (
    input   logic       clk,
    input   logic       rst,
    output  logic [7:1] sreg //no data_out
);

always_ff @ (posedge clk, posedge rst)
    if (rst)
        sreg <= 7'b1;
    else
        sreg <= {sreg[6:1], sreg[7] ^ sreg[3]};
    
//assign data_out = sreg;
endmodule

