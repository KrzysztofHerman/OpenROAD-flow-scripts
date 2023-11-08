module counter
(
  input  wire clk,
  input  wire rst,
  output wire [3:0] cnt
);

reg [3:0] counter;

assign cnt = counter;

always@(posedge clk) begin

  if(rst == 1)
    cnt <= 0;
  else
    cnt <= cnt + 1;
end

endmodule 

