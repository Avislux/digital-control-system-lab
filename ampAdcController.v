`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:50 04/08/2016 
// Design Name: 
// Module Name:    ampAdcController 
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
module ampAdcController(
	 input clk,
    output reg GO_AMP,
    output reg GO_ADC,
    output reg [7:0]T,
    output reg [7:0] L,
    output reg [1:0] select,
    input DONE_AMP,
    input DONE_ADC,
	 input [7:0] ADC0, //T
	 input [7:0] ADC1 //L
    );
reg [3:0] state;
reg [4:0] D;
initial state = 0;
always@(posedge clk)
begin
	case(state)
		0:begin state <=1; GO_AMP <= 0; GO_ADC <=0; select <=0; end
		1:begin state <=2; select <= 1; end
		2:begin state <=3; GO_AMP <=1; end
		3:begin state <=4; GO_AMP <=0; end
		4:begin state <=5; end
		5:begin if (DONE_AMP) begin state <=6; select <=0; end
				  else state<=5;
				end
		6:begin state <=7; select <= 2; end
		7:begin state <=8; GO_ADC <= 1; end
		8:begin state <=9; GO_ADC <=0; end
		9:begin state <=10; end
		10:begin if (DONE_ADC) begin state <=11; select <=0; end
				  else state<=10;
				end
		11:begin state <= 12; L<=ADC1; T <= ADC0; D <= 31; end
		12:begin D<=D-1; 	if (D==0)state <=6;
								else state <=12;
				end
		
		
	endcase
end
endmodule
