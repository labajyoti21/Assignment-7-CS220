module alu(r1, r2, r3, instruction, pci,imm, off, out, pco, rai ,ra);

input [31:0] r1, r2, r3, off, pci, rai, imm;
input [4:0] instruction;
output reg[31:0] pco, ra;
output [31:0] out;
wire [31:0] conn[24:0];
wire [31:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w12,w13,w14,w15,w20 ,pcjr,pcbne,pcbeq;
wire [31:0] rajal, pcbgt, pcbgte, pcj, pcble, pcbleq, pcjal;
assign out = conn[instruction];

always @(instruction) begin // this assigns pc and rs when the instruction needs them to change

    case(instruction)
    5'b01001: begin 
        pco = pcjr;
        ra = rai;
    end
    5'b01010: begin 
        pco = pcj;
        ra = rai;
        end
    5'b01011: begin 
        pco = pcjal;
        ra = rajal;
    end
    5'b10010: begin 
        pco = pcbeq;
        ra = rai;
    end
    5'b10011: begin 
         pco = pcbne;
        ra = rai;
    end
    5'b10101: begin 
        pco = pcbgt;
        ra = rai;
    end
    5'b10110: begin 
        pco = pcbgte;
        ra = rai;
    end
    5'b10111: begin 
        pco = pcble;
        ra = rai;
    end
    5'b11000:   begin 
        pco = pcbleq;
        ra = rai;
    end
    default: begin
       pco = pci;
       ra = rai;
    end
    endcase
end
// We are calling all the submodules below and storing the output from each modules in a wire of 32bit where needed
// Depending on the datapath, we will send the intended output to the cpu 
add A0(r2,r3,conn[0]);
addu A1(r2,r3,conn[1]);
sub A2(r2,r3,conn[2]);
subu A3(r2,r3,conn[3]);
And A4 (r2,r3,conn[4]);
Or A5(r2,r3,conn[5]);
sll A6(r2,imm,conn[6]);
srl A7(r2,imm,conn[7]);
slt A8(r2,r3,conn[8]);
jr A9(rai,pcjr);
j A10(off,pcj);
jal A11(r1,pci,pcjal,rajal);
addi A12(r2,imm,conn[12]);
addiu A13(r2,imm,conn[13]);
ori A14(r2,imm,conn[14]);
andi A15(r2,imm,conn[15]);
beq A18(r1,r2,imm,pci,pcbeq);
bne A19(r1,r2,imm,pci,pcbne);
slti A20(r2,imm,conn[20]);
bgt A21(r1,r2,imm,pci,pcbgt);
bgte A22(r1,r2,imm,pci,pcbgte);
ble A23(r1,r2,imm,pci,pcble);
bleq A24(r1,r2,imm,pci,pcbleq);

endmodule

