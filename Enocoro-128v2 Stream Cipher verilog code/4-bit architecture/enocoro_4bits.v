module enocoro_4bits(
	input clk,
	input reset_n,
	input [3:0] Data_in,
	output [3:0] Data_out,
	output valid
);

`define ib48 4'h6
`define ib49 4'h6
`define ib50 4'he
`define ib51 4'h9
`define ib52 4'h4
`define ib53 4'hb
`define ib54 4'hd
`define ib55 4'h4
`define ib56 4'he
`define ib57 4'hf
`define ib58 4'h8
`define ib59 4'ha
`define ib60 4'h2
`define ib61 4'hc
`define ib62 4'h3
`define ib63 4'hb

`define ia0_H 4'h8
`define ia0_L 4'h8
`define ia1_H 4'h4
`define ia1_L 4'hc

`define ictr_H 4'h0
`define ictr_L 4'h1


reg [9:0] init_counter;
reg [3:0] main_counter;

//reg init_completed;
reg data_received; 

always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		init_counter <= 0;
//		init_completed <= 0;
		data_received <= 0;
	end else begin
		if(init_counter < 910) begin
		   if(init_counter > 46) begin
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
            if(main_counter < 8) begin
			main_counter <= main_counter + 1;
            end else begin
            main_counter <= 0;
        end 
        end   
end
end


//assign valid= ((init_completed)&((main_counter > 3)))? 1'b1:1'b0;
//assign valid= (main_counter <2)? 1'b1:1'b0;
//assign valid= ((init_counter ==502)&((main_counter ==0)))? 1'b1:1'b0;

assign valid= ((init_counter ==910)&((main_counter ==1)||(main_counter ==2)))? 1'b1:1'b0;


wire [3:0] xor_out1;
wire [3:0] xor_out2;

reg [255:0] shift_b;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		shift_b[255:252] <= `ib48;
		shift_b[251:248] <= `ib49;	
		shift_b[247:244] <= `ib50;
		shift_b[243:240] <= `ib51;		
		shift_b[239:236] <= `ib52;
		shift_b[235:232] <= `ib53;		
		shift_b[231:228] <= `ib54;
		shift_b[227:224] <= `ib55;		
		shift_b[223:220] <= `ib56;
		shift_b[219:216] <= `ib57;		
		shift_b[215:212] <= `ib58;
		shift_b[211:208] <= `ib59;		
		shift_b[207:204] <= `ib60;
		shift_b[203:200] <= `ib61;		
		shift_b[199:196] <= `ib62;
		shift_b[195:192] <= `ib63;		
		shift_b[191:0] <= 0;
	end else begin
	   if(!data_received) begin	
		  shift_b <= {Data_in, shift_b[255:4]};
	   end else begin
		  shift_b <= {shift_b[199:0], shift_b[255:200]};
		  case (main_counter) 
          0 : shift_b[59:56]   <= xor_out2; 
          1 : shift_b[119:116] <= xor_out2;
          2 : shift_b[107:104] <= xor_out1; 
          3 : shift_b[167:164] <= xor_out1;
          
          5 : shift_b[203:200] <= xor_out1;
          6 : shift_b[7:4]     <= xor_out1; 
          7 : shift_b[171:168] <= xor_out1;
          8 : shift_b[231:228] <= xor_out1; 
          endcase
end
end
end




//ctr
reg [3:0] ctr_H;
reg [3:0] ctr_L;

wire [3:0] ctr_mux1;
wire [3:0] ctr_mux2;

//reg [3:0] m_reg;
wire [3:0] ctr_mult;

always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		ctr_H <= `ictr_H;
		ctr_L <= `ictr_L;
//		m_reg <= 0;		
	end else begin
	    ctr_L <= ctr_H;
        ctr_H <= ctr_mux2;
        
//        m_reg <= ctr_mult;		

end
end

wire mux_c_c = (main_counter == 2) ?  1'b1: 1'b0;
//mult_by_0x02 mult_ctr(
//.d_in(ctr),
//.d_out(ctr_mult)
//);

mult_by_0x02_4bits mult(
.clk(clk),
.reset_n(reset_n),
.d_in(ctr_L),
.mux_c(mux_c_c),
.d_out(ctr_mult)
);


assign ctr_mux1 = ((main_counter ==1)||(main_counter ==2)) ?  ctr_mult : ctr_L;

assign ctr_mux2 = (init_counter == 910) ?  4'h00: ctr_mux1;


reg [3:0] rega_1;
reg [3:0] rega_2;
reg [3:0] rega_3;
reg [3:0] rega_4;

