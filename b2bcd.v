`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:01 04/05/2016 
// Design Name: 
// Module Name:    b2bcd 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module b2bcd(
	 input clk,
    input [7:0] T, L,
    
    output [11:0] DT,
	 output [11:0] DL
    );

reg [1:0] state;
reg [7:0] R;
reg [3:0] D2t, D1t;
reg [3:0] DT2, DT1, DT0, DL2, DL1, DL0;
initial state = 0; 
initial D2t = 0; initial D1t = 0;
always@( posedge clk)
begin
	case(state)
		0:begin R<=T; state <= 1; end
		1:begin 	if (R>99)
						begin
							D2t <= D2t+1;
							R <= R - 100;
							state <=1;
						end
					else
						begin
							if (R>9)
								begin
									D1t<= D1t +1;
									R <= R - 10;
									state <=1;
								end
							else
								begin
									DT0 <= R[3:0];
									DT2 <= D2t;
									DT1 <= D1t;
									R <= L;
									D2t <= 0;
									D1t <= 0;
									state <= 2;
								end
						end		
			end
		2:begin 	if (R>99)
						begin
								D2t <= D2t+1;
								R <= R - 100;
								state <=2;
						end
					else
						begin
							if (R>9)
								begin
									D1t<= D1t +1;
									R <= R - 10;
									state <=2;
								end
							else
								begin
									DL0 <= R[3:0];
									DL2 <= D2t;
									DL1 <= D1t;					
									D2t <= 0;
									D1t <= 0;
									state <= 0;
								end
						end		
			end			
	endcase
end
assign DT = {DT2,DT1,DT0};
assign DL = {DL2,DL1,DL0};
endmodule
