module s8(
input [7:0] s_in,
output [7:0] s_out
);


wire [3:0] s4_H_out;
wire [3:0] s4_L_out;



s4 s4_H(
.s_in(s_in[7:4]),
.s_out(s4_H_out)
);

s4 s4_L(
.s_in(s_in[3:0]),
.s_out(s4_L_out)
);

wire [3:0] e_H_out;
wire [3:0] e_L_out;


mult_by_e e_H(
.d_in(s4_H_out),
.d_out(e_H_out)
);

mult_by_e e_L(
.d_in(s4_L_out),
.d_out(e_L_out)
);


wire [3:0] XorH_1;
wire [3:0] XorL_1;

assign XorH_1 = s4_H_out ^ e_L_out;
assign XorL_1 = s4_L_out ^ e_H_out;


wire [3:0] XorH_2;
wire [3:0] XorL_2;

assign XorH_2 = XorH_1 ^ 4'ha;
assign XorL_2 = XorL_1 ^ 4'h5;


wire [3:0] s4_H_out2;
wire [3:0] s4_L_out2;



s4 s4_H2(
.s_in(XorH_2),
.s_out(s4_H_out2)
);

s4 s4_L2(
.s_in(XorL_2),
.s_out(s4_L_out2)
);


assign s_out[7:1] = {s4_H_out2[2:0],s4_L_out2};
assign s_out[0] = s4_H_out2[3];


endmodule
