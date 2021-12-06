module s8_4bits(
input clk,
input reset_n,
input [3:0] s_in,
input mc_a,
input mc_b,
output [3:0] s_out
);


wire [3:0] s4_1_out;

s4 s4_1(
.s_in(s_in),
.s_out(s4_1_out)
);


wire [3:0] e_1_out;


mult_by_e e_H(
.d_in(s4_1_out),
.d_out(e_1_out)
);

reg [3:0] reg_e1, reg_e2, reg_s4;


always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		reg_e1 <= 0;
		reg_e2 <= 0;
		reg_s4 <= 0;
	end else begin
		reg_e1 <= e_1_out;
        reg_e2 <= reg_e1;
        reg_s4 <= s4_1_out;
end
end


wire [3:0] mux_a = (mc_a) ?  reg_e2: e_1_out;



wire [3:0] Xor_1;
wire [3:0] mux_coef = (mc_a) ?  4'ha: 4'h5;

assign Xor_1 = mux_a ^ reg_s4;


wire [3:0] Xor_2;

assign Xor_2 = Xor_1 ^ mux_coef;

wire [3:0] s4_out2;

s4 s4_2(
.s_in(Xor_2),
.s_out(s4_out2)
);


reg [2:0] reg_3bits;
reg reg_1bit_1, reg_1bit_2;


always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		reg_3bits <= 0;
		reg_1bit_1 <= 0;
		reg_1bit_2 <= 0;
	end else begin
		reg_3bits <= s4_out2[2:0];
        reg_1bit_1 <= s4_out2[3];
        reg_1bit_2 <= reg_1bit_1;
end
end


assign s_out[3:1] = reg_3bits;
assign s_out[0] = (mc_b) ? reg_1bit_2 : s4_out2[3];

endmodule