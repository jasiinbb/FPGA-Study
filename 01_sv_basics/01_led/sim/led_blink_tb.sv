module led_blink_tb ();
    logic clk;
    logic rst_n;
    logic led;
    led_blink #(
        .CLK_FREQ(10),
        .LED_FREQ(1)
    ) udut (
        .clk  (clk),
        .rst_n(rst_n),
        .led  (led)
    );
    initial begin
        clk   = 1'b0;
        rst_n = 1'b0;
    end
    always #5 clk = ~clk;
    initial begin
        #20 rst_n = 1'b1;
        #500 $finish;
    end
endmodule
