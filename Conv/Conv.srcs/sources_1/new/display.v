module display(
    //时钟与位信号
     input clk,
    input resetn,    //后缀"n"代表低电平有效

    //拨码开关，用于选择输入数和产生cin
    input [6:1] input_sel,//1-25为第一个矩阵的输入 26-50为第二个矩阵的输入
    //led灯，用于显示cout
    output led_cout,
    //触摸屏相关接口，不需要更改
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );

//-----{调用逻辑模块}begin
    reg [7:0] input1[1:25];
    reg [7:0] input2[1:9];
    wire [19:0] result[1:9]  ;
   
//-----{调用逻辑模块}end
    Conv_53  a1 (
    .clk(clk),
    .rst(restn),
    .A11(input1[1]),
    .A12(input1[2]),
    .A13(input1[3]),
    .A14(input1[4]),
    .A15(input1[5]),
    .A21(input1[6]),
    .A22(input1[7]),
    .A23(input1[8]),
    .A24(input1[9]),
    .A25(input1[10]),
    .A31(input1[11]),
    .A32(input1[12]),
    .A33(input1[13]),
    .A34(input1[14]),
    .A35(input1[15]),
    .A41(input1[16]),
    .A42(input1[17]),
    .A43(input1[18]),
    .A44(input1[19]),
    .A45(input1[20]),
    .A51(input1[21]),
    .A52(input1[22]),
    .A53(input1[23]),
    .A54(input1[24]),
    .A55(input1[25]),

    .k11(input2[1]),
    .k12(input2[2]),
    .k13(input2[3]),
    .k21(input2[4]),
    .k22(input2[5]),
    .k23(input2[6]),
    .k31(input2[7]),
    .k32(input2[8]),
    .k33(input2[9]),

    .out11(result[1]),
    .out12(result[2]),
    .out13(result[3]),
    .out21(result[4]),
    .out22(result[5]),
    .out23(result[6]),
    .out31(result[7]),
    .out32(result[8]),
    .out33(result[9])
);
//---------------------{调用触摸屏模块}begin--------------------//
//-----{实例化触摸屏}begin
//此小节不需要更改
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //调用触摸屏的接口
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd触摸屏相关接口，不需要更改
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{实例化触摸屏}end

//-----{从触摸屏获取输入}begin
//根据实际需要输入的数修改此小节，
//建议对每一个数的输入，编写单独一个always块
    always @(posedge clk)
begin
if (!resetn)
begin
    input1[1] <= 8'd0;
end
else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&!input_sel[3]&&!input_sel[2]&&!input_sel[1])
begin
   input1[1] <= input_value;
end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[2] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&!input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input1[2] <= input_value;
    end
end
always @(posedge clk)
    begin
        if (!resetn)
        begin
            input1[3] <= 8'd0;
        end
        else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&!input_sel[3]&&input_sel[2]&&!input_sel[1])
        begin
           input1[3] <= input_value;
        end
    end
always @(posedge clk)
    begin
        if (!resetn)
        begin
            input1[4] <= 8'd0;
        end
        else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&!input_sel[3]&&input_sel[2]&&input_sel[1])
        begin
           input1[4] <= input_value;
        end
    end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[5] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input1[5] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[6] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input1[6] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[7] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input1[7] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[8] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&!input_sel[4]&&input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input1[8] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[9] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&!input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input1[9] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[10] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&!input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input1[10] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[11] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&!input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input1[11] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[12] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&!input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input1[12] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[13] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input1[13] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[14] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input1[14] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[15] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input1[15] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[16] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&!input_sel[5]&&input_sel[4]&&input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input1[16] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[17] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&!input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input1[17] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[18] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&!input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input1[18] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[19] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&!input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input1[19] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[20] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&!input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input1[20] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[21] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input1[21] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[22] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input1[22] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[23] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input1[23] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[24] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&!input_sel[4]&&input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input1[24] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input1[25] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&!input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input1[25] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[1] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&!input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input2[1] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[2] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&!input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input2[2] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[3] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&!input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input2[3] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[4] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input2[4] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[5] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input2[5] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[6] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&input_sel[3]&&input_sel[2]&&!input_sel[1])
    begin
       input2[6] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[7] <= 8'd0;
    end
    else if (input_valid && !input_sel[6]&&input_sel[5]&&input_sel[4]&&input_sel[3]&&input_sel[2]&&input_sel[1])
    begin
       input2[7] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[8] <= 8'd0;
    end
    else if (input_valid && input_sel[6]&&!input_sel[5]&&!input_sel[4]&&!input_sel[3]&&!input_sel[2]&&!input_sel[1])
    begin
       input2[8] <= input_value;
    end
