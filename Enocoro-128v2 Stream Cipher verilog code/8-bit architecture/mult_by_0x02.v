module mult_by_0x02(
input [7:0] d_in,
output [7:0] d_out
);

assign d_out[7] = d_in[6];
assign d_out[6] = d_in[5];
assign d_out[5] = d_in[4];
assign d_out[4] = d_in[3]^d_in[7];
assign d_out[3] = d_in[2]^d_in[7];
assign d_out[2] = d_in[1]^d_in[7];
assign d_out[1] = d_in[0];
assign d_out[0] = d_in[7];

endmodule
