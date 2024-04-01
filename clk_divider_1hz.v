`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2023 14:35:23
// Design Name: 
// Module Name: clk_divider_1hz
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


module clk_divider_1hz(clk,rst, clk_out); //module to divide the clk from 100MHz to 1Hz
    input clk, rst;
    output reg clk_out;
    integer cnt;
    always @(posedge clk or posedge rst) begin
        if (rst) 
            cnt<=0;
        else if (cnt==100000000)
            cnt<=0;
        else 
            cnt<=cnt+1;
    end
    always @(posedge clk or posedge rst) begin
        if (rst)
            clk_out<=0;
        else if (cnt<=50000000)  
            clk_out<=1'b1;
        else
            clk_out<=1'b0;
    end
endmodule
module clk_fast(clk, rst, clk_out);
    input clk, rst;
    output reg clk_out;
    integer cnt;
    always@(posedge clk or posedge rst)
    begin
        if(rst) cnt <=0;
        else if(cnt==10000)
        cnt<=0;
        else
        cnt<=cnt+1;
      end  
    always @ (posedge(clk) or posedge rst)
    begin
        if (rst) clk_out <= 0;
        else if(cnt<=5000)clk_out<=1'b1;
        else clk_out<=1'b0;
    end    
endmodule
module clk_even_faster(clk, rst, clk_out); //module to divide the clk from 100MHz to 10KHz
    input clk, rst;
    output reg clk_out;
    integer cnt;
    always@(posedge clk or posedge rst)
    begin
        if(rst) cnt <=0;
        else if(cnt==10000)
        cnt<=0;
        else
        cnt<=cnt+1;
      end  
    always @ (posedge(clk) or posedge rst)
    begin
        if (rst) clk_out <= 0;
        else if(cnt<=5000)clk_out<=1'b1;
        else clk_out<=1'b0;
    end    
endmodule
