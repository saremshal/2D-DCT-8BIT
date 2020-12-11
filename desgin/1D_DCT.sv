module fastDCT8
#( parameter
    N = 8
)
(
  input signed [N:0]   x [7 :0], //QN.0
  output wire  [N+9:0] y [7 :0]   //Q(N+9).0
);

  reg signed [N+1:0]a [3:0];
  reg signed [N+1:0]b [3:0];
  reg signed [N+6:0]t18 [3:0];
  reg signed [N+7:0]t50 [3:0];
  reg signed [N+8:0]t75 [3:0];
  reg signed [N+8:0]t89 [3:0];
  reg signed [N+9:0]DCT4_OUTPUT [3:0];

  assign a[0] = $signed(x[0]) + $signed(x[7]);
  assign a[1] = $signed(x[1]) + $signed(x[6]);
  assign a[2] = $signed(x[2]) + $signed(x[5]);
  assign a[3] = $signed(x[3]) + $signed(x[4]);

  assign b[0] = $signed(x[0]) - $signed(x[7]);
  assign b[1] = $signed(x[1]) - $signed(x[6]);
  assign b[2] = $signed(x[2]) - $signed(x[5]);
  assign b[3] = $signed(x[3]) - $signed(x[4]);

  assign t18[0] = (($signed(b[0]) << 3) + $signed(b[0])) << 1;
  assign t50[0] = (($signed(b[0]) << 4) + ($signed(t18[0]) >>> 1)) << 1;
  assign t75[0] = $signed(t50[0]) + ($signed(t50[0]) >>> 1);
  assign t89[0] = (($signed(b[0]) << 6) + ($signed(t50[0]) >>> 1));

  assign t18[1] = (($signed(b[1]) << 3) + $signed(b[1])) << 1;
  assign t50[1] = (($signed(b[1]) << 4) + ($signed(t18[1]) >>> 1)) << 1;
  assign t75[1] = $signed(t50[1]) + ($signed(t50[1]) >>> 1);
  assign t89[1] = (($signed(b[1]) << 6) + ($signed(t50[1]) >>> 1));

  assign t18[2] = (($signed(b[2]) << 3) + $signed(b[2])) << 1;
  assign t50[2] = (($signed(b[2]) << 4) + ($signed(t18[2]) >>> 1)) << 1;
  assign t75[2] = $signed(t50[2]) + ($signed(t50[2]) >>> 1);
  assign t89[2] = (($signed(b[2]) << 6) + ($signed(t50[2]) >>> 1));

  assign t18[3] = (($signed(b[3]) << 3) + $signed(b[3])) << 1;
  assign t50[3] = (($signed(b[3]) << 4) + ($signed(t18[3]) >>> 1)) << 1;
  assign t75[3] = $signed(t50[3]) + ($signed(t50[3]) >>> 1);
  assign t89[3] = (($signed(b[3]) << 6) + ($signed(t50[3]) >>> 1));

  fastDCT4 #(.N(N+1)) dct(.x(a), .y(DCT4_OUTPUT));

  assign y[1] = ($signed(t89[0]) + $signed(t75[1]) + $signed(t50[2]) + $signed(t18[3]));
  assign y[3] = ($signed(t75[0]) - $signed(t18[1]) - $signed(t89[2]) - $signed(t50[3]));
  assign y[5] = ($signed(t50[0]) - $signed(t89[1]) + $signed(t18[2]) + $signed(t75[3]));
  assign y[7] = ($signed(t18[0]) - $signed(t50[1]) + $signed(t75[2]) - $signed(t89[3]));

  assign y[0] = $signed(DCT4_OUTPUT[0]);
  assign y[2] = $signed(DCT4_OUTPUT[1]);
  assign y[4] = $signed(DCT4_OUTPUT[2]);
  assign y[6] = $signed(DCT4_OUTPUT[3]);

endmodule

module fastDCT4
#( parameter
    N = 8
)
(
  input signed [N:0]   x [3 :0],
  output wire  [N+8:0] y [3 :0]
);

  reg signed [N+1:0]a [1:0];
  reg signed [N+1:0]b [1:0];

  reg signed [N+8:0]t36 [1:0];
  reg signed [N+7:0]t83 [1:0];

  assign a[0] = $signed(x[0]) + $signed(x[3]);
  assign a[1] = $signed(x[1]) + $signed(x[2]);

  assign b[0] = $signed(x[0]) - $signed(x[3]);
  assign b[1] = $signed(x[1]) - $signed(x[2]);

  assign t36[0] = ((($signed(b[0]) << 3) + $signed(b[0])) << 1) << 1;
  assign t83[0] = ((($signed(b[0]) << 3) + $signed(b[0])) << 1) + $signed(b[0]) + ($signed(b[0]) << 6);

  assign t36[1] = ((($signed(b[1]) << 3) + $signed(b[1])) << 1) << 1;
  assign t83[1] = ((($signed(b[1]) << 3) + $signed(b[1])) << 1) + $signed(b[1]) + ($signed(b[1]) << 6);

  assign y[0] = ($signed(a[0])   + $signed(a[1])) << 6;
  assign y[1] =  $signed(t83[0]) + $signed(t36[1]);
  assign y[2] = ($signed(a[0])   - $signed(a[1])) << 6;
  assign y[3] =  $signed(t36[0]) - $signed(t83[1]);

endmodule
