
`timescale 1ns / 1ps

module led_sang_tb;

    reg clk_sys;
    reg aresetn;
    reg switch;

    wire [5:0] LED;

    /
    moduleName uut (
        .clk_sys(clk_sys),
        .aresetn(aresetn),
        .switch(switch),
        .LED(LED)
    );

    // 1. Khối sinh xung clock 100MHz 
    initial begin
        clk_sys = 1'b0;
        forever #5 clk_sys = ~clk_sys;
    end

    // 2. Khối điều khiển tín hiệu kiểm thử (Stimulus)
    initial begin
        // Khởi tạo trạng thái ban đầu
        aresetn = 1'b0; // Kích hoạt reset (mức thấp)
        switch  = 1'b0;
        
        #20;            // Giữ reset trong 20ns
        aresetn = 1'b1; // Thả reset, cho mạch chạy
        
        #30;
        switch  = 1'b1; // Bật công tắc rẽ phải
        
        #100;
        switch  = 1'b0; // Chuyển công tắc rẽ trái
        
        #100;
        $finish;        
    end

endmodule
