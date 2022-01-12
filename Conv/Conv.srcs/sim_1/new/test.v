`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/09 20:30:22
// Design Name: 
// Module Name: test
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

module test;
    reg clk;
    reg rst;
    reg [7:0] A11;
    reg [7:0] A12;
    reg [7:0] A13;
    reg [7:0] A14;
    reg [7:0] A15;
    reg [7:0] A21;
    reg [7:0] A22;
    reg [7:0] A23;
    reg [7:0] A24;
    reg [7:0] A25;
    reg [7:0] A31;
    reg [7:0] A32;
    reg [7:0] A33;
    reg [7:0] A34;
    reg [7:0] A35;
    reg [7:0] A41;
    reg [7:0] A42;
    reg [7:0] A43;
    reg [7:0] A44;
    reg [7:0] A45;
    reg [7:0] A51;
    reg [7:0] A52;
    reg [7:0] A53;
    reg [7:0] A54;
    reg [7:0] A55;
    reg [7:0] k11;
    reg [7:0] k12;
    reg [7:0] k13;
    reg [7:0] k21;
    reg [7:0] k22;
    reg [7:0] k23;
    reg [7:0] k31;
    reg [7:0] k32;
    reg [7:0] k33;
    wire [19:0] out11;
    wire [19:0] out12;
    wire [19:0] out13;
    wire [19:0] out21;
    wire [19:0] out22;
    wire [19:0] out23;
    wire [19:0] out31;
    wire [19:0] out32;
    wire [19:0] out33;


    always #20 clk<=~clk;
    initial begin
        clk=1;
        rst=1;
        #10;
        rst=0;
        A11=8'd0;A12=8'd0;A13=8'd0;A14=8'd0;A15=8'd0;
        A21=8'd0;A22=8'd1;A23=8'd1;A24=8'd1;A25=8'd0;
        A31=8'd0;A32=8'd1;A33=8'd1;A34=8'd1;A35=8'd0;
        A41=8'd0;A42=8'd1;A43=8'd1;A44=8'd1;A45=8'd0;
        A51=8'd0;A52=8'd0;A53=8'd0;A54=8'd0;A55=8'd0;

        k11=8'd1;k12=8'd1;k13=8'd1;
        k21=8'd1;k22=8'd1;k23=8'd1;
        k31=8'd1;k32=8'd1;k33=8'd1;

    end

    Conv_53 conv53(
        .clk(clk),
        .rst(rst),
        .A11(A11),.A12(A12),.A13(A13),.A14(A14),.A15(A15),
        .A21(A21),.A22(A22),.A23(A23),.A24(A24),.A25(A25),
        .A31(A31),.A32(A32),.A33(A33),.A34(A34),.A35(A35),
        .A41(A41),.A42(A42),.A43(A43),.A44(A44),.A45(A45),
        .A51(A51),.A52(A52),.A53(A53),.A54(A54),.A55(A55),
        .k11(k11),.k12(k12),.k13(k13),
        .k21(k21),.k22(k22),.k23(k23),
        .k31(k31),.k32(k32),.k33(k33),
        .out11(out11),.out12(out12),.out13(out13),
        .out21(out21),.out22(out22),.out23(out23),
        .out31(out31),.out32(out32),.out33(out33)
    );

endmodule
