// write memory controller with the following ports 
module read_memory_controller
#(
 parameter ADD_SIZE = 12,
 parameter DATA_SIZE = 108
)
(
 input clk,
 input rst,

 //from memory
 input read_en,
 input [ADD_SIZE-1:0] address_in,
 output reg [DATA_SIZE-1:0] dataOut,
 output  reg out_valid, 
 input in_ready,
 
 //ports to the memory
 
 output reg read_en_out,
 output reg [ADD_SIZE-1:0] address_out,
 
 //ports from the CPU
 input [DATA_SIZE-1:0] dataIn
);

typedef enum{IDLE, READ, WAIT, RETURN_RESULT} state_types;
state_types state;

always@(posedge clk)
begin
 if(rst)
   state<= IDLE;
 else
  begin                          
    case(state)
       IDLE:
          if(in_ready)
            state<= READ;
       READ:
            if(read_en)
                state<= WAIT;
       WAIT:
 	       state <= RETURN_RESULT;

       RETURN_RESULT:
	    state <= IDLE;

    endcase
  end

end

always@(state)
begin
   case(state)
       IDLE:
           begin
                read_en_out <= 1'b0;
                address_out <= 12'bz;
                dataOut <= 108'hzzz;
                out_valid <= 1'b0;
	        end
         READ:
              begin
                     read_en_out <= 1'b1;
                     address_out <= address_in;
                     address_out <= dataIn;
                     out_valid <= 1'b0;
              end
        WAIT:
                begin
                     read_en_out <= 1'bz;
                     address_out <= 12'hzz;
                     dataOut <= 108'hzzz;
                     out_valid <= 1'b0;
                end

        RETURN_RESULT:
                begin
                     read_en_out <= 1'b1;
                     address_out <= address_in;
                     dataOut <= address_out;
                     out_valid <= 1'b1;
                end

    endcase

end

endmodule
