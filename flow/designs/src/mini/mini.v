module mini
(
  input  wire clk,
  input  wire reset,
  input  wire x1,
  input  wire x2,
  input  wire x3,
  output wire y1,
  output wire y2
);


reg y1_t;
reg y2_t;

reg x1_t;
reg x2_t;
reg x3_t;

assign y1 = y1_t;
assign y2 = y2_t;

always@(posedge clk) begin 
  if(reset ==1) begin 
    x1_t <= 0;
    x2_t <= 0;
    x3_t <= 0;
    y1_t <= 0;
    y2_t <= 0;
  end
  else begin

    y1_t <= x1_t & x2_t;
    y2_t <= x2_t | x3_t;
    x1_t <= x1;
    x2_t <= x2;

  end 

end 

endmodule 

