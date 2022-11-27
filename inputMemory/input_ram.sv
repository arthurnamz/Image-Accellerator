module input_memory
 #
 (
   parameter ADD_SIZE = 12,
   parameter DATA_SIZE = 108
 )
 (
   input clk, 
   input rst,

   // write interface on port
   input write_en,
   input [DATA_SIZE-1:0] write_data_in,
   input [ADD_SIZE-1:0] write_address,

   // read interface on port 2
   input read_en,
   input [ADD_SIZE-1:0] read_address,
   output reg [DATA_SIZE-1:0] read_data_out
 );

//memory declaration.
reg [DATA_SIZE-1:0] ram[0:4095];

//writing to the RAM

always@(posedge clk)
begin
    if(rst)
       ram[write_address] <= 'bz;
     else
        begin
        if(write_en)
           ram[write_address]<=write_data_in;
        end

end

//Read to the RAM

always@(posedge clk)
begin
    if(rst)
       read_data_out <= 'bz;
     else
        begin
           if(read_en)
                read_data_out<=ram[read_address];
        end

end
endmodule

