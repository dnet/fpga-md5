`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:26 07/15/2008 
// Design Name: 
// Module Name:    serstream 
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
module serstream(clk, rst, rs232tx, ptdata, found, overflow);
    input clk;
    input rst;
    output rs232tx;
    input [127:0] ptdata;
    input found;
    input overflow;

	wire coreready;
	reg coreen;
	reg [127:0] coretext;
	reg corerst;
	reg outputlock;
	reg finaltextdone;
	reg foundtext;

	serout score(clk, corerst, rs232tx, coretext, coreen, coreready);
	
	always @(posedge clk)
	begin
		if (rst)
		begin
			corerst<=1;
			finaltextdone<=0;
			foundtext<=0;
			outputlock<=1;
			//             \n M D 5 _ r e a d y \nH a s h :
			coretext<=128'h0a4d44352072656164790a486173683a;
		end
			
		if (overflow & !finaltextdone)
		begin
			corerst<=1;
			finaltextdone<=1;
			outputlock<=1;
			//             \n[ E n d _ o f _ d o m a i n ]
			coretext<=128'h0a5b456e64206f6620646f6d61696e5d;
		end

		if (found & !outputlock & !rst & !finaltextdone)
		begin
			corerst<=1;
			outputlock<=1;
			if (foundtext)
			begin
				coretext<={ptdata[7:0], ptdata[15:8], ptdata[23:16], ptdata[31:24], ptdata[39:32], 88'h2020202020202020202020};
				finaltextdone<=1;
			end
			else
				//             \nG o t _ p l a i n t e x t : _
				coretext<=128'h0a476f7420706c61696e746578743a20;
		end

		if (outputlock & !rst)
		begin
			if (coreready)
			begin
				if (coreen)
				begin
					coreen<=0;
					corerst<=1;
				end
				else
				begin
					corerst<=0;
					outputlock<=0;
					if (found)
						foundtext<=1;
				end
			end
			else
			begin
				corerst<=0;
				coreen<=1;
			end
		end		
	end
endmodule
