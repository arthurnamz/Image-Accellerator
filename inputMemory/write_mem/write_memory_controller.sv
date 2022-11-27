// write memory controller with the following ports 
module write_mem_controller
#(
 parameter ADD_SIZE = 12,
 parameter DATA_SIZE = 108
)
(
 input clk,
 input rst,

 //from memory
 input write_en,
 input  in_valid, 
 input [ADD_SIZE-1:0] address_in,
 output reg out_ready,
 input [DATA_SIZE-1:0] dataIn,
 
 //ports to the memory
 
 output reg write_en_out,
 output reg [ADD_SIZE-1:0] address_out,
 
 //ports from the CPU
 output reg [DATA_SIZE-1:0] dataOut
);

typedef enum{IDLE, WRITE, WAIT, WRITE_RESULT} state_types;
state_types state;

always@(posedge clk)
begin
 if(rst)
   state<= IDLE;
 else
  begin                          
    case(state)
       IDLE:
          if(in_valid)
            state<= WRITE;
       WRITE:
            if(write_en)
                state<= WAIT;
       WAIT:
 	       state <= WRITE_RESULT;

       WRITE_RESULT:
	    state <= IDLE;

    endcase
  end

end

always@(state)
begin
   case(state)
       IDLE:
           begin
                write_en_out <= 1'bz;
                address_out <= 1'bz;
                dataOut <= 108'hzzz;
                out_ready <= 1'b0;
	        end
         WRITE:
              begin
                 write_en_out <= 1'b1;
                 address_out <= address_in;
                 dataOut <= 108'hzzz;
                 out_ready <= 1'b0;
              end
        WAIT:
                begin
                     write_en_out <= 1'bz;
                     address_out <= 1'bz;
                     dataOut <= 108'hzzz;
                     out_ready <= 1'b0;
                end

        WRITE_RESULT:
                begin
                     write_en_out <= 1'b1;
                     address_out <= 1'bz;
                     dataOut <= dataIn;
                     out_ready <= 1'b1;
                end

    endcase

end

endmodule
