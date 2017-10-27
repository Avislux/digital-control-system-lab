`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:13 04/26/2016 
// Design Name: 
// Module Name:    fuzzylogiccontroller 
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
module fuzzylogiccontroller(
    input [7:0] T,
    input [7:0] L,
    input clk,
    output reg [7:0] pw
    );
	 reg [5:0] state ;
	 initial state = 0;

reg [7:0] coldR, warmR, hotR, dimR, normR, brightR; 
reg [7:0] DMcold, DMwarm, DMhot, DMdim, DMnorm, DMbright;
reg [7:0] rule1,rule2,rule3,rule4,rule5,rule6,rule7,rule8,rule9;
reg [7:0] pwt, stop,slow,med,fast,blast,TSC;
reg [19:0] num, den;
wire [24:0] HSEC;
assign HSEC = 12500000; //50 MHz
initial DMcold = 1;
initial DMwarm = 1; initial DMhot = 1; initial DMdim = 1; initial DMnorm = 1; initial DMbright = 1;
always @ (*)
	begin
		if (T < 45) begin DMcold <= 255;end
		else if (T >= 45 && T<= 109) begin DMcold <= -(T<<2)+436;end
		else begin DMcold <= 0;end
	
		if (T < 63) begin DMwarm <= 0; end
		else if (T >= 63 && T< 127) begin DMwarm <= (T<<2)-252;end
		else if (T == 127) begin DMwarm <= 255;end
		else if (T > 127 && T<= 191) begin DMwarm <= -(T<<2)+763;end
		else begin DMwarm <= 0; end
	
		if (T >191 && T <209) begin DMhot <= (T<<2) - 763;end
		else if (T <= 191) begin DMhot <= 0;end
		else  begin DMhot <= 255; end
		
		if (L < 45) begin DMdim <= 255;end
		else if (L >= 45 && L<= 109) begin DMdim <= -(L<<2)+436;end
		else begin DMdim <= 0;end
	
		if (L < 63) begin DMnorm <= 0; end
		else if (L >= 63 && L< 127) begin DMnorm <= (L<<2)-252;end
		else if (L == 127) begin DMnorm <= 255;end
		else if (L > 127 && L<= 191) begin DMnorm <= -(L<<2)+763;end
		else begin DMnorm <= 0; end
	
		if (L >191 && L <209) begin DMbright <= (L<<2) - 763;end
		else if (L <= 191) begin DMbright <= 0;end
		else  begin DMbright <= 255; end
	end
always@(posedge clk)
	begin
		
		
		case (state)
			0:begin 	dimR <=DMdim;
						warmR <=DMwarm;
						hotR <=DMhot;
						coldR <=DMcold;
						normR <=DMnorm;
						brightR <=DMbright;
						state <= 1;
				end
			1: begin	if(hotR<brightR) rule1 <= hotR;
						else rule1 <= brightR;
						state <=2;
				end
			2: begin	if(hotR<normR) rule2 <= hotR;
						else rule2 <= normR;
						state <=3;
				end
			3: begin	if(hotR<dimR) rule3 <= hotR;
						else rule3 <= dimR;
						state <=4;
				end
			4: begin	if(warmR<brightR) rule4 <= warmR;
						else rule4 <= brightR;
						state <=5;
				end
			5: begin	if(warmR<normR) rule5 <= warmR;
						else rule5 <= normR;
						state <=6;
				end
			6: begin	if(warmR<dimR) rule6 <= warmR;
						else rule6 <= dimR;
						state <=7;
				end
			7: begin	if(coldR<brightR) rule7 <= coldR;
						else rule7 <= brightR;
						state <=8;
				end
			8: begin	if(coldR<normR) rule8 <= coldR;
						else rule8 <= normR;
						state <=9;
				end
			9: begin	if(coldR<dimR) rule9 <= coldR;
						else rule9 <= dimR;
						state <=10;
				end
			10:begin	med <=rule5;
						if(rule1>rule2) blast <=rule1;
						else blast <=rule2;
						state <=11;
				end
			11:begin	if(rule3>rule4) fast <=rule3;
						else fast <=rule4;
						state <=12;
				end				
			12:begin	if(rule6>rule7) slow <=rule6;
						else slow <=rule7;
						state <=13;
				end		
			13:begin	if(rule8>rule9) stop <=rule8;
						else stop <=rule9;
						state <=14;
				end
			14:begin den <= stop + slow + med + fast + blast;
						num <= (stop<<7) - (stop<<3)// 119*stop 
						+ (slow<<7) + (slow<<4) + (slow<<3) + slow //153
						+ (med<<8)-(med<<6)-(med<<2)//187)
						+(fast<<8) -(fast<<5)-(fast<<1) //221
						+(blast<<8)-blast; 
						pwt<=0; TSC <=HSEC;
						state <=15;
				end
			15:begin if(num<den)
							begin
								state<=16;
							end
						else begin
									pwt <=pwt+1;
									num<=num-den;
									TSC<=TSC-1;
									state<=15;
								end
				end
			16:begin if (TSC>0)
							begin TSC<=TSC-1; state <=16; end
						else begin
									pw<=pwt;
									state<=0;
								end
				end

		endcase
	end
endmodule
