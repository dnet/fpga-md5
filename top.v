`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:55:51 06/21/2008 
// Design Name: 
// Module Name:    top 
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
module top(clk, rst, rs232rx, rs232tx, leds);
    input clk;
    input rst;
    input rs232rx;
    output rs232tx;
	 output [7:0] leds;

	wire [127:0] curpt; // current plaintext
	wire [127:0] md5in; // md5 to break (read from rs232)
	wire md5valid; // md5in is valid
	wire [127:0] curmd5; // md5 hash of curpt
	wire md5cvalid; // curmd5 is valid
	wire overflow; // counter overflow
	wire cmpout; // comparator output (1=hash has been broken)
	wire md5ready; // pancham is ready
	wire afterburn; // counter tick


	compare comparator(clk, rst, md5in, curmd5, md5cvalid, cmpout);
	
	counter cnt(clk, rst, md5ready & md5valid & !cmpout, curpt, overflow, afterburn);

	serin si(clk, rst, rs232rx, md5in, md5valid);

	serstream so(clk, rst, rs232tx, curpt, cmpout, overflow);
	
	pancham pm(clk, rst, curpt, 8'd40, afterburn, curmd5, md5cvalid, md5ready);
	
	assign leds={md5ready, md5valid, md5cvalid, overflow, cmpout, clk, rst, rs232rx};
	
endmodule
