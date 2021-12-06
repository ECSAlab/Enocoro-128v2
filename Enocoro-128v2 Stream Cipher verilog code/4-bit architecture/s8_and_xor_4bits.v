module s8_and_xor_4bits(
input clk,
input reset_n,
input [3:0] to_s8,
input mc_a,
input mc_b,
input [3:0] to_xor,
output [3:0] xor_out
);


wire [3:0] s8_out;

s8_4bits s8_box(
.clk(clk),
.reset_n(reset_n),
.s_in(to_s8),
.mc_a(mc_a),
.mc_b(mc_b),
.s_out(s8_out)
);


reg [3:0] delay_to_xor_1;
reg [3:0] delay_to_xor_2;


always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		delay_to_xor_1  <= 0;
        delay_to_xor_2  <= 0;
	end else begin
		delay_to_xor_1  <= to_xor;
        delay_to_xor_2  <= delay_to_xor_1;
end
end

assign xor_out = s8_out ^ delay_to_xor_2;

endmodule