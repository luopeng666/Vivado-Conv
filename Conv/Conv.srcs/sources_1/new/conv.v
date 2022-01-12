`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/05 21:11:23
// Design Name: 
// Module Name: Conv
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

module Conv(
    input [7:0] A11,
    input [7:0] A12,
    input [7:0] A13,
    input [7:0] A21,
    input [7:0] A22,
    input [7:0] A23,
    input [7:0] A31,
    input [7:0] A32,
    input [7:0] A33,

    input [7:0] k11,
    input [7:0] k12,
    input [7:0] k13,
    input [7:0] k21,
    input [7:0] k22,
    input [7:0] k23,
    input [7:0] k31,
    input [7:0] k32,
    input [7:0] k33,


    output [19:0] out //卷积输出和   
);
    wire [16:1] temp [1:9]; //存储乘积

    multiplier mult1(A11, k11, temp[1]);
    multiplier mult2(A12, k12, temp[2]);
    multiplier mult3(A13, k13, temp[3]);
    multiplier mult4(A21, k21, temp[4]);
    multiplier mult5(A22, k22, temp[5]);
    multiplier mult6(A23, k23, temp[6]);
    multiplier mult7(A31, k31, temp[7]);
    multiplier mult8(A32, k32, temp[8]);
    multiplier mult9(A33, k33, temp[9]);


    wire [20:1] s1[1:4];
    wire [20:1] s2[1:2];
    wire [20:1] s3;
    adder20 add1(.a({4'b0,temp[1]}), .b({4'b0,temp[2]}), .s(s1[1]));
    adder20 add2(.a({4'b0,temp[3]}), .b({4'b0,temp[4]}), .s(s1[2]));
    adder20 add3(.a({4'b0,temp[5]}), .b({4'b0,temp[6]}), .s(s1[3]));
    adder20 add4(.a({4'b0,temp[7]}), .b({4'b0,temp[8]}), .s(s1[4]));
    adder20 add5(.a(s1[1]), .b(s1[2]), .s(s2[1]));
    adder20 add6(.a(s1[3]), .b(s1[4]), .s(s2[2]));
    adder20 add7(.a(s2[1]), .b(s2[2]), .s(s3));
    adder20 add8(.a(s3), .b({4'b0,temp[9]}), .s(out));

endmodule



