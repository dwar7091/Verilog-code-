module sensor_controller(
input wire clk,
input wire reset,
input wire temp_sensor_valid,
input wire [15:0] temprature_data,
input wire humidity_sensor_valid,
input wire [15:0] humidity_data,
input wire dew_sensor_valid,
input wire [15:0] dew_sensor_data,
input wire moisture_sensor_valid,
input wire [15:0] moisture_data,
input wire water_lvl_sensor_valid,
input wire [15:0] water_lvl_data,
input wire [15:0]temp_thrhold,
input wire [15:0]humidity_thrhold,
input wire [15:0]dew_thrhold,
input wire [15:0]moisture_thrhold,
input wire [15:0]water_lvl_thrhold,
output wire temp_thrhold_reached,
output wire [15:0] temp_data_out,
output wire humidity_thrhold_reached,
output wire [15:0] humidity_data_out,
output wire dew_thrhold_reached,
output wire [15:0] dew_data_out,
output wire moisture_thrhold_reached,
output wire [15:0] moisture_data_out,
output wire water_lvl_thrhold_reached,
output wire [15:0] water_lvl_data_out
);

reg temp_thrhold_reached_d;
reg humidity_thrhold_reached_d;
reg dew_thrhold_reached_d;
reg moisture_thrhold_reached_d;
reg water_lvl_thrhold_reached_d;
reg [15:0]temp_data_out_d;
reg [15:0]humidity_data_out_d;
reg [15:0]dew_data_out_d;
reg [15:0]moisture_data_out_d;
reg [15:0]water_lvl_data_out_d;

assign temp_thrhold_reached = temp_thrhold_reached_d;
assign humidity_thrhold_reached = humidity_thrhold_reached_d;
assign dew_thrhold_reached = dew_thrhold_reached_d;
assign moisture_thrhold_reached = moisture_thrhold_reached_d;
assign water_lvl_thrhold_reached = water_lvl_thrhold_reached_d;

assign temp_data_out = temp_data_out_d;
assign humidity_data_out = humidity_data_out_d;
assign dew_data_out = dew_data_out_d;
assign moisture_data_out = moisture_data_out_d;
assign water_lvl_data_out = water_lvl_data_out_d;


/* temparature threshold comaparision  data assignment*/

always @(posedge clk or negedge reset)
begin
if(!reset)
temp_data_out_d <= 16'h0;
else if(temp_sensor_valid && (temprature_data >= temp_thrhold))
temp_data_out_d <= temprature_data;
end

/* humidity threshold comaparision  data assignment*/

always @(posedge clk or negedge reset)
begin
if(!reset)
humidity_data_out_d <= 16'h0;
else if(humidity_sensor_valid && (humidity_data >= humidity_thrhold))
humidity_data_out_d <= humidity_data;
end


/* dew threshold comaparision  data assignment*/

always @(posedge clk or negedge reset)
begin
if(!reset)
dew_data_out_d <= 16'h0;
else if(dew_sensor_valid && (dew_sensor_data >= dew_thrhold))
dew_data_out_d <= dew_sensor_data;
end

/* moisture threshold comaparision  data assignment*/

always @(posedge clk or negedge reset)
begin
if(!reset)
moisture_data_out_d <= 16'h0;
else if(moisture_sensor_valid && (moisture_data >= moisture_thrhold))
moisture_data_out_d <= moisture_data;
end

/* moisture threshold comaparision  data assignment*/

always @(posedge clk or negedge reset)
begin
if(!reset)
water_lvl_data_out_d <= 16'h0;
else if(water_lvl_sensor_valid && (water_lvl_data >= water_lvl_thrhold))
water_lvl_data_out_d <= water_lvl_data;
end


/* temparature threshold comaparision */

always @(posedge clk or negedge reset)
begin
if(!reset)
temp_thrhold_reached_d <= 1'b0;
else if(temp_sensor_valid && (temprature_data >= temp_thrhold))
temp_thrhold_reached_d <= 1'b1;
else 
temp_thrhold_reached_d <= 1'b0;
end

/* humidity threshold comaparision */

always @(posedge clk or negedge reset)
begin
if(!reset)
humidity_thrhold_reached_d <= 1'b0;
else if(humidity_sensor_valid && (humidity_data >= humidity_thrhold))
humidity_thrhold_reached_d <= 1'b1;
else
humidity_thrhold_reached_d <= 1'b0;
end


/* dew threshold comaparision */

always @(posedge clk or negedge reset)
begin
if(!reset)
dew_thrhold_reached_d <= 1'b0;
else if(dew_sensor_valid && (dew_sensor_data >= dew_thrhold))
dew_thrhold_reached_d <= 1'b1;
else
dew_thrhold_reached_d <= 1'b0;
end

/* moisture threshold comaparision */

always @(posedge clk or negedge reset)
begin
if(!reset)
moisture_thrhold_reached_d <= 1'b0;
else if(moisture_sensor_valid && (moisture_data >= moisture_thrhold))
moisture_thrhold_reached_d <= 1'b1;
else
moisture_thrhold_reached_d <= 1'b0;
end

/* moisture threshold comaparision */

always @(posedge clk or negedge reset)
begin
if(!reset)
water_lvl_thrhold_reached_d <= 1'b0;
else if(water_lvl_sensor_valid && (water_lvl_data >= water_lvl_thrhold))
water_lvl_thrhold_reached_d <= 1'b1;
else
water_lvl_thrhold_reached_d <= 1'b0;
end


endmodule
