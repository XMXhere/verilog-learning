// 四选一多路选择器模块
module mux4_to_1 (out, i0, i1, i2, i3, s1, s0);

//直接取自于输入/输出图的端口声明语句
output out;
input i0, i1, i2, i3;
input s0, s1;

//内部线网声明
wire s1n, s0n;
wire y0, y1, y2, y3;

//门级实例引用

//生成s1n和s0n信号
not (s1n, s1)
not (s0n, s0)

//调用三输入与门
and (y0, i0, s1n, s0n);
and (y1, i1, s1n, s0);
and (y2, i2, s1, s0n);
and (y3, i3, s1, s0);

//调用四输入或门
or (out, y0, y1, y2, y3);

endmodule

//无端口激励模块
module stimulus;

//声明连接到输入端口的变量；
reg IN0, IN1, IN2, IN3;
reg S0, S1;

//声明输出连线
wire OUTPUT;

//调用多路器
mux4_to_1 mymux (OUTPUT, IN0, IN1, IN2, IN3, S1, S0);

//产生输入激励信号
initial
begin
  IN0 = 1; IN1 = 0; IN2 = 1; IN3 = 0;
  #1 $display("IN0 = %b, IN1 = %b, IN2 = %b, IN3 = %b\n", IN0, IN1, IN2, IN3);
  
  //选择IN0
  S1 = 0; S0 = 0;
  #1 $display("S1 = %b, S0 = %b, OUTPUT = %b\n", S1, S0, OUTPUT);
  //选择IN1
  S1 = 0; S0 = 1;
  #1 $display("S1 = %b, S0 = %b, OUTPUT = %b\n", S1, S0, OUTPUT);
  //选择IN2
  S1 = 1; S0 = 0;
  #1 $display("S1 = %b, S0 = %b, OUTPUT = %b\n", S1, S0, OUTPUT);
  //选择IN3
  S1 = 1; S0 = 1;
  #1 $display("S1 = %b, S0 = %b, OUTPUT = %b\n", S1, S0, OUTPUT);
end

endmodule
