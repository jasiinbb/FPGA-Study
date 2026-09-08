# RTL
在此添加 SystemVerilog RTL 源文件（*.sv）。
module led_blink #(
    parameter int unsigned CLK_FREQ = 25_000_000,
    parameter int unsigned LED_FREQ = 1
) (
    input  logic clk,
    input  logic rst_n,
    output logic led
);
    localparam int CntMax   = CLK_FREQ / (2 * LED_FREQ);
    localparam int CntWidth = $clog2(CntMax);

    logic [CntWidth-1:0] cnt;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led <= '0;
            cnt <= '0;
        end else if (cnt == CntMax - 1) begin
            led <= ~led;
            cnt <= '0;
        end else cnt <= cnt + 1'b1;
    end
endmodule
