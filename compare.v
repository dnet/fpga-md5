`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:18 06/21/2008 
// Design Name: 
// Module Name:    compare 
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
module compare(clk, rst, in1, in2, en, cmp);
    input rst;
	 input clk;
	 input [127:0] in1;
    input [127:0] in2;
    input en;
    output cmp;
	 reg cmp;

always @(posedge clk)
begin
	if (rst)
		cmp<=0;
	
	if (en & (in1==in2))
		cmp<=1;
end

endmodule
