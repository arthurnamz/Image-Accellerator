
 `timescale 1ns/1ps
    module testbench;
    localparam t = 2;
    parameter ADD_SIZE = 12;
    parameter DATA_SIZE = 108;
    
    reg clk = 0;
    reg rst;
    
    //from memory
    reg write_en;
    reg  in_valid;
    reg [ADD_SIZE-1:0] address_in;
    wire out_ready;
    reg [DATA_SIZE-1:0] dataIn;

    //ports to the memory
    wire write_en_out;
    wire [ADD_SIZE-1:0] address_out;
    //ports from the CPU
    wire [DATA_SIZE-1:0] dataOut;

    write_mem_controller #(.ADD_SIZE(ADD_SIZE),.DATA_SIZE(DATA_SIZE)) write_mem_controller_inst(
    .clk(clk),
    .rst(rst),
    .write_en(write_en),
    .in_valid(in_valid),
    .address_in(address_in),
    .out_ready(out_ready),
    .dataOut(dataOut),
    .write_en_out(write_en_out),
    .address_out(address_out),
    .dataIn(dataIn)
    );

always #(t/2) clk = ~clk;

initial begin
    #1 rst = 1;
    #1 rst = 0;

    #1 write_en = 1;
    #1 in_valid = 1;
    #1 address_in = 12'h000;
    #1 dataIn = 108'h0000;
  
    

    #1 write_en = 1;
    #1 in_valid = 1;
    #1 address_in = 12'h001;
    #1 dataIn = 108'h000115;

    #1 write_en = 1;
    #1 in_valid = 1;
    #1 address_in = 12'h002;
    #1 dataIn = 108'h000117;


    #1 write_en = 1;
    #1 in_valid = 1;
    #1 address_in = 12'h003;
    #1 dataIn = 108'h000120;
  
    
end

initial begin
     #2 $monitor($time," clk = %0d, rst = %0d, write_en = %0d, in_valid = %0d, address_in = %0d, dataIn = %0d, out_ready = %0d, dataOut = %0d, write_en_out = %0d, address_out = %0d",clk,rst,write_en,in_valid,address_in,dataIn,out_ready,dataOut,write_en_out,address_out); 
  #100 $finish;

end
endmodule
