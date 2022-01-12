`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/07 22:00:57
// Design Name: 
// Module Name: adder32
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

//20位加法器
module adder20(
    a,b,s,
);
    input [20-1:0] a;
    input [20-1:0] b;
    output [20-1:0] s;

    wire Px0,Gx0;
    wire C16;
    wire [1:0]y;

    CLA_16 CLA1(
        .A(a[15:0]),
        .B(b[15:0]),
        .C0(1'b0),
        .S(s[15:0]),
        .Px(Px0),
        .Gx(Gx0)
    );

    adder_4 adder_4(
        .A(a[19:16]),
        .B(b[19:16]),
        .C0(C16),
        .S(s[19:16])
    );
    //C16 
    and  a1(y[0],Px0,0); //C0 = 0
    xor  x1(C16,Gx0,y[0]);

endmodule

//16位CLA部件
module CLA_16(A,B,C0,S,Px,Gx);
    input [16-1:0] A;
    input [16-1:0] B;
    input C0;
    output Px,Gx;
    output [16-1:0] S;

    wire C4,C8,C12;
    wire Pm0,Gm0,Pm1,Gm1,Pm2,Gm2,Pm3,Gm3;
    wire [8:0]y;

    adder_4 adder1(
        .A(A[3:0]),
        .B(B[3:0]),
        .C0(C0),
        .C4(),
        .S(S[3:0]),
        .Gm(Gm0),
        .Pm(Pm0)
    );

    adder_4 adder2(
        .A(A[7:4]),
        .B(B[7:4]),
        .C0(C4),
        .C4(),
        .S(S[7:4]),
        .Gm(Gm1),
        .Pm(Pm1)
    );

    adder_4 adder3(
        .A(A[11:8]),
        .B(B[11:8]),
        .C0(C8),
        .C4(),
        .S(S[11:8]),
        .Gm(Gm2),
        .Pm(Pm2)
    );

    adder_4 adder4(
        .A(A[15:12]),
        .B(B[15:12]),
        .C0(C12),
        .C4(),
        .S(S[15:12]),
        .Gm(Gm3),
        .Pm(Pm3)
    );

    //C4
    and  a11(y[0],Pm0,C0);
    xor  x1(C4,Gm0,y[0]);
    //C8
    and  a21(y[1],Pm1,Gm0),
    a22(y[2],Pm1,Pm0,C0);
    xor  x2(C8,Gm1,y[1],y[2]);
    //C12
    and  a31(y[3],Pm2,Gm1),
    a32(y[4],Pm2,Pm1,Gm0),
    a33(y[5],Pm2,Pm1,Pm0,C0);
    xor  x3(C12,Gm2,y[3],y[4],y[5]);
    //Px and Gx
    and  a41(Px,Pm3,Pm2,Pm1,Pm0),
    a42(y[6],Pm2,Gm1),
    a43(y[7],Pm2,Pm1,Gm0),
    a44(y[8],Pm2,Pm1,Pm0,C0);

    xor  x4(Gx,y[6],y[7],y[8]);

endmodule

//四位并行进位加法器
module adder_4(A,B,C0,C4,S,Gm,Pm);
    input [4-1:0] A;
    input [4-1:0] B;
    input C0;
    output C4,Gm,Pm;
    output [4-1:0] S;

    wire P0,P1,P2,P3,P4,G0,G1,G2,G3;
    wire C1,C2,C3;
    wire [2:0]w;

    adder adder1(
        .A(A[0]),
        .B(B[0]),
        .Cin(C0),
        .S(S[0]),
        .Cout()
    );

    adder adder2(
        .A(A[1]),
        .B(B[1]),
        .Cin(C1),
        .S(S[1]),
        .Cout()
    );

    adder adder3(
        .A(A[2]),
        .B(B[2]),
        .Cin(C2),
        .S(S[2]),
        .Cout()
    );

    adder adder4(
        .A(A[3]),
        .B(B[3]),
        .Cin(C3),
        .S(S[3]),
        .Cout()
    );

    CLA CLA(
        .C0(C0),
        .C1(C1),
        .C2(C2),
        .C3(C3),
        .C4(C4),
        .P0(P0),
        .P1(P1),
        .P2(P2),
        .P3(P3),
        .G0(G0),
        .G1(G1),
        .G2(G2),
        .G3(G3)
    );

    and  a1(G0,A[0],B[0]),
    a2(G1,A[1],B[1]),
    a3(G2,A[2],B[2]),
    a4(G3,A[3],B[3]),
    a5(Pm,P3,P2,P1,P0),
    a6(w[0],P3,G2),
    a7(w[1],P3,P2,G1),
    a8(w[2],P3,P2,P1,G0);

    xor  x1(P0,A[0],B[0]),
    x2(P1,A[1],B[1]),
    x3(P2,A[2],B[2]),
    x4(P3,A[3],B[3]),
    x5(Gm,G3,w[0],w[1],w[2]);

endmodule

//4位CLA部件
module CLA(C0,C1,C2,C3,C4,P0,P1,P2,P3,G0,G1,G2,G3);

    input C0,G0,G1,G2,G3,P0,P1,P2,P3;
    output C1,C2,C3,C4;
    wire [9:0]y;
    //C1
    and a11(y[0],P0,C0);
    or  b1(C1,G0,y[0]);
    //C2
    and a21(y[1],P1,G0),
    a22(y[2],P1,P0,C0);
    or  b2(C2,G1,y[1],y[2]);
    //C3
    and a31(y[3],P2,G1),
    a32(y[4],P2,P1,G0),
    a33(y[5],P2,P1,P0,C0);
    or  b3(C3,G2,y[3],y[4],y[5]);
    //C4
    and a41(y[6],P3,G2),
    a42(y[7],P3,P2,G1),
    a43(y[8],P3,P2,P1,G0),
    a44(y[9],P3,P2,P1,P0,C0);
    or  b4(C4,G3,y[6],y[7],y[8],y[9]);

endmodule

//一位全加器
module adder(A,B,Cin,S,Cout);

    input A,B,Cin;
    output S,Cout;
    wire [3-1:0] w;

    and a1(w[0],A,Cin),
    a2(w[1],A,B),
    a3(w[2],B,Cin);
    xor a4(S,A,B,Cin);
    or  a5(Cout,w[0],w[1],w[2]);

endmodule
