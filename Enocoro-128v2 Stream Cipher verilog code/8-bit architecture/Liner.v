module Liner(
input [7:0] data_in,
input clk,
input reset_n,
input mux_control,
output [7:0] data_out
);


reg [7:0] delay_left_1;
reg [7:0] delay_left_2;
reg [7:0] delay_mult;
wire [7:0] mult_out;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		delay_left_1  <= 0;
        delay_left_2  <= 0;
        delay_mult <= 0;
	end else begin
		delay_left_1  <= data_in;
        delay_left_2  <= delay_left_1;
        delay_mult <= mult_out;

end
end



mult_by_0x02 mult(
.d_in(data_in),
.d_out(mult_out)
);

//muxes 

wire [7:0] mux1 = (mux_control) ? delay_left_2 : delay_left_1;
wire [7:0] mux2 = (mux_control) ?  delay_mult: data_in;


assign data_out = mux1 ^ mux2;


endmodule
