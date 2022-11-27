
 `timescale 1ns/1ps
    module testbench;
    localparam t = 2;
    parameter ADD_SIZE = 12;
    parameter DATA_SIZE = 108;
    
    reg  clk=0;
    reg  rst;
    reg  in_valid;
    reg  in_ready;
    reg  write_en;
    reg [ADD_SIZE-1:0] write_address;
    reg read_en;
    reg [ADD_SIZE-1:0] read_address;
    reg [DATA_SIZE-1:0] dataIn;
    wire [DATA_SIZE-1:0] dataOut;
    wire out_valid;
    wire out_ready;

    input_ram_wrapper  #(.ADD_SIZE(ADD_SIZE),.DATA_SIZE(DATA_SIZE)) input_ram_wrapper_inst(
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_address(read_address),
    .write_en(write_en),
    .write_address(write_address),
    .out_valid(out_valid),
    .out_ready(out_ready),
    .in_ready(in_ready),
    .in_valid(in_valid),
    .dataIn(dataIn),
    .dataOut(dataOut)
    );

always #(t/2) clk = ~clk;

initial begin
    #1 rst = 1;
    #1 rst = 0;

    #1 write_en = 1;
    #1 in_valid = 1;
    #1 write_address = 12'h000;
    #1 dataIn = 108'h0000;
  
    #4 read_en = 1;
   #4 in_ready = 1;
   #4 read_address = 12'h000;

    #1 write_en = 1;
    #1 in_valid = 1;
    #1 write_address = 12'h001;
    #1 dataIn = 108'h00124;
   
   #4 read_en = 1;
   #4 in_ready = 1;
   #4 read_address = 12'h001;

    

    #1 write_en = 1;
    #1 in_valid = 1;
    #1 write_address = 12'h002;
    #1 dataIn = 108'h00165;



   #4 read_en = 1;
   #4 in_ready = 1;
   #4 read_address = 12'h002;
   
end

initial begin
     #4 $monitor($time," write_address = %0d, dataIn = %0d, read_address = %0d, out_valid = %0d, out_ready = %0d, DataOut = %0d",write_address, dataIn, read_address, out_valid, out_ready, dataOut); 
  #100 $finish;

end
endmodule
