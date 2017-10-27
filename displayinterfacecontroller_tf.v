`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:57:10 04/10/2016
// Design Name:   top
// Module Name:   C:/Xilinx/projects/ece414lab2n3/displayinterfacecontroller_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module displayinterfacecontroller_tf;

	reg clk;
	reg [1:0] s;

	wire [3:0] E;
	wire [6:0] sevenSeg;
	wire DP;

	top uut (
		.clk(clk), 
		.s(s), 
		.E(E), 
		.sevenSeg(sevenSeg), 
		.DP(DP)
	);
	always 
	#5 clk = ~clk;
	initial begin
		clk = 0;
		s = 0;
		#10000000 s = 1;
		#10000000 s = 2;
		#10000000 s = 3;
		#10000000 s = 0;       
	end     
endmodule

