`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: dnet
// 
// Create Date:    15:36:36 03/16/2008 
// Design Name:    Serial input interpreter
// Module Name:    serin 
// Project Name: MPD serial controller
// Target Devices: Xilinx Spartan-3 starter board
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
module serin(clk, rst, rs232rx, md5out, md5valid);
    input clk;
	 input rst;
    input rs232rx;
	 output [127:0] md5out;
	 output md5valid;
	 //output [3:0] rcvdbytes;
	 reg run;
	 reg [127:0] md5out;
	 reg md5valid;
	 reg [3:0] rcvdbytes;

	wire rxready;
	wire [7:0] rxdata;

	async_receiver rs232(clk, rs232rx, rxready, rxdata);

always @(posedge clk)
begin
	if (rst)
	begin
		rcvdbytes<=0;
		md5valid<=0;
		md5out<=128'd0;
	end

	if (rxready & !md5valid)
	begin
		case (rcvdbytes)
			4'd15: md5out[7:0]<=rxdata;
			4'd14: md5out[15:8]<=rxdata;
			4'd13: md5out[23:16]<=rxdata;
			4'd12: md5out[31:24]<=rxdata;
			4'd11: md5out[39:32]<=rxdata;
			4'd10: md5out[47:40]<=rxdata;
			4'd9: md5out[55:48]<=rxdata;
			4'd8: md5out[63:56]<=rxdata;
			4'd7: md5out[71:64]<=rxdata;
			4'd6: md5out[79:72]<=rxdata;
			4'd5: md5out[87:80]<=rxdata;
			4'd4: md5out[95:88]<=rxdata;
			4'd3: md5out[103:96]<=rxdata;
			4'd2: md5out[111:104]<=rxdata;
			4'd1: md5out[119:112]<=rxdata;
			4'd0: md5out[127:120]<=rxdata;
		endcase
		md5valid<=(rcvdbytes==4'd15);
		rcvdbytes<=rcvdbytes+1;
	end
end

endmodule
