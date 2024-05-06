// a minimal example which shows IO cells 
// instantiation 

module mini
(
  inout  wire clk_pad,
  inout  wire rst_pad,
  inout  wire xIn1_pad,
  inout  wire xIn2_pad,
  inout  wire xIn3_pad,
  inout  wire yOut1_pad,
  inout  wire yOut2_pad,
  inout  wire zInOut1_pad,
);

wire rst;
wire clk;
wire xIn1_core;
wire xIn2_core;
wire xIn3_core;
wire yOut1_core;
wire yOut2_core;
wire zInOut1_coreIn;
wire zInOut1_coreOut;
wire zInOut1_coreEn;

// Inputs assignment to IO cells
  sg13g2_IOPadIn sg13g2_IOPadIn_clk (
    .p2c (clk), 
    .pad ({clk_pad}) 
  );
  sg13g2_IOPadIn sg13g2_IOPadIn_rst (
    .p2c (rst), 
    .pad ({rst_pad}) 
  );
  sg13g2_IOPadIn sg13g2_IOPadIn_x1 (
    .p2c (xIn1_core), 
    .pad ({xIn1_pad}) 
  );
  sg13g2_IOPadIn sg13g2_IOPadIn_x2 (
    .p2c (xIn2_core), 
    .pad ({xIn2_pad}) 
  );
  sg13g2_IOPadIn sg13g2_IOPadIn_x3 (
    .p2c (xIn3_core), 
    .pad ({xIn3_pad}) 
  );


// Outputs assignment to IO cells
  sg13g2_IOPadOut4mA sg13g2_IOPadOut4mA_y1 (
    .c2p (yOut1_core), 
    .pad ({yOut1_pad}) 
  );
  sg13g2_IOPadOut4mA sg13g2_IOPadOut4mA_y2 (
    .c2p (yOut2_core), 
    .pad ({yOut2_pad}) 
  );


  sg13g2_IOPadInOut4mA sg13g2_IOPadInOut4mA_1 (
    .c2p    (zInOut1_coreIn   ), //i
    .c2p_en (zInOut1_coreEn   ), //i
    .p2c    (zInOut1_coreOut  ), //o
    .pad    ({zInOut1_pad}    ) 
  );

  // power IO pins assignments (only instantiation)
  sg13g2_IOPadIOVdd sg13g2_IOPadIOVdd_1 (
  );
  sg13g2_IOPadIOVss sg13g2_IOPadIOVss_1 (
  );

  sg13g2_IOPadVdd sg13g2_IOPadVdd_1 (
  );
  sg13g2_IOPadVdd sg13g2_IOPadVdd_2 (
  );

wire y1_t;
wire y2_t;

wire x1_t;
wire x2_t;
wire x3_t;
wire  tmp;
assign yOut1_core = y1_t;
assign yOut2_core = y2_t;
assign zInOut1_coreEn = 1'b1;
assign zInOut1_coreOut = y1_t ^ y2_t;
//assign zInOut1_coreIn = y1_t | y2_t;
assign tmp = zInOut1_coreEn ? zInOut1_coreIn : 1'b0; 

reg q;

assign    y1_t = x1_t & x2_t;
assign    y2_t = q | xIn3_core;
assign    x1_t = xIn1_core & xIn2_core;
assign    x2_t = xIn2_core;
assign    x3_t = xIn3_core;

always@(posedge clk) begin
  if (rst == 1'b1)
      q <= 1'b0;
  else
      q <= xIn1_core;
end



endmodule 

