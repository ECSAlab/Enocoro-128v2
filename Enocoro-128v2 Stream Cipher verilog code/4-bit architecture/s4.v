module s4(
input [3:0] s_in,
output [3:0] s_out
);

wire A;
wire B;
wire C;
wire D;

assign A = s_in[3];
assign B = s_in[2];
assign C = s_in[1];
assign D = s_in[0];


assign s_out[3] = (~B&&C) || (B&&(~C)&&D) || (A&&(~B)&&(~D)) || (A&&C&&D);
assign s_out[2] = (B&&(~D)) || (A&&(~D)) || ((~A)&&B&&(~C)) || (A&&(~B)&&C);
assign s_out[1] = ((~A)&&D) || (C&&D) || (B&&C);
assign s_out[0] = ((~A)&&(~D)) || (~A&&(~B)&&(~C)) || (~B&&(~C)&&(~D)) || (A&&C&&D);

endmodule