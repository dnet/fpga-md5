`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: dnet
// 
// Create Date:    17:06:30 03/16/2008 
// Design Name:    Serial output generator
// Module Name:    serout 
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
module serout(clk, rst, rs232tx, ptdata, en, ready);
    input clk;
	 input rst;
    input en;
    input [127:0] ptdata;
    output rs232tx;
	 output ready;
	 reg ready;
	 
	 wire txbusy;
	 reg txen;
	 reg [7:0] txdata;
	 reg [4:0] sentbytes;
	 reg [7:0] busywait;

	async_transmitter rs232(clk, txen, txdata, rs232tx, txbusy);

always @(posedge clk)
begin
	if (rst)
	begin
		sentbytes<=5'd0;
		txen<=0;
		busywait<=8'd255;
		ready<=0;
	end

	if (en)
	begin
		if (!txbusy & (busywait!=8'd0))
			busywait<=busywait-1;
		else
		begin
			if (sentbytes!=5'd16 & busywait==8'd0)
			begin
				case (sentbytes)
					5'd15: txdata<=ptdata[7:0];
					5'd14: txdata<=ptdata[15:8];
					5'd13: txdata<=ptdata[23:16];
					5'd12: txdata<=ptdata[31:24];
					5'd11: txdata<=ptdata[39:32];
					5'd10: txdata<=ptdata[47:40];
					5'd9: txdata<=ptdata[55:48];
					5'd8: txdata<=ptdata[63:56];
					5'd7: txdata<=ptdata[71:64];
					5'd6: txdata<=ptdata[79:72];
					5'd5: txdata<=ptdata[87:80];
					5'd4: txdata<=ptdata[95:88];
					5'd3: txdata<=ptdata[103:96];
					5'd2: txdata<=ptdata[111:104];
					5'd1: txdata<=ptdata[119:112];
					5'd0: txdata<=ptdata[127:120];
				endcase
				sentbytes<=sentbytes+1;
				txen<=1;
				busywait<=8'd255;
			end
			else
				txen<=0;
		end
	end
	
	ready<=(sentbytes==5'd16) & (busywait==8'd0);
end

endmodule
