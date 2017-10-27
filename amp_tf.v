`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:52:02 04/10/2016
// Design Name:   amp
// Module Name:   C:/Xilinx/projects/ece414lab2n3/amp_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: amp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module amp_tf;
	reg clk;
	reg reset;
	reg GO_AMP;
	wire DONE_AMP;
	wire SPI_CLK_AMP;
	wire SPI_MOSI_AMP;
	wire AMP_CS;
	wire AMP_SHDN;
	amp uut (
		.clk(clk), 
		.reset(reset), 
		.GO_AMP(GO_AMP), 
		.DONE_AMP(DONE_AMP), 
		.SPI_CLK_AMP(SPI_CLK_AMP), 
		.SPI_MOSI_AMP(SPI_MOSI_AMP), 
		.AMP_CS(AMP_CS), 
		.AMP_SHDN(AMP_SHDN)
	);
	always
	#5 clk = ~clk;
	initial begin
		clk = 0;
		reset = 1;
		GO_AMP = 0;
		#10 reset = 0;
		#20 GO_AMP = 1; #10 GO_AMP = 0;
	end
      
endmodule

