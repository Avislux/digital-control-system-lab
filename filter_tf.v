`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:58:28 04/19/2016
// Design Name:   filter
// Module Name:   C:/Xilinx/projects/ece414lab/filter_tf.v
// Project Name:  ece414lab2n3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: filter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module filter_tf;

	// Inputs
	reg clk;
	reg W;

	// Outputs
	wire pe;

	// Instantiate the Unit Under Test (UUT)
	filter uut (
		.clk(clk), 
		.W(W), 
		.pe(pe)
	);
	always #5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		W = 0;

		// Wait 800 ns for global reset to finish
		#10 W = 1; 
		#20 W = 0; 
      #10 W = 1; 
		#20 W = 0; 
		#10 W = 1; 
		#20 W = 0; 		
		#300 W = 1;
		#300 W = 0;
		#10 W = 1; #10 W = 0;
		#10 W = 1; #10 W = 0;
		#10 W = 1; #10 W = 0;
		#10 W = 1; #10 W = 0;
		#10 W = 1; #10 W = 0;
		#80 W = 1; #80 W = 0;
		#80 W = 1; #80 W = 0;
		#80 W = 1; #80 W = 0;
		#80 W = 1; #80 W = 0;
		#80 W = 1; #80 W = 0;
		#80 W = 1; #80 W = 0;
		
		// Add stimulus here

	end
      
endmodule

