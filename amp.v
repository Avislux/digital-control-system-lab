`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:32 04/08/2016 
// Design Name: 
// Module Name:    amp 
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
module amp(
    input clk,
    input reset,
    input GO_AMP,
    output reg DONE_AMP,
	 output reg SPI_CLK_AMP,
	 output SPI_MOSI_AMP,
	 output reg AMP_CS,
	 output reg AMP_SHDN
    );
reg [3:0] state;

reg [1:0] delay;

reg [4:0] bc;
reg [7:0] gain;
initial state = 0;
always@(posedge clk)
begin
	if (reset) state <= 0;
	else
	begin
		case(state)
			0:begin AMP_SHDN <=0; AMP_CS <=1; SPI_CLK_AMP <=0;
						if(GO_AMP) begin  state <=1; DONE_AMP <= 0;  end
						else state <= 0;
					end
			1:begin state <=2;AMP_CS<=0; bc <= 8; delay <= 2; gain <=8'h11; end
			2:begin state <=3; bc<=bc-1; end
			3:begin 	if (delay==0) begin state <=4; delay <=3; SPI_CLK_AMP <=1; end
						else begin delay <= delay -1; state <= 3; end
					end
			4:begin 	if (delay ==0) 
						begin 
							if (bc==0)
							begin
								state <=5; delay <=7; SPI_CLK_AMP <=0;
							end
							else
							begin
								state <=3; delay <= 3; bc <=bc-1; gain <= gain << 1; SPI_CLK_AMP<=0;
							end
						end
						else
							begin delay<=delay -1; state <=4;
							end
					end
						
			5:begin if (delay==0) begin state <=6; AMP_CS<=1; end
					  else begin state<=5; delay <= delay -1; end
					end
			6:begin state <=0; DONE_AMP<=1; end
			
			
		endcase
	end
end
assign SPI_MOSI_AMP = gain[7];
endmodule
