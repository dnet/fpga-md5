`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:34 06/21/2008 
// Design Name: 
// Module Name:    ptreg 
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
module ptreg(in, en, out);
    input [127:0] in;
    input en;
    output [127:0] out;
	 reg out;

always @(posedge en)
begin
	out<=in;
end

endmodule