wire [3:0] Liner_out;


//reg [7:0] regL_1;
//reg [7:0] regL_2;

//muxes

wire [3:0] row_mux_21 = 
(main_counter == 0) ? shift_b[235:232] :
(main_counter == 1) ? shift_b[39:36]   :
(main_counter == 2) ? shift_b[51:48]   :
(main_counter == 3) ? shift_b[111:108] :

(main_counter == 4) ? shift_b[111:108] :   //irrelevant

(main_counter == 5) ? shift_b[147:144] :
(main_counter == 6) ? shift_b[207:204] :
(main_counter == 7) ? shift_b[155:152] : shift_b[215:212];


reg [3:0] Liner_out_reg;

always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		Liner_out_reg <= 0;
//		m_reg <= 0;		
	end else begin
	    Liner_out_reg <= Liner_out;        
//        m_reg <= ctr_mult;		

end
end




wire [3:0] row_mux_22 = (main_counter>4) ?  Liner_out_reg: rega_4;

////a0, a1
wire [3:0] s8_xor_out;


wire mc_a =
(main_counter == 0) ? 1'b1 :
(main_counter == 1) ? 1'b0 :
(main_counter == 2) ? 1'b1 :
(main_counter == 3) ? 1'b0 :
(main_counter == 4) ? 1'b1 :
(main_counter == 5) ? 1'b0 :
(main_counter == 6) ? 1'b0 :
(main_counter == 7) ? 1'b1 : 1'b0;



wire mc_b =
(main_counter == 0) ? 1'b0 :
(main_counter == 1) ? 1'b1 :
(main_counter == 2) ? 1'b0 :
(main_counter == 3) ? 1'b1 :
(main_counter == 4) ? 1'b0 :
(main_counter == 5) ? 1'b1 :
(main_counter == 6) ? 1'b0 :
(main_counter == 7) ? 1'b0 : 1'b1;



s8_and_xor_4bits s8_xor(
.clk(clk),
.reset_n(reset_n),
.to_s8(row_mux_21),
.mc_a(mc_a),
.mc_b(mc_b),
.to_xor(row_mux_22),
.xor_out(s8_xor_out)
);

wire mux_liner = (main_counter < 6) ?  1'b0: 1'b1;

Liner_4bits Liner_additions(
.clk(clk),
.reset_n(reset_n),
.data_in(s8_xor_out),
.mux_control(mux_liner),
.data_out(Liner_out)
);


//always@(posedge clk or negedge reset_n) begin
//	if(~reset_n) begin
//		regL_1 <= 0;
//		regL_2 <= 0;
//	end else begin
//		regL_1 <= Liner_out;
//        regL_2 <= regL_1;  
//end
//end



/////a main



//wire [7:0] ctr_mux_a = (main_counter<1) ?  rega_1: s8_xor_out;

wire [3:0] new_a  = (init_counter > 49) ?  s8_xor_out: rega_2;

//always@(posedge clk or negedge reset_n) begin
always@(posedge clk) begin
	if(init_counter == 47) begin
		rega_1 <= `ia1_H;
		rega_2 <= `ia1_L;	
		rega_3 <= `ia0_H;
        rega_4 <= `ia0_L;    			
	end else begin
		rega_4 <= rega_3;
        rega_3 <= new_a;
		rega_2 <= rega_1;
//        rega_1 <= 0;        
end
end

///XOR
wire [3:0] xor1 = 
(main_counter == 0) ? shift_b[3:0]   :
(main_counter == 1) ? shift_b[63:60] :
(main_counter == 2) ? row_mux_21     :
(main_counter == 3) ? row_mux_21     :

(main_counter == 4) ? row_mux_21     :  //irrelevant

(main_counter == 5) ? row_mux_21     :
(main_counter == 6) ? row_mux_21     :
(main_counter == 7) ? shift_b[115:112] : shift_b[175:172];

wire [3:0] xor2 = 
(main_counter == 0) ? rega_4        :
(main_counter == 1) ? rega_4        :
(main_counter == 2) ? shift_b[243:240] :
(main_counter == 3) ? shift_b[47:44] :

(main_counter == 4) ? shift_b[47:44] :   //irrelevant

(main_counter == 5) ? shift_b[51:48] :
(main_counter == 6) ? shift_b[111:108] :
(main_counter == 7) ? shift_b[83:80] : shift_b[143:140];


assign xor_out1 = xor1 ^ xor2;

assign xor_out2 = xor_out1 ^ ctr_L;

//output
assign Data_out= rega_3;

endmodule