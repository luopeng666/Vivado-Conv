`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 20:17:40
// Design Name: 
// Module Name: Conv_53
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

module Conv_53(
    input clk,
    input rst,
    input [7:0] A11,
    input [7:0] A12,
    input [7:0] A13,
    input [7:0] A14,
    input [7:0] A15,
    input [7:0] A21,
    input [7:0] A22,
    input [7:0] A23,
    input [7:0] A24,
    input [7:0] A25,
    input [7:0] A31,
    input [7:0] A32,
    input [7:0] A33,
    input [7:0] A34,
    input [7:0] A35,
    input [7:0] A41,
    input [7:0] A42,
    input [7:0] A43,
    input [7:0] A44,
    input [7:0] A45,
    input [7:0] A51,
    input [7:0] A52,
    input [7:0] A53,
    input [7:0] A54,
    input [7:0] A55,

    input [7:0] k11,
    input [7:0] k12,
    input [7:0] k13,
    input [7:0] k21,
    input [7:0] k22,
    input [7:0] k23,
    input [7:0] k31,
    input [7:0] k32,
    input [7:0] k33,

    output reg [19:0] out11,
    output reg [19:0] out12,
    output reg [19:0] out13,
    output reg [19:0] out21,
    output reg [19:0] out22,
    output reg [19:0] out23,
    output reg [19:0] out31,
    output reg [19:0] out32,
    output reg [19:0] out33
);
    wire [7:0] B[1:5][1:5];
    reg [7:0] C[1:3][1:3];
    reg [19:0] out_r[1:3][1:3];

    assign
    B[1][1]=A11, B[1][2]=A12, B[1][3]=A13, B[1][4]=A14, B[1][5]=A15,
    B[2][1]=A21, B[2][2]=A22, B[2][3]=A23, B[2][4]=A24, B[2][5]=A25 ,
    B[3][1]=A31, B[3][2]=A32, B[3][3]=A33, B[3][4]=A34, B[3][5]=A35,
    B[4][1]=A41, B[4][2]=A42, B[4][3]=A43, B[4][4]=A44, B[4][5]=A45,
    B[5][1]=A51, B[5][2]=A52, B[5][3]=A53, B[5][4]=A54, B[5][5]=A55;



    wire [19:0] conv_out;
    Conv conv1(

        .A11(C[1][1]),
        .A12(C[1][2]),
        .A13(C[1][3]),
        .A21(C[2][1]),
        .A22(C[2][2]),
        .A23(C[2][3]),
        .A31(C[3][1]),
        .A32(C[3][2]),
        .A33(C[3][3]),
        .k11(k11),
        .k12(k12),
        .k13(k13),
        .k21(k21),
        .k22(k22),
        .k23(k23),
        .k31(k31),
        .k32(k32),
        .k33(k33),
        .out(conv_out)
    );
    integer i=1,j=1;
    reg [1:0] states = 2'b00;

    always@(posedge clk) begin
        if(rst==0)begin
            case(states)
                2'b00:begin
                    C[1][1]<=B[i][j+0];
                    C[1][2]<=B[i][j+1];
                    C[1][3]<=B[i][j+2];
                    C[2][1]<=B[i+1][j+0];
                    C[2][2]<=B[i+1][j+1];
                    C[2][3]<=B[i+1][j+2];
                    C[3][1]<=B[i+2][j+0];
                    C[3][2]<=B[i+2][j+1];
                    C[3][3]<=B[i+2][j+2];
                    states<=2'b01;
                end

                2'b01:begin
                    #5
                    out_r[i][j] <= conv_out;
                    if(j<3)begin
                        j<=j+1;
                        states<=2'b00;
                    end
                    if(j==3&&i<3) begin //第一轮卷积结束
                        j<=1;
                        i<=i+1; //下一轮，/从下一行开始窗口右移卷积
                        states<=2'b00;
                    end
                    if(i==3&&j==3)begin //卷积窗口遍历结束
                        states<=2'b10;
                    end

                end
                2'b10:begin
                    out11 <= out_r[1][1];
                    out12 <= out_r[1][2];
                    out13 <= out_r[1][3];

                    out21 <= out_r[2][1];
                    out22 <= out_r[2][2];
                    out23 <= out_r[2][3];

                    out31 <= out_r[3][1];
                    out32 <= out_r[3][2];
                    out33 <= out_r[3][3];
                    i<=1;
                    j<=1;
                    states <= 2'b00;

                end
            endcase
        end
        else begin
            C[1][1]<=8'b0;
            C[1][2]<=8'b0;
            C[1][3]<=8'b0;
            C[2][1]<=8'b0;
            C[2][2]<=8'b0;
            C[2][3]<=8'b0;
            C[3][1]<=8'b0;
            C[3][2]<=8'b0;
            C[3][3]<=8'b0;
            out11 <= 20'b0;
            out12 <= 20'b0;
            out13 <= 20'b0;
            out21 <= 20'b0;
            out22 <= 20'b0;
            out23 <= 20'b0;
            out31 <= 20'b0;
            out32 <= 20'b0;
            out33 <= 20'b0;
            out_r[1][1]<=20'b0;
            out_r[1][2]<=20'b0;
            out_r[1][3]<=20'b0;
            out_r[2][1]<=20'b0;
            out_r[2][2]<=20'b0;
            out_r[2][3]<=20'b0;
            out_r[3][1]<=20'b0;
            out_r[3][2]<=20'b0;
            out_r[3][3]<=20'b0;
            
        end
    end


endmodule
