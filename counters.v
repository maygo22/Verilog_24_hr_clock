`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2023 14:58:28
// Design Name: 
// Module Name: counters
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counters(clk, rst, bcd1, bcd2, bcd3, bcd4, bcd5, bcd6); //Module that counts like a clock
    input clk, rst;
    output reg [3:0] bcd1, bcd2, bcd3, bcd4, bcd5, bcd6;
    integer cnt1, cnt2, cnt3, cnt4, cnt5, cnt6;
    reg f1, f2, f3, f4;
    always @(posedge clk or posedge rst) begin //always block to control the counter 1
        if(rst) begin
            cnt1<=4;
            f1<=0;
        end
        else if(cnt1==9) begin
            cnt1<=0;
            f1<=1;
        end
        else begin
            cnt1<=cnt1+1;
            f1<=0;
        end
    end
    always @(posedge rst or posedge f1) begin //always block to control the counter 2
        if(rst) begin
            cnt2<=4;
            f2<=0;
        end
        else if (f1==1 & cnt2==5)begin
            cnt2<=0;
            f2<=1;
        end
        else if(f1==1 & cnt2!=5) begin
            cnt2<=cnt2+1;
            f2<=0;
        end
    end
    always @(posedge rst or posedge f2) begin //always block to control the counter 3
        if(rst) begin
            cnt3<=9;
            f3<=0;
        end
        else if (f2==1 & cnt3==9)begin
            cnt3<=0;
            f3<=1;
        end
        else if(f2==1 & cnt3!=9) begin
            cnt3<=cnt3+1;
            f3<=0;
        end
    end
    always @(posedge rst or posedge f3) begin //always block to control the counter 4
        if(rst) begin
            cnt4<=5;
            f4<=0;
        end
        else if (f3==1 & cnt4==5)begin
            cnt4<=0;
            f4<=1;
        end
        else if(f3==1 & cnt4!=5) begin
            cnt4<=cnt4+1;
            f4<=0;
        end
    end
    always @(posedge rst or posedge f4) begin //always block to control the counter 5 and 6
        if(rst) begin
            cnt5<=3;
            cnt6<=2;
        end
        else if (f4==1 & cnt5==9 & cnt6!=2)begin
            cnt5<=0;
            cnt6<=cnt6+1;
        end
        else if(f4==1 & cnt5!=9 & cnt6!=2) begin
            cnt5<=cnt5+1;
        end
        else if(f4==1 & cnt5==3 & cnt6==2) begin
            cnt5<=0;
            cnt6<=0;
        end
        else if(f4==1 & cnt5!=3 & cnt6==2) begin
            cnt5<=cnt5+1;
        end
    end
    always @(cnt1) begin //always block to translate decimals to BCD
         case(cnt1)
          1      : bcd1 = {4'b0001};
          2      : bcd1 = {4'b0010};
          3      : bcd1 = {4'b0011};
          4      : bcd1 = {4'b0100};
          5      : bcd1 = {4'b0101};
          6      : bcd1 = {4'b0110};
          7      : bcd1 = {4'b0111};
          8      : bcd1 = {4'b1000};
          9      : bcd1 = {4'b1001};
          default: bcd1 = {4'b0000};
       endcase
    end     
    always @(cnt2) begin //always block to translate decimals to BCD
         case(cnt2)
          1      : bcd2 = {4'b0001};
          2      : bcd2 = {4'b0010};
          3      : bcd2 = {4'b0011};
          4      : bcd2 = {4'b0100};
          5      : bcd2 = {4'b0101};
          default: bcd2 = {4'b0000};
       endcase
    end    
    always @(cnt3) begin //always block to translate decimals to BCD
         case(cnt3)
          1      : bcd3 = {4'b0001};
          2      : bcd3 = {4'b0010};
          3      : bcd3 = {4'b0011};
          4      : bcd3 = {4'b0100};
          5      : bcd3 = {4'b0101};
          6      : bcd3 = {4'b0110};
          7      : bcd3 = {4'b0111};
          8      : bcd3 = {4'b1000};
          9      : bcd3 = {4'b1001};
          default: bcd3 = {4'b0000};
       endcase
    end      
    always @(cnt4) begin //always block to translate decimals to BCD
         case(cnt4)
          1      : bcd4 = {4'b0001};
          2      : bcd4 = {4'b0010};
          3      : bcd4 = {4'b0011};
          4      : bcd4 = {4'b0100};
          5      : bcd4 = {4'b0101};
          default: bcd4 = {4'b0000};
       endcase
    end    
    always @(cnt5) begin //always block to translate decimals to BCD
         case(cnt5)
          1      : bcd5 = {4'b0001};
          2      : bcd5 = {4'b0010};
          3      : bcd5 = {4'b0011};
          4      : bcd5 = {4'b0100};
          5      : bcd5 = {4'b0101};
          6      : bcd5 = {4'b0110};
          7      : bcd5 = {4'b0111};
          8      : bcd5 = {4'b1000};
          9      : bcd5 = {4'b1001};
          default: bcd5 = {4'b0000};
       endcase
    end     
    always @(cnt6) begin //always block to translate decimals to BCD
         case(cnt6)
          1      : bcd6 = {4'b0001};
          2      : bcd6 = {4'b0010};
          default: bcd6 = {4'b0000};
       endcase
    end     
endmodule
module bcd_to_7seg(bcd_in, Y); //module to enable the right LEDs based on the BCD input
    input [3:0] bcd_in;
    output reg [7:0] Y;
    always @(bcd_in) begin
        case({bcd_in})
            4'b0001 : Y = {8'b01100000};
            4'b0010 : Y = {8'b11011010};
            4'b0011 : Y = {8'b11110010};
            4'b0100 : Y = {8'b01100110};
            4'b0101 : Y = {8'b10110110};
            4'b0110 : Y = {8'b10111110};
            4'b0111 : Y = {8'b11100000};
            4'b1000 : Y = {8'b11111110};
            4'b1001 : Y = {8'b11110110};
            4'b1010 : Y = {8'b11101110};
            4'b1011 : Y = {8'b00111110};
            4'b1100 : Y = {8'b10011100};
            4'b1101 : Y = {8'b01111010};
            4'b1110 : Y = {8'b10011110};
            4'b1111 : Y = {8'b10001110};
            default: Y = {8'b11111100};
        endcase
    end    
endmodule

