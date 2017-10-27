`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:40:54 04/19/2016
// Design Name:   pwm
// Module Name:   C:/Xilinx/projects/ece414lab/pwm_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pwm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pwm_tf;
	reg clk;
	reg [7:0] PW;
	wire PWM;
	pwm uut (
		.clk(clk), 
		.PW(PW), 
		.PWM(PWM)
	);
	always #5 clk = ~clk;
	initial begin
		clk = 0;
		PW = 0;
		#2000 PW = 255;
		#1000 PW = 0;
		#3000 PW = 64;
	end
endmodule

