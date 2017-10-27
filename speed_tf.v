`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:30:09 04/19/2016
// Design Name:   speedmeter
// Module Name:   C:/Xilinx/projects/ece414lab/speed_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: speedmeter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module speed_tf;
	reg pe;
	reg clk;
	reg signal;
	reg reset;
	wire  [7:0] S;
	speedmeter uut (
		.S(S), 
		.pe(pe), 
		.clk(clk), 
		.signal(signal), 
		.reset(reset)
	);
	always #5 clk = ~clk;
	always #5 signal = ~signal;
	initial begin
		pe = 0;
		clk = 0;
		signal = 0;
		reset = 0;
		#4 reset = 1;
		#10 reset = 0;
		#1000 pe = 1;
		#1000 pe = 0;
	end
endmodule

