`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Character Generator for Spartan3e LCD Screen
// Kevin Tucker
// ECE414 Lab
//////////////////////////////////////////////////////////////////////////////////
module CharGen(DT, DL,DS,DPWM, clk, dataout, control);
	input clk;
	input[11:0] DT;
	input[11:0] DL;
	input[11:0] DS;
	input[11:0] DPWM;
	output[3:0] dataout;
	output[2:0] control;
   integer state=0;
	reg[7:0] din;
	reg[4:0] wadd;
	reg w=0;
	
	
LCDI lcdi1(clk, din, w, wadd, dataout, control);
always @ (posedge clk)
begin
case (state)
0 : begin w <= 1'b1; wadd <= 5'b00000; din <= 8'h54; state <=1; end //T
1 : begin wadd <= 5'b00001; din <= 8'h65; state <=2; end //e
2 : begin wadd <= 5'b00010; din <= 8'h6D; state <=3; end //m
3 : begin wadd <= 5'b00011; din <= 8'h70; state <=4; end //p
4 : begin wadd <= 5'b00100; din <= 8'h3A; state <=5; end //:
5 : begin wadd <= 5'b00101; din <= {4'h3,DT[11:8]}; state <=6; end //
6 : begin wadd <= 5'b00110; din <= {4'h3,DT[7:4]}; state <=7; end //
7 : begin wadd <= 5'b00111; din <= {4'h3,DT[3:0]}; state <=8; end //
8 : begin wadd <= 5'b01000; din <= 8'hFE; state <=9; end //
9 : begin wadd <= 5'b01001; din <= 8'h50; state <=10; end //P
10 : begin wadd <= 5'b01010; din <= 8'h57; state <=11; end //W
11 : begin wadd <= 5'b01011; din <= 8'h4D; state <=12; end //M
12 : begin wadd <= 5'b01100; din <= 8'h3D; state <=13; end //:
13 : begin wadd <= 5'b01101; din <= {4'h3,DPWM[11:8]}; state <=14; end //
14 : begin wadd <= 5'b01110; din <= {4'h3,DPWM[7:4]}; state <=15; end //
15 : begin wadd <= 5'b01111; din <= {4'h3,DPWM[3:0]}; state <=16; end //
16 : begin wadd <= 5'b10000; din <= 8'h4C; state <=17; end //L
17 : begin wadd <= 5'b10001; din <= 8'h49; state <=18; end //I
18 : begin wadd <= 5'b10010; din <= 8'h4E; state <=19; end //N
19 : begin wadd <= 5'b10011; din <= 8'h54; state <=20; end //T
20 : begin wadd <= 5'b10100; din <= 8'h3A; state <=21; end //:
21 : begin wadd <= 5'b10101; din <= {4'h3,DL[11:8]}; state <=22; end //
22 : begin wadd <= 5'b10110; din <= {4'h3,DL[7:4]}; state <=23; end // 
23 : begin wadd <= 5'b10111; din <= {4'h3,DL[3:0]}; state <=24; end //
24 : begin wadd <= 5'b11000; din <= 8'hFE; state <=25; end //
25 : begin wadd <= 5'b11001; din <= 8'h53; state <=26; end //s
26 : begin wadd <= 5'b11010; din <= 8'h70; state <=27; end //P
27 : begin wadd <= 5'b11011; din <= 8'h64; state <=28; end //D
28 : begin wadd <= 5'b11100; din <= 8'h3A; state <=29; end //:
29 : begin wadd <= 5'b11101; din <= {4'h3,DS[11:8]}; state <=30; end //
30 : begin wadd <= 5'b11110; din <= {4'h3,DS[7:4]}; state <=31; end //
31 : begin wadd <= 5'b11111; din <= {4'h3,DS[3:0]}; state <=32; end //
32 : begin w <= 1'b0; wadd <= 5'b00000; din <= 8'hFE; state <=0; end
endcase
end	
endmodule