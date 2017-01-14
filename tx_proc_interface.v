module tx_proc_interface
  (
    input  wire         clk_sys             ,
    input  wire         reset_clk_sys_n     ,
    input  wire [31:0]  csr_addr            ,
    input  wire         csr_rd              ,
    input  wire         csr_wr              ,
    input  wire         csr_cs_n            ,
    input  wire [31:0]  csr_wr_data         ,
    output wire [31:0]  csr_rd_data         ,
    output wire [31:0]  temp_threshold      ,
    output wire [31:0]  humidity_threshold  ,
    output wire [31:0]  dew_threshold       ,
    output wire [31:0]  soil_threshold      ,
    output wire [31:0]  water_threshold      
  );

//----------------------------------------------------------------------------//
/* Interanl signal declaration*/
//----------------------------------------------------------------------------//
reg [31:0] sig_out_data           ;
reg [31:0] temp_threshold_reg     ;
reg [31:0] humidity_threshold_reg ;
reg [31:0] dew_threshold_reg      ;
reg [31:0] soil_threshold_reg     ;
reg [31:0] water_threshold_reg    ;


//----------------------------------------------------------------------------//
/* This process implements the read operation for the CPU. When ever the processor
 request for the read operation of a particular register, the content of the register
 is placed on the data out but */
 //----------------------------------------------------------------------------//
always @(*)
  begin:read_sel_csi
    case(csr_addr)
      32'h0000 : sig_out_data = temp_threshold_reg;
      32'h0004 : sig_out_data = humidity_threshold_reg;
      32'h0008 : sig_out_data = dew_threshold_reg;
      32'h000C : sig_out_data = soil_threshold_reg;
      32'h0010 : sig_out_data = water_threshold_reg;
      default: sig_out_data = 32'h0;
    endcase
  end



assign csr_rd_data = sig_out_data;

//----------------------------------------------------------------------------//
/* The write command of CPU to tempature threshold is captured */
//----------------------------------------------------------------------------//
always@(posedge clk_sys or negedge reset_clk_sys_n)
begin
  if(!reset_clk_sys_n)
    temp_threshold_reg <= 32'h00000000;
  else if(csr_addr == 32'h0000 && csr_wr && (csr_cs_n))
    temp_threshold_reg <= csr_wr_data;
end

assign temp_threshold = temp_threshold_reg;
//----------------------------------------------------------------------------//
/* The write command of CPU to humidity_threshold_reg is captured */
//----------------------------------------------------------------------------//
always@(posedge clk_sys or negedge reset_clk_sys_n)
begin
  if(!reset_clk_sys_n)
    humidity_threshold_reg <= 32'h00000000;
  else if(csr_addr == 32'h0004 && csr_wr && (csr_cs_n))
    humidity_threshold_reg <= csr_wr_data;
end

assign humidity_threshold = humidity_threshold_reg;
//----------------------------------------------------------------------------//
/* The write command of CPU to dew_threshold_reg is captured */
//----------------------------------------------------------------------------//
always@(posedge clk_sys or negedge reset_clk_sys_n)
begin
  if(!reset_clk_sys_n)
    dew_threshold_reg <= 32'h00000000;
  else if(csr_addr == 32'h0008 && csr_wr && (csr_cs_n))
    dew_threshold_reg <= csr_wr_data;
end

assign dew_threshold = dew_threshold_reg;
//----------------------------------------------------------------------------//
/* The write command of CPU to soil_threshold_reg is captured */
//----------------------------------------------------------------------------//
always@(posedge clk_sys or negedge reset_clk_sys_n)
begin
  if(!reset_clk_sys_n)
    soil_threshold_reg <= 32'h00000000;
  else if(csr_addr == 32'h000C && csr_wr && (csr_cs_n))
    soil_threshold_reg <= csr_wr_data;
end

assign soil_threshold = soil_threshold_reg;
//----------------------------------------------------------------------------//
/* The write command of CPU to water_threshold_reg is captured */
//----------------------------------------------------------------------------//
always@(posedge clk_sys or negedge reset_clk_sys_n)
begin
  if(!reset_clk_sys_n)
    water_threshold_reg <= 32'h00000000;
  else if(csr_addr == 32'h0010 && csr_wr && (csr_cs_n))
    water_threshold_reg <= csr_wr_data;
end

assign water_threshold = water_threshold_reg;
endmodule
