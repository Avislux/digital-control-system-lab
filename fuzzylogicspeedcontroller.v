`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:36 05/15/2016 
// Design Name: 
// Module Name:    fuzzylogicspeedcontroller 
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
module fuzzylogicspeedcontroller(
    input [7:0] R, 
    input [7:0] C,
	 input go,
    input clk,
    output reg [7:0] pw
    );
	 reg [5:0] state ;
	 initial state = 0;

reg [7:0] eNSreg, eZreg, ePSreg, eNLreg, ePLreg, deNreg, deZreg, dePreg; 
reg [7:0] DMeNS, DMeZ, DMePS, DMdeN, DMdeZ, DMdeP;
reg [7:0] DMeNL, DMePL;
reg [7:0] rule1,rule2,rule3,rule4,rule5,rule6,rule7,rule8,rule9,rule10,rule11,rule12,rule13,rule14,rule15;
reg [7:0] pwt, stop,slow,med,fast,blast;
reg [8:0] E, oldE, de,dPW,dPWS; //log base 2 510 = 9
reg [19:0] num, den;
wire [24:0] HSEC;
reg [24:0] TSC;
assign HSEC = 25000000; //50 MHz 25000000
initial DMeNS = 0; initial E = 0; initial oldE = 0; initial de = 0; initial dPW=0; initial pw = 0; initial dPWS = 0;
initial DMeZ = 0; initial DMePS = 0; initial DMdeN = 0; initial DMdeZ = 0; initial DMdeP = 0;
always @ (*)
	begin
		if (E < 158) begin DMeNL <= 255; end
		else if (E >= 158 && E < 190) begin DMeNL <= -(E<<3) + 1519; end
		else begin DMeNL <= 0; end
		
		if (E < 158) begin DMeNS <= 0; end 
		else if (E >= 158 && E< 190) begin DMeNS <= (E<<3) - 1264;end  //ramp slopes are 8 = 256/32 32 run 255 height
		else if (E >= 190 && E< 213) begin DMeNS <= 255; end
		else if (E >= 213 && E< 245) begin DMeNS <= -(E<<3) + 1959 ; end
		else begin DMeNS <= 0;end
	
		if (E < 213) begin DMeZ <= 0; end
		else if (E >= 213 && E < 245) begin DMeZ <= (E<<3)-1680;end 
		else if (E >= 245 && E < 265) begin DMeZ <= 255;end
		else if (E >= 265 && E < 297) begin DMeZ <= -(E<<3)+2375;end 
		else begin DMeZ <= 0; end
		
		if (E < 265) begin DMePS <= 0; end
		else if (E >= 265 && E < 297) begin DMePS <= (E<<3) - 2120;end 
		else if (E >= 297 && E < 320) begin DMePS <= 255;end
		else if (E >= 320 && E < 352)  begin DMePS <= -(E<<3) + 2815; end
		else begin DMePS <= 0; end
		
		if (E < 320) begin DMePL <= 0; end
		else if (E >= 320 && E <352 ) begin DMePL <= (E<<3) - 2560; end
		else begin DMePL <= 255; end
		
		if (de < 218) begin DMdeN <= 255;end
		else if (de >= 218 && de<= 250) begin DMdeN <= -(de<<3)+1999;end 
		else begin DMdeN <= 0;end
	
		if (de < 218) begin DMdeZ <= 0; end
		else if (de >= 218 && de < 250) begin DMdeZ <= (de<<3)-1744;end 
		else if (de >= 250 && de <= 260) begin DMdeZ <= 255;end
		else if (de > 265 && de<= 292) begin DMdeZ <= -(de<<3)+2335;end
		else begin DMdeZ <= 0; end
	
		if (de > 260 && de < 292) begin DMdeP <= (de<<3) - 2080;end 
		else if (de <= 260) begin DMdeP <= 0;end
		else  begin DMdeP <= 255; end
	end

always@(posedge clk)
	begin
		
		case (state)
			0:begin 	deNreg <=DMdeN;
						eNLreg <=DMeNL;
						ePLreg <=DMePL;
						eZreg <=DMeZ;
						ePSreg <=DMePS;
						eNSreg <=DMeNS;
						deZreg <=DMdeZ;
						dePreg <=DMdeP;
						E<= 255 + R - C;
						de <= 255 + E - oldE;
						oldE <= E;
						dPWS <= dPW ;
						pw <=dPWS;
						if (go) state <= 1;
						else state <=0;
				end
			1: begin	if(ePSreg<dePreg) rule1 <= ePSreg;
						else rule1 <= dePreg;
						state <=2;
				end
			2: begin	if(ePSreg<deZreg) rule2 <= ePSreg;
						else rule2 <= deZreg;
						state <=3;
				end
			3: begin	if(ePSreg<deNreg) rule3 <= ePSreg;
						else rule3 <= deNreg;
						state <=4;
				end
			4: begin	if(eZreg<dePreg) rule4 <= eZreg;
						else rule4 <= dePreg;
						state <=5;
				end
			5: begin	if(eZreg<deZreg) rule5 <= eZreg;
						else rule5 <= deZreg;
						state <=6;
				end
			6: begin	if(eZreg<deNreg) rule6 <= eZreg;
						else rule6 <= deNreg;
						state <=7;
				end
			7: begin	if(eNSreg<dePreg) rule7 <= eNSreg;
						else rule7 <= dePreg;
						state <=8;
				end
			8: begin	if(eNSreg<deZreg) rule8 <= eNSreg;
						else rule8 <= deZreg;
						state <=9;
				end
			9: begin	if(eNSreg<deNreg) rule9 <= eNSreg;
						else rule9 <= deNreg;
						state <=10;
				end
			10: begin
						if(ePLreg<dePreg) rule10 <= ePLreg;
						else rule10 <= dePreg;
						state <=11;
				end
			11: begin			
						if(ePLreg<deZreg) rule11 <= ePLreg;
						else rule11 <= deZreg;
						state <=12;
				end
			12: begin
						if(ePLreg<deNreg) rule12 <= ePLreg;
						else rule12 <= deNreg;
						state <=13;
				end
			13: begin
						if(eNLreg<dePreg) rule13 <= eNLreg;
						else rule13 <= dePreg;
						state <=14;
				end
			14: begin
						if(eNLreg<deZreg) rule14 <= eNLreg;
						else rule14 <= deZreg;
						state <=15;
				end
			15: begin
						if(eNLreg<deNreg) rule15 <= eNLreg;
						else rule15 <= deNreg;
						state <=16;
				end
			16:begin	med <=rule5;
						if (rule1>=rule10 && rule1>=rule11 && rule1>=rule12) blast <=rule1; //compare 1 10 11 12
						else if (rule10>=rule1 && rule10>=rule11 && rule10>=rule12) blast <=rule10;
                        else if (rule11>=rule1 && rule11>=rule10 && rule11>=rule12) blast <=rule11;
                        else blast <= rule12;
						state <=17;
				end
			17:begin	if (rule2>=rule3 && rule2>=rule4 ) fast <=rule2; //compare 2 3 4
                        else if (rule3>=rule2 && rule3>=rule4 ) fast <=rule3;
						else fast <=rule4;
						state <=18;
				end				
			18:begin	if (rule6>=rule7 && rule6>=rule8 ) slow <=rule6; //6 7 8
						else if (rule7>=rule6 && rule7>=rule8) slow <=rule7;
                        else slow <= rule8;
						state <=19;
				end		
			19:begin	if (rule9>=rule15 && rule9>=rule13 && rule9>=rule14) stop <=rule9; //9 13 14 15
                        else if (rule13>=rule9 && rule13>=rule14 && rule13>=rule15) stop <=rule13;
                        else if (rule14>=rule9 && rule14>=rule13 && rule14>=rule15) stop <=rule14;
						else stop <=rule15;
						state <=20;
				end
			20:begin den <= stop + slow + med + fast + blast;
						num <= (stop<<7) - (stop<<3)// 119
						+ (slow<<7) + (slow<<4) + (slow<<3) + slow //153
						+ (med<<8)-(med<<6)-(med<<2)//187)
						+(fast<<8) -(fast<<5)-(fast<<1) //221
						+(blast<<8)-blast; 
						pwt<=0; TSC <=HSEC;
						state <=21;
				end
			21:begin if(num<den)
							begin
								state<=22;
							end
						else begin
									pwt <=pwt+1;
									num<=num-den;
									if (TSC > 0) TSC<=TSC-1;
									state<=21;
								end
				end
			22:begin if (TSC>0)
							begin TSC<=TSC-1; state <=22; end
						else begin
									dPW<=pwt;
									state<=0;
								end
				end

		endcase
	end
endmodule
