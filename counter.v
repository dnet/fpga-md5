`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:25 07/15/2008 
// Design Name: 
// Module Name:    counter 
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
module counter(clk, rst, en, q, overflow, afterburn);
    input clk;
    input rst;
    input en;
    output [127:0] q;
    reg [127:0] q;
	 output overflow;
	 reg overflow;
	 output afterburn;
	 reg afterburn;

always @(posedge clk) // 97=a 122=z
begin
	
	if (rst)
	begin
		//       1 2 3 4 5 6 7 8 9 0 A B C D E F
		q<=128'h00000000000000000000006161616161;
		overflow<=0;
	end
	
	if (!en)
		afterburn<=0;
	
	if (en & !overflow& !afterburn)
	begin
		afterburn<=1;
		q[127:40]<=88'd0;
		if (q[7:0]!=8'd122)
			q[7:0]<=q[7:0]+1;
		else
		begin
			q[7:0]<=8'd97;
			if (q[15:8]!=8'd122)
				q[15:8]<=q[15:8]+1;
			else
			begin
				q[15:8]<=8'd97;
				if (q[23:16]!=8'd122)
					q[23:16]<=q[23:16]+1;
				else
				begin
					q[23:16]<=8'd97;
					if (q[31:24]!=8'd122)
						q[31:24]<=q[31:24]+1;
					else
					begin
						q[31:24]<=8'd97;
						if (q[39:32]!=8'd122)
							q[39:32]<=q[39:32]+1;
						else
						begin
							q[39:32]<=8'd97;
							overflow<=1;
						end
					end
				end
			end
		end
	end
end

endmodule
