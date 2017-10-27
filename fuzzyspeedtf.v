`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:28:28 05/16/2016
// Design Name:   fuzzylogicspeedcontroller
// Module Name:   C:/Xilinx/projects/ece414lab/fuzzyspeedtf.v
// Project Name:  ece414lab
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fuzzylogicspeedcontroller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fuzzyspeedtf;

	// Inputs
	reg [7:0] R;
	reg [7:0] C;
	reg go;
	reg clk;

	// Outputs
	wire [7:0] pw;

	// Instantiate the Unit Under Test (UUT)
	fuzzylogicspeedcontroller uut (
		.R(R), 
		.C(C), 
		.go(go),
		.clk(clk), 
		.pw(pw)
	);
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		R = 10;
		C = 5;
		clk = 0;
		go = 1;
		// Wait 100 ns for global reset to finish
		#1000 C = C+1;
      #1000 C = C+1;
		#1000 C = C+1;
		#1000 C = C+1;
		#1000 C = C+1;
		#1000	R = 30;
		#1000 C = 20;
		#1000 C=30;	
		// Add stimulus here

	end
      
endmodule

