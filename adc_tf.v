`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:01:08 04/10/2016
// Design Name:   adc
// Module Name:   C:/Xilinx/projects/ece414lab2n3/adc_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adc_tf;
	reg clk;
	reg GO_ADC;
	reg reset;
	reg SPI_MISO;
	wire DONE_ADC;
	wire ADC_CONV;
	wire [7:0] ADC0;
	wire [7:0] ADC1;
	wire SPI_CLK_ADC;
	adc uut (
		.clk(clk), 
		.GO_ADC(GO_ADC), 
		.reset(reset), 
		.SPI_MISO(SPI_MISO), 
		.DONE_ADC(DONE_ADC), 
		.ADC_CONV(ADC_CONV), 
		.ADC0(ADC0), 
		.ADC1(ADC1), 
		.SPI_CLK_ADC(SPI_CLK_ADC)
	);
	always
	#5 clk = ~clk;
	initial begin
		clk = 0;
		GO_ADC = 0;
		reset = 1;
		SPI_MISO = 0;
		#10 reset = 0;
      #21 GO_ADC = 1;
		#5 GO_ADC = 0;
		#50 SPI_MISO = 1;
		#10 SPI_MISO = 0;
		#20 SPI_MISO = 1;
		#10 SPI_MISO = 0;
		#10 SPI_MISO = 1;
		#40 SPI_MISO = 0;
	end
      
endmodule

