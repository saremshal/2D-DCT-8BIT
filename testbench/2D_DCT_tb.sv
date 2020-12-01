`timescale 1ns / 1ps

module TwoD_DCT_tb();

  reg signed [8:0]x [7 :0];
  reg signed [17:0]y [7 :0];

  fastDCT8 dct(.x(x), .y(y));

initial begin
  $dumpfile("dump.vcd");
  $dumpvars;

  x[0] = 53;
  x[1] = -33;
  x[2] = 20;
  x[3] = 22;
  x[4] = 56;
  x[5] = 100;
  x[6] = -107;
  x[7] = 85;
end

endmodule
