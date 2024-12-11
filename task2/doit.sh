#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f sinegen.vcd

# run Verilator to translate Verilog into Cpp including test bench
verilator -Wall --cc --trace f1_fsm.sv --exe f1_fsm_tb.cpp

# build Cpp proj via make autogen'd by verilator
#multithreading disabled

make -C obj_dir/ -f Vf1_fsm.mk Vf1_fsm

# run executable sim file
obj_dir/Vf1_fsm