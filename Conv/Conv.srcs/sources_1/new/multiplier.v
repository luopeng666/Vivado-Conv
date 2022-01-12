`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/07 22:03:29
// Design Name: 
// Module Name: multiplier
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
module multiplier(num1,num2,result);
    input [7:0] num1;
    input [7:0] num2;
    output [15:0] result;
    wire temp1;
    wire [15:0]temp2;
    wire [7:0]temp;
    wire [7:0]temp3;
    wire [15:0]shi1;
    wire [15:0]shi2;
    wire [15:0]shi3;
    wire [15:0]shi4;
    wire [15:0]shi5;
    wire [15:0]shi6;
    wire [15:0]shi7;
    wire [15:0]add1;wire[15:0]add2;wire[15:0]add3;wire[15:0]add4;wire[15:0]add5;wire[15:0]add6;wire[15:0]add7;
    begin
        and (temp1,num2[0],num1);
        and (temp[0],num1[0],temp1);
        and (temp[1],num1[1],temp1);
        and (temp[2],num1[2],temp1);
        and (temp[3],num1[3],temp1);
        and (temp[4],num1[4],temp1);
        and (temp[5],num1[5],temp1);
        and (temp[6],num1[6],temp1);
        and (temp[7],num1[7],temp1);
        and (temp3[0],num2[0],1'b0);
        and (temp3[1],num2[1],1'b1);
        and (temp3[2],num2[2],1'b1);
        and (temp3[3],num2[3],1'b1);
        and (temp3[4],num2[4],1'b1);
        and (temp3[5],num2[5],1'b1);
        and (temp3[6],num2[6],1'b1);
        and (temp3[7],num2[7],1'b1);

        shifterr_1bit s1(.result(temp2),.num1({8'b0,temp3}),.num2(1'b1));
        shifterl_1bit s2(.result(shi1),.num1({8'b0,num1}),.num2(temp2[0]));
        shifterl_2bit s3(.result(shi2),.num1({8'b0,num1}),.num2(temp2[1]));
        shifterl_3bit s4(.result(shi3),.num1({8'b0,num1}),.num2(temp2[2]));
        shifterl_4bit s5(.result(shi4),.num1({8'b0,num1}),.num2(temp2[3]));
        shifterl_5bit s6(.result(shi5),.num1({8'b0,num1}),.num2(temp2[4]));
        shifterl_6bit s7(.result(shi6),.num1({8'b0,num1}),.num2(temp2[5]));
        shifterl_7bit s8(.result(shi7),.num1({8'b0,num1}),.num2(temp2[6]));
        CLA_16 a1(.S(add1),.A(shi1),.B(shi2),.C0(1'b0));
        CLA_16 a2(.S(add2),.A(add1),.B(shi3),.C0(1'b0));
        CLA_16 a3(.S(add3),.A(add2),.B(shi4),.C0(1'b0));
        CLA_16 a4(.S(add4),.A(add3),.B(shi5),.C0(1'b0));
        CLA_16 a5(.S(add5),.A(add4),.B(shi6),.C0(1'b0));
        CLA_16 a6(.S(add6),.A(add5),.B(shi7),.C0(1'b0));
        CLA_16 a7(.S(add7),.A(add6),.B({8'b0,temp}),.C0(1'b0));
        assign result = add7;
    end
endmodule

module shifterl_1bit( result,num1,num2   );
    input [15:0]num1;
    input num2;
    output [15:0] result;
    begin
        and a1(result[15],num2,num1[14]);
        and a2(result[14],num2,num1[13]);
        and a3(result[13],num2,num1[12]);
        and a4(result[12],num2,num1[11]);
        and a5(result[11],num2,num1[10]);
        and a6(result[10],num2,num1[9]);
        and a7(result[9],num2,num1[8]);
        and a8(result[8],num2,num1[7]);
        and a9(result[7],num2,num1[6]);
        and a10(result[6],num2,num1[5]);
        and a11(result[5],num2,num1[4]);
        and a12(result[4],num2,num1[3]);
        and a13(result[3],num2,num1[2]);
        and a14(result[2],num2,num1[1]);
        and a15(result[1],num2,num1[0]);
        assign result[0]=0;
    end
endmodule

module shifterl_2bit( result,num1,num2   );
    input [15:0]num1;
    input num2;
    output [15:0] result;
    wire [15:0]temp1;wire[15:0]temp2;
    begin
        shifterl_1bit s1 (.result(temp1),.num1(num1),.num2(num2));
        shifterl_1bit s2 (.result(temp2),.num1(temp1),.num2(num2));
    end
    assign result = temp2;
endmodule

module shifterl_3bit( result,num1,num2   );
    input [15:0] num1;
    input num2;
    output [15:0] result;
    wire [15:0]temp1;wire[15:0]temp2;
    begin
        shifterl_1bit s1 (.result(temp1),.num1(num1),.num2(num2));
        shifterl_2bit s2 (.result(temp2),.num1(temp1),.num2(num2));
    end
    assign result = temp2;
endmodule

module shifterl_4bit( result,num1,num2   );
    input [15:0] num1;
    input num2;
    output [15:0] result;
    wire [15:0]temp1;wire [15:0]temp2;
    begin
        shifterl_2bit s1 (.result(temp1),.num1(num1),.num2(num2));
        shifterl_2bit s2 (.result(temp2),.num1(temp1),.num2(num2));
    end
    assign result = temp2;
endmodule

module shifterl_5bit( result,num1,num2   );
    input [15:0] num1;
    input num2;
    output [15:0] result;
    wire [15:0]temp1;wire[15:0]temp2;
    begin
        shifterl_2bit s1 (.result(temp1),.num1(num1),.num2(num2));
        shifterl_3bit s2 (.result(temp2),.num1(temp1),.num2(num2));
    end
    assign result = temp2;
endmodule

module shifterl_6bit( result,num1,num2 );
    input [15:0] num1;
    input num2;
    output [15:0] result;
    wire [15:0]temp1;wire[15:0]temp2;
    begin
        shifterl_3bit s1 (.result(temp1),.num1(num1),.num2(num2));
        shifterl_3bit s2 (.result(temp2),.num1(temp1),.num2(num2));
    end
    assign result = temp2;
endmodule

module shifterl_7bit( result,num1,num2   );
    input [15:0] num1;
    input num2;
    output [15:0] result;
    wire [15:0]temp1;wire[15:0]temp2;
    begin
        shifterl_3bit s1 (.result(temp1),.num1(num1),.num2(num2));
        shifterl_4bit s2 (.result(temp2),.num1(temp1),.num2(num2));
    end
    assign result = temp2;
endmodule

module shifterr_1bit( result,num1,num2   );
    input [15:0] num1;
    input num2;
    output [15:0] result;
    begin
        and a1(result[0],num2,num1[1]);
        and a2(result[1],num2,num1[2]);
        and a3(result[2],num2,num1[3]);
        and a4(result[3],num2,num1[4]);
        and a5(result[4],num2,num1[5]);
        and a6(result[5],num2,num1[6]);
        and a7(result[6],num2,num1[7]);
        and a8(result[7],num2,num1[8]);
        and a9(result[8],num2,num1[9]);
        and a10(result[9],num2,num1[10]);
        and a11(result[10],num2,num1[11]);
        and a12(result[11],num2,num1[12]);
        and a13(result[12],num2,num1[13]);
        and a14(result[13],num2,num1[14]);
        and a15(result[14],num2,num1[15]);
        assign result[15]=0;
    end
endmodule



