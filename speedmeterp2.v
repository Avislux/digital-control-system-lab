`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:24:41 04/18/2016 
// Design Name: 
// Module Name:    speedmeter 
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
module speedmeterp2(
	 output reg [7:0] S,
	 output go;
    input pe,
    input clk, 
	 input reset
    );
	 reg [21:0] MPC; 
	 reg [7:0] Sc; 
	 wire [22:0] MP ;
	 assign MP = 4250000; //255*(1/3000)*50000000
	 //assuming 3 kHz  max freq
	 //50MHz fpga clk
always@(posedge clk)
begin
	if (reset) begin MPC <= 0; Sc <= 0; S <= 0; go<=0; end
	else
	begin
		if (MPC == 0) 
			begin S <= Sc; MPC <= MP; Sc <= 0; go<=1; end
		else
			begin
				go <=0;
				if (pe)
				begin
					Sc <= Sc + 1;
					MPC <= MPC -  1;
				end
				else
					MPC <= MPC - 1;
			end
	end
end
endmodule
