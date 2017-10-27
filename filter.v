`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:44:02 04/19/2016 
// Design Name: 
// Module Name:    filter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: s
//
//////////////////////////////////////////////////////////////////////////////////
module filter(
    input clk,
    input W,
    output pe
    );
reg [7:0] Q;
wire [1:0] sel;
wire QAND;
wire QNOR;
reg DSS, SS;
initial Q = 0;
always @ ( posedge clk)
begin
	Q <= {Q[6:0], W};
	DSS <= SS;
end
assign QAND = &Q; //Q is all 1's
assign QNOR = ~|Q; // Q is all 0's
assign sel = {QAND,QNOR};
assign pe = SS&~DSS;
always@(sel)
begin
	case(sel)
		0: SS = DSS;
		1: SS = 1'b0;
		2: SS = 1'b1;
		3:	SS = DSS;
	endcase
end
endmodule
