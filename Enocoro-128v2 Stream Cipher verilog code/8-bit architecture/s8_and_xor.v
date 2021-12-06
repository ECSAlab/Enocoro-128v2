module s8_and_xor(
input [7:0] to_s8,
input [7:0] to_xor,
output [7:0] xor_out
);


wire [7:0] s8_out;


s8 s8_box(
.s_in(to_s8),
.s_out(s8_out)
);


assign xor_out = s8_out ^ to_xor;



endmodule
