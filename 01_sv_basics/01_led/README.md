# Day 01 - LED 与时钟分频

> 学习主线：`logic` → `always_ff` → 时钟计数器 → 复位 → 参数化设计 → Testbench → Vivado 综合/上板。

## 1. 今日目标

完成一个最基础但完整的 FPGA 工程：

**系统时钟输入 → 计数器 → LED 周期翻转**

今天重点不是“让 LED 亮”，而是建立 RTL 开发的完整思维：

```text
需求
 ↓
接口定义
 ↓
RTL设计
 ↓
Testbench
 ↓
功能仿真
 ↓
综合
 ↓
时序约束
 ↓
上板验证
 ↓
Git提交
```

## 2. 需要掌握的 SystemVerilog

### 2.1 module

理解模块的：

- `input`
- `output`
- 参数 `parameter`
- 模块例化

### 2.2 logic

本工程统一优先使用：

```systemverilog
logic clk;
logic rst_n;
logic led;
```

理解 `logic` 与传统 `wire/reg` 的区别。

### 2.3 always_ff

时序逻辑使用：

```systemverilog
always_ff @(posedge clk or negedge rst_n)
```

理解：

- 上升沿触发
- 异步低有效复位
- 寄存器在时钟沿更新

### 2.4 计数器

核心思想：

```text
0 → 1 → 2 → ... → MAX → 0
```

计数器达到设定值时翻转 LED。

## 3. 工程目录

```text
01_led/
├── rtl/
│   └── 你的 SystemVerilog RTL
│
├── tb/
│   └── 你的 Testbench
│
├── sim/
│   └── 仿真说明/脚本
│
├── constr/
│   └── 目标 FPGA 的 XDC
│
└── README.md
```

## 4. 建议模块接口

建议首先自己完成下面的接口设计：

```text
module led_blink
(
    input  logic clk,
    input  logic rst_n,
    output logic led
);
```

推荐增加参数，例如：

```systemverilog
parameter int unsigned CLK_FREQ_HZ = 50_000_000;
parameter int unsigned BLINK_FREQ_HZ = 1;
```

这样同一个 RTL 可以适配不同系统时钟。

## 5. 设计要求

### 功能要求

1. `rst_n = 0` 时 LED 进入确定的初始状态。
2. `rst_n = 1` 后计数器开始运行。
3. 计数达到设定值时 LED 翻转。
4. LED 持续周期性翻转。
5. RTL 必须可综合。
6. 不允许使用 `#delay` 实现硬件功能。

### 代码要求

- 使用 SystemVerilog。
- 时序逻辑使用 `always_ff`。
- 使用 `logic`。
- 使用参数控制时钟频率/闪烁周期。
- 计数器位宽不要无意义地写死。
- 避免产生 latch。
- 避免组合逻辑与时序逻辑混写。

## 6. Testbench 要求

Testbench 至少完成：

```text
产生 clk
   ↓
产生 reset
   ↓
释放 reset
   ↓
运行若干个 LED 周期
   ↓
检查 LED 是否按预期翻转
```

建议包含：

- `initial`
- 时钟生成
- reset 控制
- `$display`
- `$finish`
- 基本断言或条件检查

## 7. 仿真注意事项

真实 FPGA 可能使用 50 MHz / 100 MHz 等时钟，如果直接仿真完整 1 秒闪烁周期，会产生大量仿真时间。

因此 Testbench 中可以使用较小的参数，例如：

```text
CLK_FREQ_HZ = 10
BLINK_FREQ_HZ = 1
```

或者直接设计测试专用的小计数值。

**注意：不要为了仿真方便而修改硬件设计逻辑；优先使用 parameter。**

## 8. Vivado 实验

创建 RTL Project：

1. 添加 `rtl/*.sv`
2. 添加 `tb/*.sv`
3. 添加目标 FPGA
4. 添加 `constr/*.xdc`
5. Run Simulation
6. Run Synthesis
7. Run Implementation
8. 查看 Timing Summary
9. Generate Bitstream
10. 下载 FPGA
11. 观察 LED

## 9. XDC

由于本仓库暂时不绑定具体开发板，因此不要直接填写未知的 FPGA 引脚。

拿到具体开发板后，根据开发板原理图/官方 XDC 添加：

```text
clk 引脚
led 引脚
IOSTANDARD
create_clock
```

## 10. 验收标准

### RTL

- [ ] 能解释每一行代码
- [ ] 能解释计数器为什么需要这么多位
- [ ] 能解释 LED 为什么需要计数后才翻转
- [ ] 能解释 reset 的作用
- [ ] 能解释 `always_ff`
- [ ] 能修改参数后重新综合

### 仿真

- [ ] reset 正常
- [ ] counter 正常递增
- [ ] LED 正常翻转
- [ ] 没有 X/Z 异常
- [ ] Testbench 能自动结束

### FPGA

- [ ] 综合通过
- [ ] Implementation 通过
- [ ] Timing 通过
- [ ] Bitstream 生成成功
- [ ] 上板 LED 正常闪烁

## 11. 今天不要直接复制答案

建议顺序：

### 第一步

自己写 RTL。

### 第二步

自己写 Testbench。

### 第三步

自己跑仿真。

### 第四步

如果报错，把：

- 错误信息
- RTL
- Testbench
- 波形截图

发出来分析。

### 第五步

完成后提交：

```text
Day 01 complete: LED blink with parameterized counter
```

## 12. 今日核心知识

最终应该真正理解这句话：

> **FPGA 不是按照 C 语言那样“执行代码”，而是通过 RTL 描述硬件电路。**

今天的 `counter` 本质上就是一组触发器 + 加法器 + 比较逻辑。

LED 闪烁只是这个硬件系统最直观的输出。

## 13. 下一天

**Day 02：按键输入 + 同步 + 消抖**

届时开始学习真实 FPGA 输入信号为什么不能直接使用，以及同步器和消抖电路为什么必须存在。
