module delay #(
    parameter WIDTH = 7    // no of bits in delay counter
)(
    input   logic               clk,        // clock signal
    input   logic               rst,        // reset signal
    input   logic               trigger,    // trigger input signal

    input   logic [WIDTH-1:0]   K,          // no of clock cycle delay

    output  logic               time_out    // output pulse signal
);
    // Declare counter
    //logic [6:0] K;

    logic [WIDTH-1:0]   count = {WIDTH{1'b0}};            // internal counter

    // Define our states
    typedef enum {IDLE, COUNTING, TIME_OUT, WAIT_LOW}  my_state;
    my_state current_state, next_state;

    // counter
    /*always_ff @ (posedge clk)
    if (rst)
        K <= 7'b1;
    else
        K <= {K[5:0], K[6] ^ K[2]};

    always_ff @(posedge clk)
        if (rst | trigger | count=={WIDTH{1'b0}}) count <= K - 1'b1;
        else                                count <= count - 1'b1;
    
    */

    // state transition
    always_ff @(posedge clk)
        if (rst)    current_state <= IDLE;
        else        current_state <= next_state; 

    // next state logic
    always_comb
        case (current_state)
            IDLE:       if (trigger==1'b1)  next_state = COUNTING;
                        else    next_state = current_state;
            COUNTING:   if (count=={WIDTH{1'b0}}) next_state = TIME_OUT;
                        else    next_state = current_state;
            TIME_OUT:   if (trigger==1'b1)  next_state = WAIT_LOW;
                        else    next_state = IDLE;
            WAIT_LOW:   if (trigger==1'b0)  next_state = IDLE;
                        else    next_state = current_state;
            default: next_state = IDLE;
        endcase
    
    // output logic
    always_comb
        case (current_state)
            IDLE:       time_out = 1'b0;
            COUNTING:   time_out = 1'b0;
            TIME_OUT:   time_out = 1'b1;
            WAIT_LOW:   time_out = 1'b0;
            default:    time_out = 1'b0;
        endcase
endmodule
