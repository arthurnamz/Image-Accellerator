#include<systemc.h>

SC_MODULE(convolution)
{
 
 sc_in<sc_logic> clk;
 
 sc_in<sc_logic> in_ready;
 sc_in<sc_logic> start;
 sc_out<sc_logic> out_valid;
 sc_out<sc_lv<108> > dataOut;

 sc_out<sc_logic> out_ready;
 sc_in<sc_logic> done;
 sc_in<sc_logic> in_valid;
 sc_in<sc_lv<32> > dataIn;
 
 

 

 
 // local variables which are used to store kernel and input data 
    sc_uint<4> kernel[3][3];
    sc_uint<8> input[6][6];
    sc_biguint<32> output[6][6];

 void do_sliding_window();

 SC_CTOR(convolution)
 {
  SC_METHOD(do_sliding_window);
  sensitive << clk.pos();
 }
};
