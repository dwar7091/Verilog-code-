module sensor_controller_top(
input wire clk                          ,
input wire reset                        ,
input wire temp_sensor_valid            ,
input wire [15:0] temprature_data       ,
input wire humidity_sensor_valid        ,
input wire [15:0] humidity_data         ,
input wire dew_sensor_valid             ,
input wire [15:0] dew_sensor_data       ,
input wire moisture_sensor_valid        ,
input wire [15:0] moisture_data         ,
input wire water_lvl_sensor_valid       ,
input wire [15:0] water_lvl_data        ,
input  wire [31:0] apb_addr             ,
input  wire        apb_sel              ,
input  wire        apb_enable           ,
input  wire        apb_write            ,
input  wire [31:0] apb_wdata            ,
output wire        apb_ready            ,
output wire [31:0] apb_rdata            ,
output wire        apb_slverr           ,
output wire        temp_thrhold_reached ,
output wire [15:0] temp_data_out        ,    
output wire humidity_thrhold_reached    ,
output wire [15:0] humidity_data_out    ,
output wire dew_thrhold_reached         ,
output wire [15:0] dew_data_out         ,
output wire moisture_thrhold_reached    ,
output wire [15:0] moisture_data_out    ,
output wire water_lvl_thrhold_reached   ,
output wire [15:0] water_lvl_data_out   

);

wire [31:0] temp_threshold_c;
wire [31:0] humidity_threshold_c;
wire [31:0] dew_threshold_c;
wire [31:0] soil_threshold_c;
wire [31:0] water_threshold_c;
wire lb_cs;
wire [31:0] lb_din;
wire [31:0] lb_dout;
wire lb_wrout;
wire [31:0] lb_aout;
apb_slv_iface u_apb_slv_iface
 (
   .pclk     (clk),
   .preset_n (reset),
   .paddr    (apb_addr),
   .psel     (apb_sel),
   .penable  (apb_enable),
   .pwrite   (apb_write),
   .pwdata   (apb_wdata),
   .pready   (apb_ready),
   .prdata   (apb_rdata),
   .pslverr  (apb_slverr),  
   .lb_wrout (lb_wrout),  
   .lb_aout  (lb_aout),
   .lb_dout  (lb_dout),
   .lb_cs    (lb_cs),
   .lb_rdyh  (1'b1),
   .lb_din   (lb_din)
  );


tx_proc_interface u_tx_proc_interface
  (
   .clk_sys             (clk),
   .reset_clk_sys_n     (reset),
   .csr_addr            (lb_aout),
   .csr_rd              (~lb_wrout),
   .csr_wr              (lb_wrout),
   .csr_cs_n            (lb_cs),
   .csr_wr_data         (lb_dout),
   .csr_rd_data         (lb_din),
   .temp_threshold      (temp_threshold_c),
   .humidity_threshold  (humidity_threshold_c),
   .dew_threshold       (dew_threshold_c),
   .soil_threshold      (soil_threshold_c),
   .water_threshold     (water_threshold_c) 
  );

sensor_controller u_sensor_controller
(
   .clk                      (clk),
   .reset                    (reset),
   .temp_sensor_valid        (temp_sensor_valid),
   .temprature_data          (temprature_data),
   .humidity_sensor_valid    (humidity_sensor_valid),
   .humidity_data            (humidity_data),
   .dew_sensor_valid         (dew_sensor_valid),
   .dew_sensor_data          (dew_sensor_data),
   .moisture_sensor_valid    (moisture_sensor_valid),
   .moisture_data            (moisture_data),
   .water_lvl_sensor_valid   (water_lvl_sensor_valid),
   .water_lvl_data           (water_lvl_data),
   .temp_thrhold             (temp_threshold_c[15:0]),
   .humidity_thrhold         (humidity_threshold_c[15:0]),
   .dew_thrhold              (dew_threshold_c[15:0]),
   .moisture_thrhold         (soil_threshold_c[15:0]),
   .water_lvl_thrhold        (water_threshold_c[15:0]),
   .temp_thrhold_reached     (temp_thrhold_reached),
   .temp_data_out            (temp_data_out),
   .humidity_thrhold_reached (humidity_thrhold_reached),
   .humidity_data_out        (humidity_data_out),
   .dew_thrhold_reached      (dew_thrhold_reached),
   .dew_data_out             (dew_data_out),
   .moisture_thrhold_reached (moisture_thrhold_reached),
   .moisture_data_out        (moisture_data_out),
   .water_lvl_thrhold_reached(water_lvl_thrhold_reached),
   .water_lvl_data_out       (water_lvl_data_out)
);


endmodule
