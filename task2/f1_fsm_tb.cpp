#include "Vf1_fsm.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"


int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vf1_fsm* top = new Vf1_fsm;
    //init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top-> trace (tfp, 99);
    tfp-> open ("f1_fsm.vcd");

    // init vbuddy
    if (vbdOpen()!=1) return(-1);
    vbdHeader("F1 Light");

    //initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;

    //run sim

    for (i=0; i<1000000; i++) {
        // dump var toggle clock
        for (clk=0; clk<2; clk++){
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();
        }
    
    vbdBar(top->data_out & 0xFF);
    vbdCycle(i);
    // end of vbud out
    // either simulation finished, or 'q' is pressed
    if ((Verilated::gotFinish()) || (vbdGetkey()=='s')) 
      exit(0);                // ... exit if finish OR 'q' pressed
    
}

  vbdClose();     // ++++
  tfp->close(); 
  exit(0);
}