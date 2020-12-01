`timescale 1ns / 1ps

module testBench();

  reg signed [8:0]x [7 :0];
  reg signed [17:0]y [7 :0];
  reg signed [17:0] y0;
  reg signed [17:0] y1;
  reg signed [17:0] y2;
  reg signed [17:0] y3;
  reg signed [17:0] y4;
  reg signed [17:0] y5;
  reg signed [17:0] y6;
  reg signed [17:0] y7;

  fastDCT8 dct(.x(x), .y(y));

  assign y0 = y[0];
  assign y1 = y[1];
  assign y2 = y[2];
  assign y3 = y[3];
  assign y4 = y[4];
  assign y5 = y[5];
  assign y6 = y[6];
  assign y7 = y[7];

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
