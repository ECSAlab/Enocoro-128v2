module mult_by_0x02_4bits(
input clk,
input reset_n,
input [3:0] d_in,
input mux_c,
output [3:0] d_out
);


reg [2:0] reg_3bits;
reg reg_1bit_1, reg_1bit_2;


always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		reg_3bits <= 0;
		reg_1bit_1 <= 0;
		reg_1bit_2 <= 0;
	end else begin
		reg_3bits <= d_in[2:0];
        reg_1bit_1 <= d_in[3];
        reg_1bit_2 <= reg_1bit_1;
end
end

wire xor_3 = d_in[3] ^ reg_3bits[2];
wire xor_2 = d_in[3] ^ reg_3bits[1];
wire xor_0 = reg_1bit_1 ^ reg_1bit_2;

assign d_out[3] = (mux_c) ?  reg_3bits[2]: xor_3;
assign d_out[2] = (mux_c) ?  reg_3bits[1]: xor_2 ;
assign d_out[1] = reg_3bits[0];
assign d_out[0] = (mux_c) ?  xor_0: d_in[3];

endmodule