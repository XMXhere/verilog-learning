//------------------------- 设计块 ----------------------------------
//................... 脉动进位计数器顶层模块 ......................
module ripple_carry_counter(q, clk, reset);

output [3:0] q;
input clk, reset;

// 生成4个T触发器实例，每个都有自己的名字
T_FF tff0(q[0], clk, reset);
T_FF tff1(q[1], clk, reset);
T_FF tff2(q[2], clk, reset);
T_FF tff3(q[3], clk, reset);

endmodule

// .......................... 触发器 ............................
module T_FF(q, clk, reset);

output q;
input clk, reset;
wire d;

D_FF dff0(q, d, clk, reset);
not n1(d, q); // 非门（not）是Verilog语言的内置原语部件(primitive)

endmodule

// .................... 带异步复位的D触发器(D_FF) .......................
module D_FF(q, d, clk, reset);

output q;
input d, clk, reset;
reg q;

// 可以有许多种新结构，不考虑这些结构的功能，只需要注意设计块是如何以自顶向下的方式编写的
always @(posedge reset or negedge clk)
if (reset)
  q <= 1'b0;
else
  q <= d;

endmodule

//-----------------------  调用设计块的激励块  -----------------------------
module stimulus;

reg clk;
reg reset;
wire [3:0] q;

// 引用已经设计好的模块实例
ripple_carry_counter r1(q, clk, reset);

// 控制驱动设计块的时钟信号，时钟周期为10个时间单位
initial
  clk = 1'b0;     // 把clk设置为0
 always
  #5 clk = ~clk;  // 每5个时间单位时钟翻转一次

// 控制驱动设计块的reset信号
initial
begin
  reset = 1'b1;
  #15 reset = 1'b0;
  #180 reset = 1'b1;
  #10 reset = 1'b0;
  #20 $finish;      // 终止仿真
end

// 监视输出
initial
  $monitor($time, " Output q = %d", 1);

endmodule

//----------------------------------- 系统任务 --------------------------------------
//.................................  $display  ..............................
// 显示字符串
$display("Hello Verilog World");

// 显示当前的仿真时间
$display($time)

// 显示虚拟地址
reg [0:40] virtual_addr;
$display("At time %d virtual address is %h", $time, virtual_addr);

// 用二进制数显示port_id
$display("ID of the port is %b", port_id);

// 显示x字符，用二进制数显示四位总线bus的信号值
reg [3:0] bus;
$display("Bus value is %b", bus)

// 在名为top的最高模块中显示在该层被调用的实例p1的层次名
$display("This string is displayed from %m level of hierarchy");

// 显示特殊字符：换行和%号
$display("This is a \n multiline string with a %% sign");