end
always @(posedge clk)
begin
    if (!resetn)
    begin
        input2[9] <= 8'd0;
    end
    else if (input_valid && input_sel[6]&&!input_sel[5]&&!input_sel[4]&&!input_sel[3]&&!input_sel[2]&&input_sel[1])
    begin
       input2[9] <= input_value;
    end
end
    //-----{从触摸屏获取输入}end

//-----{输出到触摸屏显示}begin
//根据需要显示的数修改此小节，
//触摸屏上共有44块显示区域，可显示44组32位数据
//44块显示区域从1开始编号，编号为1~44，
//显示第1个输入的矩阵
//显示第一个输入的矩阵
always @(posedge clk)
begin
    case(display_number)
        6'd1 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A11";
           display_value <= input1[1];
        end
        6'd2 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A12";
           display_value <= input1[2];
        end
        6'd3 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A13";
           display_value <= input1[3];
        end
        6'd4 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A14";
           display_value <= input1[4];
        end
        6'd5 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A15";
           display_value <= input1[5];
        end
        6'd6 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A21";
           display_value <= input1[6];
        end 
        6'd7 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A22";
           display_value <= input1[7];
        end 
        6'd8 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A23";
           display_value <= input1[8];
        end 
        6'd9 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A24";
           display_value <= input1[9];
        end 
        6'd10 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A25";
           display_value <= input1[10];
        end 
        6'd11 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A31";
           display_value <= input1[11];
        end 
        6'd12 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A32";
           display_value <= input1[12];
        end 
        6'd13 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A33";
           display_value <= input1[13];
        end
        6'd14 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A34";
           display_value <= input1[14];
        end  
        6'd15 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A35";
           display_value <= input1[15];
        end 
        6'd16 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A41";
           display_value <= input1[16];
        end 
        6'd17 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A42";
           display_value <= input1[17];
        end 
        6'd18 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A43";
           display_value <= input1[18];
        end 
        6'd19 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A44";
           display_value <= input1[19];
        end 
        6'd20 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A45";
           display_value <= input1[20];
        end 
        6'd21 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A51";
           display_value <= input1[21];
        end 
        6'd22 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A52";
           display_value <= input1[22];
        end 
        6'd23 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A53";
           display_value <= input1[23];
        end 
        6'd24 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A54";
           display_value <= input1[24];
        end 
        6'd25 :
        begin
           display_valid <= 1'b1;
           display_name  <= "A55";
           display_value <= input1[25];
        end 
        6'd26 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K11";
           display_value <= input2[1];
        end 
        6'd27 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K12";
           display_value <= input2[2];
        end 
        6'd28 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K13";
           display_value <= input2[3];
        end
        6'd29 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K21";
           display_value <= input2[4];
        end 
        6'd30 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K22";
           display_value <= input2[5];
        end 6'd31 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K23";
           display_value <= input2[6];
        end 
        6'd32 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K31";
           display_value <= input2[7];
        end 
        6'd33 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K32";
           display_value <= input2[8];
        end 
        6'd34 :
        begin
           display_valid <= 1'b1;
           display_name  <= "K33";
           display_value <= input2[9];
        end
        6'd35 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R1";
           display_value <= result[1];
        end 
        6'd36 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R2";
           display_value <= result[2];
        end 
        6'd37 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R3";
           display_value <= result[3];
        end 
        6'd38 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R4";
           display_value <= result[4];
        end 
        6'd39 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R5";
           display_value <= result[5];
        end 
        6'd40 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R6";
           display_value <= result[6];
        end 
        6'd41 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R7";
           display_value <= result[7];
        end 
        6'd42 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R8";
           display_value <= result[8];
        end 
        6'd43 :
        begin
           display_valid <= 1'b1;
           display_name  <= "R9";
           display_value <= result[9];
        end 
        6'd44:
        begin
           display_valid <= 1'b0;
           display_name  <= 40'd0;
           display_value <= 20'd0;
        end 
    endcase
end                                                                                               
endmodule
