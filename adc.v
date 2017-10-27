`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:07 04/08/2016 
// Design Name: 
// Module Name:    adc 
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
module adc(
    input clk,
    input GO_ADC, input reset,
	 input SPI_MISO,
    output reg DONE_ADC,
	 output reg ADC_CONV,
	 output reg [7:0] ADC0,
	 output reg [7:0] ADC1,
	 output SPI_CLK_ADC
    );

reg [5:0] bc;
reg [33:0] data;
reg [2:0] state;
initial bc = 0;
initial state = 0;
always@(posedge clk)
begin
	if (reset) state <=0;
	else
	begin
		case(state)
			0:begin ADC_CONV <= 0; if (GO_ADC) begin DONE_ADC <=0; state <=1;  end
											else state <=0;
					end
			1:begin state <=2; ADC_CONV <=1; bc <= 34; data <= 0; end
			2:begin state <=3; ADC_CONV <= 0; end
			3:begin 	if (bc == 0) begin state <=4 ; end
						else begin state<=3; bc <= bc - 1; data <= {data[32:0], SPI_MISO}; end
					end
			4:begin state <=5; ADC0 <= {data[31], ~data[30:24]}; ADC1 <={data[15], ~data[14:8]}; end
			5:begin state <= 0; DONE_ADC <=1; end
			
		endcase
	end
end
assign SPI_CLK_ADC = ~clk;
endmodule
