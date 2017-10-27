`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:31 04/08/2016 
// Design Name: 
// Module Name:    amp-adc 
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
module topampadc(
    input clk,
    input reset,
    input SPI_MISO,
	 input W, 
	 output PWM,
    output reg SPI_MOSI,
    output reg SPI_CLK,
    output ADC_CONV,
    output AMP_SHDN,
    output AMP_CS,
    output DAC_CS,
    output SPI_SS_B,
    output SF_CE0,
    output FPGA_INIT_B,
    output [3:0] dataout,
    output [2:0] control
    );
wire GO_AMP, DONE_AMP, GO_ADC, DONE_ADC, SPI_CLK_AMP, SPI_CLK_ADC, SPI_MOSI_AMP;
wire pe;
wire [7:0] T,L, S;
wire [1:0] select;
wire [11:0] DT,DL, DS, DPWM;
wire [7:0] ADC0, ADC1;
wire [7:0] PW;
always@(select)
begin  
    case(select)
        0: begin SPI_MOSI = 0; SPI_CLK = 0; end
        1: begin SPI_MOSI=SPI_MOSI_AMP; SPI_CLK = SPI_CLK_AMP; end
        2: begin SPI_MOSI = 0; SPI_CLK = SPI_CLK_ADC; end
        3: begin SPI_MOSI = 0; SPI_CLK = 0; end
    endcase
end
assign DAC_CS = 1;
assign SPI_SS_B = 1;
assign SF_CE0 = 1;
assign FPGA_INIT_B = 1;

filter f(.clk(clk),.W(W),.pe(pe));
speedmeter speed(.clk(clk), .pe(pe), .reset(reset), .S(S));
pwm pwm(.clk(clk),.PW(PW), .PWM(PWM));
ampAdcController controller( .clk(clk),
    .GO_AMP(GO_AMP),
    .GO_ADC(GO_ADC),
    .T(T), //digital output
    .L(L), //digital output
	 .ADC0(ADC0),
	 .ADC1(ADC1),
    .select(select),
    .DONE_AMP(DONE_AMP),
    .DONE_ADC(DONE_ADC));
adc adc(.clk(clk),
    .GO_ADC(GO_ADC), 
    .reset(reset),
	 .SPI_MISO(SPI_MISO),
    .DONE_ADC(DONE_ADC),
	 .ADC_CONV(ADC_CONV),
	 .ADC0(ADC0),
	 .ADC1(ADC1),
	 .SPI_CLK_ADC(SPI_CLK_ADC));
amp amp(.clk(clk),
    .reset(reset),
    .GO_AMP(GO_AMP),
    .DONE_AMP(DONE_AMP),
	 .SPI_CLK_AMP(SPI_CLK_AMP),
	 .SPI_MOSI_AMP(SPI_MOSI_AMP),
	 .AMP_CS(AMP_CS),
	 .AMP_SHDN(AMP_SHDN));
fuzzylogiccontroller fuzzy(.T(T),.L(L),.clk(clk),.pw(PW));	//outputs PW
b2bcd TL( .clk(clk),
    .T(T),
    .L(L),
    .DL(DL),
    .DT(DT)
			);
b2bcd SandPWM( .clk(clk),
    .T(S),
    .L(PW),
    .DL(DS),
    .DT(DPWM)
			);
CharGen chargen(.clk(clk),
					 .DT(DT),
					 .DL(DL),
					 .DS(DS),
					 .DPWM(DPWM),
					 .dataout(dataout),
					 .control(control));
	
endmodule
