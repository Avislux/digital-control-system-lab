`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:44:18 04/12/2016
// Design Name:   ampadc
// Module Name:   C:/Xilinx/projects/ece414lab/ampadc_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ampadc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ampadc_tf;

	// Inputs
	reg clk;
	reg reset;
	reg SPI_MISO;
	reg signal;
	reg [7:0]PW;
	// Outputs
	wire PWM;
	wire SPI_MOSI;
	wire SPI_CLK;
	wire ADC_CONV;
	wire AMP_SHDN;
	wire AMP_CS;
	wire DAC_CS;
	wire SPI_SS_B;
	wire SF_CE0;
	wire FPGA_INIT_B;
	wire [3:0] dataout;
	wire [2:0] control;

	// Instantiate the Unit Under Test (UUT)
	topampadc uut (
		.clk(clk), 
		.reset(reset), 
		.SPI_MISO(SPI_MISO), 
		.SPI_MOSI(SPI_MOSI), 
		.SPI_CLK(SPI_CLK), 
		.ADC_CONV(ADC_CONV), 
		.AMP_SHDN(AMP_SHDN), 
		.AMP_CS(AMP_CS), 
		.DAC_CS(DAC_CS), 
		.SPI_SS_B(SPI_SS_B), 
		.SF_CE0(SF_CE0), 
		.FPGA_INIT_B(FPGA_INIT_B), 
		.dataout(dataout), 
		.control(control),
		.PW(PW),
		.PWM(PWM),
		.signal(signal)
	);
	always begin
	#5 clk=~clk;  end    
	always #30 SPI_MISO = ~SPI_MISO;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		SPI_MISO = 0;
		signal = 0;
		PW = 64;
		// Wait 100 ns for global reset to finish
		#600;
		/*
      #30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;
		#30 SPI_MISO = ~SPI_MISO;*/
		// Add stimulus here
	
	end
  
endmodule

