`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:26:22 04/08/2016
// Design Name:   b2bcd
// Module Name:   C:/Xilinx/projects/ece414lab2n3/b2bcd_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: b2bcd
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module b2bcd_tf;
	reg clk;
	reg [7:0] T;
	reg [7:0] L;
	wire [11:0] DT;
	wire [11:0] DL;

	b2bcd uut (
		.clk(clk), 
		.T(T), 
		.L(L), 
		.DT(DT), 
		.DL(DL)
	);
	always
	#5 clk = ~clk;
	initial begin
		clk = 0;
		T = 0;
		L = 0;
		#1 T = 123; L = 255;
		#100 T = 9; L = 231;
		#100 T = 0; L = 100;
		#100 T = 40; L = 199;
	end
endmodule

