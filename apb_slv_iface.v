module apb_slv_iface
 (
  // APB Interface signals
  input  wire        pclk     ,
  input  wire        preset_n ,
  input  wire [31:0] paddr    ,
  input  wire        psel     ,
  input  wire        penable  ,
  input  wire        pwrite   ,
  input  wire [31:0] pwdata   ,
  output wire        pready   ,
  output wire [31:0] prdata   ,
  output wire        pslverr  ,
  
  // Local bus registe control signals
  output wire        lb_wrout ,   // 1- write / 0 - read
  output wire [31:0] lb_aout  ,
  output wire [31:0] lb_dout  ,
  output wire        lb_cs    ,
  input  wire        lb_rdyh  ,
  input  wire [31:0] lb_din   
  );
  
  // Internal signal declaration
  reg        lb_wrout_reg;
  reg [31:0] lb_aout_reg;
  reg [31:0] lb_dout_reg;
  reg        lb_cs_reg;
  
  // No error as this used only for the register access
  assign pslverr = 1'b0;
  
  //==========================================================================//
  // Chip select is generated once the slave is selected
  //==========================================================================//
  always@(posedge pclk or negedge preset_n)
  begin
   if ( preset_n == 1'b0 )
     lb_cs_reg <= 1'b0;
   else
     lb_cs_reg <= psel;
  end
  assign lb_cs = lb_wrout_reg? 1'b1 :1'b0;
  
  //==========================================================================//
  // This code include both setup adn access phase of APB
  //==========================================================================//
  always@(posedge pclk or negedge preset_n)
  begin
   if ( preset_n == 1'b0 )
    lb_wrout_reg <= 1'b0;
   else if ( pwrite == 1'b1 && psel == 1'b1  && penable == 1'b1 && lb_wrout_reg == 1'b0)
    lb_wrout_reg <= 1'b1;
   else 
    lb_wrout_reg <= 1'b0;
  end
  
  assign lb_wrout = lb_wrout_reg;
  
  //==========================================================================//
  // Latch the address if the slave is selected
  //==========================================================================//
  always@(posedge pclk or negedge preset_n)
  begin
   if ( preset_n == 1'b0 )
    lb_aout_reg <= 32'b0;
   else if ( psel == 1'b1 )
    lb_aout_reg <= paddr;    
  end
 
  assign lb_dout = lb_dout_reg ;
  assign lb_aout = lb_wrout_reg ? lb_aout_reg : paddr;
  
  //==========================================================================//
  // Latch the write data when the slave is selcted and enabled                                  
  //==========================================================================//  
  always@(posedge pclk or negedge preset_n)
  begin
   if ( preset_n == 1'b0 )
    lb_dout_reg <= 32'b0;
   else if ( pwrite == 1'b1 && psel == 1'b1  && penable == 1'b1)
    lb_dout_reg <= pwdata;
  end  
  
  assign prdata = lb_rdyh ? lb_din : 32'b0;
  
  // Since the Peripheral has a TWO clock fixed delay PREADY is tied high for
  // if peripheral has more than two clock delay this logic needs to be modified
  // accordingly
  assign pready = 1'b1;
  
  
endmodule 
