// implementation of wrapper which wraps the dual output ram and the two memory controllers
module input_ram_wrapper 
#
(
    parameter ADD_SIZE = 11,
    parameter DATA_SIZE = 32
)
(
    input  clk,
    input  rst,
    input  in_valid,
    input  in_ready,
    input  write_en,
    input [ADD_SIZE-1:0]write_address,
    input read_en,
    input [ADD_SIZE-1:0] read_address,
    input [DATA_SIZE-1:0] dataIn,
    output reg [DATA_SIZE-1:0] dataOut,
    output reg out_valid,
    output reg out_ready
);
 

    wire [ADD_SIZE-1:0] connect_write_address;
    wire [DATA_SIZE-1:0] connect_write_dataIn;
    wire connect_write_enable;
    wire connect_read_enable;
    wire [ADD_SIZE-1:0] connect_read_address;
    wire [DATA_SIZE-1:0] connect_read_dataOut;
    wire connect_in_ready;
    wire connect_out_valid;
    wire [DATA_SIZE-1:0] connect_dataOut;


    // instantiate write memory controller
    write_memory_controller #(.ADD_SIZE(ADD_SIZE),.DATA_SIZE(DATA_SIZE)) write_memory_controller_inst (
        .clk(clk),
        .rst(rst),
        .in_valid(in_valid),
        .dataIn(dataIn),
        .address_in(write_address),
        .dataOut(connect_write_dataIn),
        .out_ready(out_ready),
        .address_out(connect_write_address),
        .write_en_out(connect_write_enable),
        .write_en(write_en)
    );

  

    //instatiate input memory 
    input_memory #(.ADD_SIZE(ADD_SIZE),.DATA_SIZE(DATA_SIZE)) input_memory_inst (
        .clk(clk),
        .rst(rst),
        .read_en(connect_read_enable),
        .write_en(connect_write_enable),
        .write_address(connect_write_address),
        .write_data_in(connect_write_dataIn),
        .read_address(connect_read_address),
        .read_data_out(connect_read_dataOut)
    );

    //instatiate read memory controller
    read_memory_controller #(.ADD_SIZE(ADD_SIZE),.DATA_SIZE(DATA_SIZE)) read_memory_controller_inst (
        .clk(clk),
        .rst(rst),
        .read_en(read_en),
        .read_en_out(connect_read_enable),
        .address_in(read_address),
        .dataOut(dataOut),
        .out_valid(out_valid),
        .in_ready(in_ready),
        .address_out(connect_read_address),
        .dataIn(connect_read_dataOut)
    );


endmodule
