`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2023 14:57:31
// Design Name: 
// Module Name: clock_24h
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


module clock_24h(clk, rst, clk_select, Y, Z, scan); //main module
    input clk, rst, clk_select;
    output [7:0] Y, Z;
    output reg [5:0] scan;
    wire clk_fast_out, clk_1hz_out, clk_turbo_fast_out;
    reg clk_selected;
    wire [3:0] bcd1, bcd2, bcd3, bcd4, bcd5, bcd6;
    integer x;
    reg [3:0] bcd_out;
    clk_even_faster(clk, rst, clk_turbo_fast_out); //call function for clk to go faster
    clk_fast(clk, rst, clk_fast_out); //clock used for the 7seg display
    clk_divider_1hz(clk,rst,clk_1hz_out); //clk of 1 sec
    always @(clk_select)begin // always block to select the clock
        if (clk_select)begin
            clk_selected <= clk_turbo_fast_out;
        end
        else begin
            clk_selected <= clk_1hz_out;
        end
    end 
    counters(clk_selected, rst, bcd1, bcd2, bcd3, bcd4, bcd5, bcd6); //call function to count in a 24hs manner
    always @(posedge clk_fast_out or posedge rst)begin //always block to set x flag
        if(rst)
            x<=0;
        else if (x==5) begin
            x<=0;  
        end 
        else
            x<=x+1;
    end
    always @(posedge clk_fast_out)begin //case scenario where the enabled display and the number it should show is decided
        case(x)
            0:begin 
                bcd_out<=bcd1; 
                scan<=6'b000001;
            end
            1:begin 
                bcd_out<=bcd2; 
                scan<=6'b000010;
            end
            2:begin 
                bcd_out<=bcd3; 
                scan<=6'b000100;
            end
            3:begin 
                bcd_out<=bcd4; 
                scan<=6'b001000;
            end
            4:begin 
                bcd_out<=bcd5; 
                scan<=6'b010000;
            end
            5:begin 
                bcd_out<=bcd6; 
                scan<=6'b100000;
            end
        endcase
    end
    bcd_to_7seg(bcd_out, Y); //function to show the numbers in the first 4 seven segment
    bcd_to_7seg(bcd_out, Z); //function to show the numbers in the other 4 seven segment   
endmodule
