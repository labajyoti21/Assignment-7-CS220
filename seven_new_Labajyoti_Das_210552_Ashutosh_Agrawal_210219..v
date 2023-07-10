module cpu(reset, clk, pci, outp, pc, instruct, togo);
//These ports other than cllk, reset, pci are to monitoe the various parts during simulation
input reset, clk;
input [8:0] pci;
output reg[31:0]outp;
output reg [8:0] pc;
wire[31:0] dataout, dataout2, outt, pco, raw, oute;
reg writeen, mode;
reg [8:0] addressa, addressa2, addressb2, addressb;
reg [31:0] datain;
reg [5:0] opcode, functioncode;
output reg [4:0] instruct;
wire [4:0] instwir;
output reg [4:0] togo;
reg [31:0] regis[31:0];
// memo is the instruction memory, memo2 is the data memory
memo m1(dataout, 1'b0, {9{1'b0}}, addressb, 1'b1, {32{1'b0}}, reset);
memo2 data(dataout2, writeen, addressa2, addressb2, mode, datain, reset);
datapath dat(instwir, dataout[31:26], dataout[5:0]);
alu oper(regis[dataout[25:21]], regis[dataout[20:16]], regis[dataout[15:11]], instruct, {23'b0, pc}, {16'b0000000000000000, dataout[15:0]}, {6'b000000, dataout[25:0]}, outt, pco, regis[31], raw);
assign oute = outt;
always@(posedge clk) begin 
	if (reset == 0) begin
	outp = regis[8];
		 addressb = pc;
		 pc = pc + 1;
	end
	else begin
	regis[0] = {32{1'b0}};
	pc = pci;
	end
end
always@(negedge clk) begin
togo = dataout[25:21];
instruct = instwir;
#20
case (instruct)
5'b01001: begin //jr
pc=pco;
end
5'b01010: pc = dataout[8:0];//j
5'b01011: begin 
    pc = pco;
    regis[31] = raw;
end
5'b10010: pc = pco;
5'b10011: pc = pco;
5'b10101: pc = pco;
5'b10110: pc = pco;
5'b10111: pc = pco;
5'b11000: pc = pco;
5'b10000: begin //lw
writeen = 1'b0;
    mode = 1'b1;
    datain = {32{1'b0}};
    addressb2 = regis[dataout[20:16]][8:0];
	 #10
	 regis[togo] = dataout2[31:0];
	 
end
5'b10001: begin //sw
    writeen = 1'b1;
    mode = 1'b0;
    datain = regis[dataout[25:21]];
	 addressb2 = addressb2 + 1;
    addressa2 = regis[dataout[20:16]][8:0];
	 #5
	 addressb2 = addressb2 + 1;
	 
end
default: begin
#10
//We have fetched the instruction from the memory  and depending on the datapath defined previously,
// we are storing the output.
case (instruct)
5'b00000: regis[dataout[25:21]] = outt;  //add
5'b00001:regis[dataout[25:21]] = outt;  //addu
5'b00010: regis[dataout[25:21]] = outt; //sub
5'b00011: regis[dataout[25:21]] = outt; //subu
5'b00100: regis[dataout[25:21]] = outt; //and
5'b00101: regis[dataout[25:21]] = outt; //or
5'b00110: regis[dataout[25:21]] = outt; //sll
5'b00111: regis[dataout[25:21]] = outt; //srl
5'b01000: regis[dataout[25:21]] = outt; //slt
5'b01100: regis[dataout[25:21]] = outt; //addi
5'b01101: regis[dataout[25:21]] = outt; //addiu
5'b01110: regis[dataout[25:21]] = outt; //ori
5'b01111: regis[dataout[25:21]] = outt; //andi

5'b10100: regis[dataout[25:21]] = outt; //slti

endcase 
 end
endcase
end
endmodule 