`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:50 04/12/2016 
// Design Name: 
// Module Name:    pwm 
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
module pwm(
    input clk,  
    input [7:0] PW,
    output reg PWM
    );
	 reg [4:0] IC;
	 reg [7:0] PC;
initial IC = 0;
initial PC = 0;
always@(posedge clk)
begin
	if (PW==0)
		PWM <= 0;
	else
	begin
		if (PW == 255)
			PWM <=1;
		else
		begin
			if (IC == 0)
			begin
				if (PC < PW) begin PC <= PC +1; IC <= 18; PWM <= 1; end
				else begin PC <= PC +1; IC <= 18; PWM <= 0; end
			end
			else
				IC <= IC - 1;
		end
	end
end
endmodule
