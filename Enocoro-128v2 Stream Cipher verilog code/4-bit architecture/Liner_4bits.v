module Liner_4bits(
input clk,
input reset_n,
input [3:0] data_in,
input mux_control,
output [3:0] data_out
);


reg [3:0] delay_1;
reg [3:0] delay_2;
reg [3:0] delay_3;
reg [3:0] delay_4;
reg [3:0] delay_mult;

wire [3:0] mult_out;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		delay_1  <= 0;
        delay_2  <= 0;
        delay_3  <= 0;
        delay_4  <= 0;
        delay_mult <= 0;
	end else begin
		delay_1  <= data_in;
        delay_2  <= delay_1;
        delay_3  <= delay_2;
        delay_4  <= delay_3;
        delay_mult <= mult_out;
end
end

mult_by_0x02_4bits mult_4bits(
.clk(clk),
.reset_n(reset_n),
.d_in(data_in),
.mux_c(mux_control),
.d_out(mult_out)
);

//muxes 

wire [3:0] mux1 = (mux_control) ?  delay_4: delay_2;
wire [3:0] mux2 = (mux_control) ?  delay_mult: data_in;


assign data_out = mux1 ^ mux2;


endmodule