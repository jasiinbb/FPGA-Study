# FPGA + SystemVerilog 学习计划

> 目标：以“每天一个 SystemVerilog + FPGA 例程”为主线，把语言能力、RTL 思维、时序设计、接口协议和工程能力同步训练。

## 学习规则

- 每天完成 1 个可综合/可仿真的小例程。
- 每个例程必须包含：RTL、Testbench、README、仿真结果/波形说明。
- 能上板的例程优先上板验证。
- 每完成一个例程，提交一次 Git commit。
- 协议类模块尽量写成可复用模块，而不是只写一次性测试代码。

## 第一阶段：SystemVerilog + RTL 基础（Day 01-10）

| Day | 学习内容 | GitHub 工程 |
|---|---|---|
| 01 | module、logic、always_comb/always_ff | `01_sv_basics/01_led` |
| 02 | 按键输入、同步、消抖 | `01_sv_basics/02_key_debounce` |
| 03 | 计数器、分频、定时器 | `01_sv_basics/03_counter_timer` |
| 04 | FSM 状态机 | `01_sv_basics/04_fsm` |
| 05 | 可参数化设计 | `01_sv_basics/05_parameterized` |
| 06 | array、packed/unpacked array | `01_sv_basics/06_array` |
| 07 | struct、enum、typedef | `01_sv_basics/07_struct_enum` |
| 08 | task/function、interface 基础 | `01_sv_basics/08_sv_constructs` |
| 09 | Testbench、断言、$display | `01_sv_basics/09_testbench` |
| 10 | 综合 + 仿真 + 上板小项目 | `01_sv_basics/10_mini_project` |

## 第二阶段：常用 RTL 模块（Day 11-20）

| Day | 学习内容 | GitHub 工程 |
|---|---|---|
| 11 | UART TX | `02_rtl_modules/11_uart_tx` |
| 12 | UART RX | `02_rtl_modules/12_uart_rx` |
| 13 | UART 收发整合 | `02_rtl_modules/13_uart` |
| 14 | FIFO | `02_rtl_modules/14_fifo` |
| 15 | 同步 FIFO + 状态管理 | `02_rtl_modules/15_sync_fifo` |
| 16 | 异步 FIFO / CDC | `02_rtl_modules/16_async_fifo` |
| 17 | PWM | `02_rtl_modules/17_pwm` |
| 18 | SPI Master | `02_rtl_modules/18_spi_master` |
| 19 | I2C Master | `02_rtl_modules/19_i2c_master` |
| 20 | 模块化寄存器接口 | `02_rtl_modules/20_reg_interface` |

## 第三阶段：FPGA 工程与高速接口（Day 21-30）

| Day | 学习内容 | GitHub 工程 |
|---|---|---|
| 21 | AXI-Lite 从机 | `03_interfaces/21_axi_lite_slave` |
| 22 | AXI-Stream | `03_interfaces/22_axi_stream` |
| 23 | CDC 与跨时钟域 | `03_interfaces/23_cdc` |
| 24 | BRAM / ROM | `03_interfaces/24_bram_rom` |
| 25 | DMA 数据通路思想 | `03_interfaces/25_dma_datapath` |
| 26 | GMII 数据收发 | `03_interfaces/26_gmii` |
| 27 | Ethernet MAC 基础 | `03_interfaces/27_ethernet_mac` |
| 28 | SGMII / PCS-PMA 工程 | `03_interfaces/28_sgmii` |
| 29 | SPI 外设寄存器读取 | `03_interfaces/29_spi_device` |
| 30 | 综合型数据链路项目 | `03_interfaces/30_datapath_project` |

## 第四阶段：协议与工程项目（Day 31+）

重点转向实际 FPGA 开发中可以复用的模块：

- UART / RS232 / RS485
- SPI / I2C
- CAN / CAN-FD
- ARINC429
- Ethernet / UDP
- AXI4 / AXI-Lite / AXI-Stream
- PCIe
- DDR / FIFO / DMA
- LVDS / SERDES
- 时钟、复位、CDC
- CRC / 校验 / 帧解析
- 寄存器映射与软硬件协同

## 项目升级路线

`单模块 → 可仿真模块 → 可复用 IP → 多模块数据通路 → 板级接口 → 完整 FPGA 项目`

最终目标不是“会写 Verilog”，而是能够独立完成：

`需求分析 → RTL设计 → Testbench → 仿真 → 时序约束 → 综合 → 上板 → ILA调试 → 文档 → Git版本管理`
