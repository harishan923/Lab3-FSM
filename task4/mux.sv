module mux (
    input   logic       clktick_in,
    input   logic       delay_in,
    input   logic       cmd_seq,
    output  logic       out
);

assign out = cmd_seq ? clktick_in : delay_in;

endmodule
