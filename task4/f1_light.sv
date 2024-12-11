module f1_light (
    input   logic       rst,
    input   logic       clk,

    input   logic       cmd_seq_in,     //mux
    input   logic       cmd_delay_in,   //delay
    input   logic [4:0] clktick_data_in,//clktick 
    input   logic       trigger,        //fsm

    output  logic       cmd_seq_out,    //fsm
    output  logic       cmd_delay_out,  //fsm    
    output  logic [7:0] data_out        //fsm

);

logic [6:0] lsfr_data_out; //lsfr

logic delay_time_out;

logic fsm_en;          //fsm

logic clktick_out;

lfsr lfsr (
    .clk(clk),
    .rst(rst),
    .sreg(lsfr_data_out)
);

clktick clktick(
    .N(clktick_data_in),
    .en(cmd_seq_in),
    .rst(rst),
    .clk(clk),
    .tick(clktick_out)
);

delay delay(
    .K(lsfr_data_out),
    .trigger(cmd_delay_in),
    .rst(rst),
    .clk(clk),
    .time_out(delay_time_out)
);

mux mux(
    .clktick_in(clktick_out),
    .delay_in(delay_time_out),
    .cmd_seq(cmd_seq_in),
    .out(fsm_en)
);

f1_fsm f1_fsm(
    .rst(rst),
    .en(fsm_en),
    .clk(clk),
    .trigger(trigger),
    .cmd_seq(cmd_seq_out),
    .cmd_delay(cmd_delay_out),
    .data_out(data_out)
);
endmodule

