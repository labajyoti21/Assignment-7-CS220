module datapath (out, opcode, functioncode);

input [5:0] opcode, functioncode;
output reg[4:0] out;


always@* begin
//Since we have 25 operations, we are using 5 bit value to tell the cpu , which submodules to be used for further processing. 
//For this, we are assigning a unique value to each type of operations.
case (opcode)

6'b000000: begin
    case (functioncode)
    32: out = 5'b00000;  //add
    33: out = 5'b00001;  //addu
    34: out = 5'b00010; //sub
    35: out = 5'b00011; //subu
    36: out = 5'b00100; //and
    37: out = 5'b00101; //or
    0: out = 5'b00110; //sll
    2: out = 5'b00111; //srl
    42:out = 5'b01000; //slt
    8: out = 5'b01001; //jr

    endcase
end

6'b000010: out=5'b01010; //j (jump)
6'b000011: out=5'b01011; //jal
6'b001000: out=5'b01100; //addi
6'b001001: out=5'b01101; //addiu
6'b001100: out=5'b01110; //ori                
6'b001101: out=5'b01111; //andi   
6'b100011: out=5'b10000; //lw
6'b101011: out=5'b10001; //sw
6'b000100: out=5'b10010; //beq
6'b000101: out=5'b10011; //bne
6'b001010: out=5'b10100; //slti
6'b011111: out=5'b10101; //bgt
6'b100000: out=5'b10110; //bgte
6'b100001: out=5'b10111; //ble
6'b100010: out=5'b11000; //bleq
endcase
end
    
endmodule 