`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:40:40 04/08/2016
// Design Name:   ampAdcController
// Module Name:   C:/Xilinx/projects/ece414lab2n3/controller_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ampAdcController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controller_tf;
	reg clk;
	reg DONE_AMP;
	reg DONE_ADC;
	reg [7:0] ADC0, ADC1;
	wire GO_AMP;
	wire GO_ADC;
	wire [7:0] T;
	wire [7:0] L;
	wire [1:0] select;
	ampAdcController uut (
		.clk(clk), 
		.GO_AMP(GO_AMP), 
		.GO_ADC(GO_ADC), 
		.T(T), 
		.L(L), 
		.select(select), 
		.DONE_AMP(DONE_AMP), 
		.DONE_ADC(DONE_ADC),
		.ADC0(ADC0),
		.ADC1(ADC1)
	);
	always
	#5 clk = ~clk;
	initial begin
		clk = 0;
		DONE_AMP = 0;
		DONE_ADC = 0;
		ADC0=100; ADC1=230;
		#71 DONE_AMP = 1;
		#70 DONE_ADC = 1;
	end     
endmodule

