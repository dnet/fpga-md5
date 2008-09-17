`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:29 07/15/2008 
// Design Name: 
// Module Name:    dpancham 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dpancham (
        clk
      , reset	
      , msg_in
      , msg_in_width
      , msg_in_valid

      , msg_output
      , msg_out_valid
      , ready
      );

input          clk;                      // input clock
input          reset;                    // global reset
input  [0:127] msg_in;                   // input message, max width = 128 bits
input    [0:7] msg_in_width;             // actual input message width
input          msg_in_valid;             // input message is valid, active high
                                       
output [0:127] msg_output;               // output message, always 128 bit wide
output         msg_out_valid;            // if asserted, output message is valid
output         ready;                    // the core is ready for an input message

reg [0:127] msg_output;               // output message, always 128 bit wide
reg         msg_out_valid;            // if asserted, output message is valid
reg         ready;                    // the core is ready for an input message

reg [3:0] intcounter;

always @(posedge clk)
begin
	if (reset)
	begin
		msg_output<=128'd0;
		msg_out_valid<=0;
		ready<=1;
		intcounter<=4'd0;
	end
	else
	if (intcounter==4'd15)
	begin
		msg_output<=128'hfba2fdaf36fdf1931d552535a57eb984;
		msg_out_valid<=1;
		intcounter<=4'd0;
	end
	else
	if (intcounter==4'd0)
	begin
		msg_out_valid<=0;
		msg_output<=128'd0;
		if (msg_in_valid)
		begin
			intcounter<=4'd1;
			ready<=0;
		end
		else
			ready<=1;
	end
	else
		intcounter<=intcounter+1;
end

endmodule
