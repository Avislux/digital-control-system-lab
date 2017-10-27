`timescale 1ns / 1ps


module fuzzytf;

	// Inputs
	reg [7:0] T;
	reg [7:0] L;
	reg clk;

	// Outputs
	wire [7:0] pw;

	// Instantiate the Unit Under Test (UUT)
	fuzzylogiccontroller uut (
		.T(T), 
		.L(L), 
		.clk(clk), 
		.pw(pw)
	);
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		T = 110;
		L = 130; //187
		clk = 0;

		// Wait 100 ns for global reset to finish
		#5000;
		T = 240;//255
		L = 240;
      #5000; 
		T = 80;
		L = 20;		//131
		// Add stimulus here

	end
      
endmodule

