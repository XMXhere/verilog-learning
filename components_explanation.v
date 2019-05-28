// --------------- SR锁存器模块---------------
// 模块名和端口列表
module SR_latch(Q, Qbar, Sbar, Rbar);

// 端口声明
output Q, Qbar;
input Sbar, Rbar;

// 调用低层次的模块
nand n1(Q, Sbar, Qbar);
nand n2(Qbar, Rbar, Q);

//模块语句的结束
endmodule

// ----------------测试激励信号模块---------------
//模块名和端口列表
module Top;

// 声明wire, reg和其他类型的变量
wire q, qbar;
reg set, reset;

//调用较低层次的模块
SR_latch m1(q, qbar, ~set, ~reset);

//行为模块，初始化
initial
begin
  $monitor($time, " set = %b, reset = %b, q = %b\n", set, reset, q);
  set = 0; reset = 0;
  #5 reset = 1;
  #5 reset = 0;
  #5 set = 1;
 end
 
 //模块语句结束
 endmodule
