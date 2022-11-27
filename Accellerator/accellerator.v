module cnvcp(
input clk,
input rst,
input  target_ready,
input  source_valid,
output reg ready,
output reg valid,
input [107:0] dataIn,
output reg [31:0] dataOut
);
 
//reg [35:0] kernel;
//reg [71:0] pixel;
reg [3:0] k[8:0];
reg [7:0] p[8:0];
reg [31:0] out;


reg [1:0] state;
localparam IDLE=2'b00, READING=2'b01, WRITING=2'b10, COMPUTING=2'b11;

always@(state)
begin
  case(state)
     IDLE:
           begin
             ready <= 1;
             valid <= 0;
           end

     READING:
            begin
	      ready <= 0;
              valid <= 0;
            	
            end

     COMPUTING:
            begin
	      ready <= 0;
              valid <= 0;
            end

     WRITING:
          begin
	     valid <= 1;
             ready <= 0;
              
          end 
  endcase
end
always@(posedge clk)
begin
 if(rst)
   begin
     state<=IDLE;
     valid <= 0;
     ready <= 1;
   end
 else
   begin
     case(state)
       IDLE:
           begin
           
                if(source_valid)
                 state <= READING;
  
           end

       READING:
            begin
	
	       //kernel <= dataIn [107:72];
               //pixel <= dataIn [71:0];

	       k[0] <=  dataIn[107:104];  
	       k[1] <= dataIn[103:100];  
	       k[2] <= dataIn[99:96];  
	       k[3] <= dataIn[95:92];
 	       k[4] <= dataIn[91:88];  
	       k[5] <= dataIn[87:84];  
	       k[6] <= dataIn[83:80];
  	       k[7] <= dataIn[79:76];
 	       k[8] <= dataIn[75:72];

               p[0] <= dataIn[71:64];  
	       p[1] <= dataIn[63:56]; 
	       p[2] <= dataIn[55:48];  
	       p[3] <= dataIn[47:40];
 		p[4] <= dataIn[39:32];  
   		p[5] <= dataIn[31:24];  
		p[6] <= dataIn[23:16];  
		p[7] <= dataIn [15:8];
 		p[8] <= dataIn[7:0];

               state <= COMPUTING;	
            end

       COMPUTING:
            begin
	 
	      out <= (k[0]*p[0]) + (k[1]*p[1]) + (k[2]*p[2]) +  (k[3]*p[3]) + (k[4]*p[4]) + (k[5]*p[5]) + (k[6]*p[6]) + (k[7]*p[7]) + (k[8]*p[8]);//changed	
                            dataOut <= out;
             if(target_ready)
             begin
             //valid <= 1; 
              dataOut <= out;
             state <= WRITING;
          
             end
            end

       WRITING:
          begin
	    
             if(~target_ready)
                
               state <= IDLE;		
          end 
     endcase
   end
end

endmodule



