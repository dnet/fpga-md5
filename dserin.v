`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:47 07/15/2008 
// Design Name: 
// Module Name:    dserin 
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
module dserin(clk, rst, rs232rx, md5in, md5valid);
    input clk;
    input rst;
    input rs232rx;
    output [127:0] md5in;
    output md5valid;
    reg [127:0] md5in;
    reg md5valid;
	 
	 reg [3:0] delay;
	 
always @(posedge clk)
begin
	if (rst)
	begin
		delay<=4'd15;
		md5in<=128'd0;
		md5valid<=0;
	end
	else
	begin
		if (delay==4'd0)
		begin
			md5in<=128'hc1fe322e29acdbfd712b43b96247e771;
			md5valid<=1;
		end
		else delay<=delay-1;
	end
end

endmodule
