module enocoro(
	input clk,
	input reset_n,
	input [7:0] Data_in,
	output [7:0] Data_out,
	output valid
);

`define ib24 8'h66
`define ib25 8'he9
`define ib26 8'h4b
`define ib27 8'hd4
`define ib28 8'hef
`define ib29 8'h8a
`define ib30 8'h2c
`define ib31 8'h3b

`define ia0 8'h88
`define ia1 8'h4c

`define ictr 8'h01


reg [8:0] init_counter;
reg [2:0] main_counter;

//reg init_completed;
reg data_received; 

always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		init_counter <= 0;
//		init_completed <= 0;
		data_received <= 0;
	end else begin
		if(init_counter < 502) begin
		   if(init_counter > 22) begin
               data_received <= 1'b1;	
           end
           init_counter <= init_counter + 1;
		end	
        end     
end


always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		main_counter <= 0;
	end else begin
		if(data_received) begin
            if(main_counter < 4) begin
			main_counter <= main_counter + 1;
            end else begin
            main_counter <= 0;
        end 
        end   
end
end


//assign valid= ((init_completed)&((main_counter > 3)))? 1'b1:1'b0;
//assign valid= (main_counter <2)? 1'b1:1'b0;
assign valid= ((init_counter ==502)&((main_counter ==0)))? 1'b1:1'b0;

//assign valid= (main_counter ==0)? 1'b1:1'b0;


wire [7:0] xor_out1;
wire [7:0] xor_out2;

reg [255:0] shift_b;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		shift_b[255:248] <= `ib24;
		shift_b[247:240] <= `ib25;
		shift_b[239:232] <= `ib26;
		shift_b[231:224] <= `ib27;
		shift_b[223:216] <= `ib28;
		shift_b[215:208] <= `ib29;
		shift_b[207:200] <= `ib30;
		shift_b[199:192] <= `ib31;
		shift_b[191:0] <= 0;
	end else begin
	   if(!data_received) begin	
		  shift_b <= {Data_in, shift_b[255:8]};
	   end else begin
		  shift_b <= {shift_b[103:0], shift_b[255:104]};
		  case (main_counter) 
          0 : shift_b[159:152] <= xor_out2; 
          1 : shift_b[31:24]   <= xor_out1; 
          2 : shift_b[143:136] <= xor_out1; 
          3 : shift_b[223:216] <= xor_out1; 
//          4 : shift_b[231:224] <= xor_out1; 
          endcase 
	   end
end
end




//ctr
reg [7:0] ctr;
wire [7:0] ctr_mux1;
wire [7:0] ctr_mux2;


always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		ctr <= `ictr;
	end else begin
        ctr <= ctr_mux2;
end
end

wire [7:0] ctr_mult;

mult_by_0x02 mult_ctr(
.d_in(ctr),
.d_out(ctr_mult)
);

wire mux_ctr_1= (main_counter < 4) ?  1'b0: 1'b1;
//wire mux_ctr_2= (init_completed) ?  1'b1: 1'b0; 


assign ctr_mux1 = (mux_ctr_1) ?  ctr_mult: ctr;
assign ctr_mux2 = (init_counter == 502) ?  8'h00: ctr_mux1;


reg [7:0] rega_1;
reg [7:0] rega_2;
reg [7:0] rega_3;


reg [7:0] regL_1;
reg [7:0] regL_2;

//muxes

wire [7:0] row_mux_21 = (
 main_counter == 0) ? shift_b[239:232] :
(main_counter == 1) ? shift_b[95:88] :
(main_counter == 2) ? shift_b[247:240] :
(main_counter == 3) ? shift_b[71:64] : shift_b[119:112];

wire [7:0] row_mux_22 = (main_counter>2) ?  regL_2: rega_2;

////a0, a1
wire [7:0] s8_xor_out;

s8_and_xor s8_xor(
.to_s8(row_mux_21),
.to_xor(row_mux_22),
.xor_out(s8_xor_out)
);


wire [7:0] Liner_out;
wire mux_liner= (main_counter < 2) ?  1'b0: 1'b1;

Liner Liner_additions(
.data_in(s8_xor_out),
.clk(clk),
.reset_n(reset_n),
.mux_control(mux_liner),
.data_out(Liner_out)
);



always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		regL_1 <= 0;
		regL_2 <= 0;
	end else begin
		regL_1 <= Liner_out;
        regL_2 <= regL_1;  
end
end



/////a main



//wire [7:0] ctr_mux_a = (main_counter<1) ?  rega_1: s8_xor_out;


//always@(posedge clk or negedge reset_n) begin
always@(posedge clk) begin
	if(init_counter == 23) begin
		rega_1 <= `ia1;
		rega_2 <= `ia0;		
	end else begin
		rega_1 <= s8_xor_out;
        rega_2 <= rega_1;
end
end

///XOR
//reg [7:0] reg_xor;

wire [7:0] xor1 = (
 main_counter == 0) ? shift_b[7:0] :
(main_counter == 1) ? shift_b[135:128] : row_mux_21 ;

wire [7:0] xor2 = (
 main_counter == 0) ? rega_2 :
(main_counter == 1) ? shift_b[103:96] :
(main_counter == 2) ? shift_b[183:176] : shift_b[231:224] ;


assign xor_out1 = xor1 ^ xor2;

assign xor_out2 = xor_out1 ^ ctr;

//always@(posedge clk or negedge reset_n) begin
//	if(~reset_n) begin
//		reg_xor <= 0;		
//	end else begin
//		reg_xor <= xor_out1;     
//end
//end

//output
assign Data_out= rega_1;

endmodule