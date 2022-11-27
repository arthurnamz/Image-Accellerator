(* SC_MODULE_EXPORT *)
module convolution
(
  
 input clk,
 
 input in_ready,
 input start,
 output out_valid,
 output [107:0] dataOut,

 output out_ready,
 input done,
 input in_valid,
 input [31:0] dataIn
);
endmodule
