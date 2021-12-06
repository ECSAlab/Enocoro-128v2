module mult_by_e(
input [3:0] d_in,
output [3:0] d_out
);

assign d_out[3] = d_in[1];
assign d_out[2] = d_in[3]^d_in[0];
assign d_out[1] = d_in[3]^d_in[2];
assign d_out[0] = d_in[2];

endmodule