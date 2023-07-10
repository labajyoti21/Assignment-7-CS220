`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:30 02/12/2023 
// Design Name: 
// Module Name:    memo2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module memo(dataout, Writeen, addressa, addressb, mode, Datain, reset);

input [31:0] Datain;
input [8:0]addressa,addressb;
input Writeen, reset, mode;
output reg [31:0] dataout;
reg [31:0] RF [511:0]; 

always@(addressa or addressb or reset)
begin
if(reset) begin 
RF[9'b000000001]<=32'b000000_00000_00000_00000_00000_1000000; //add $zero $zero $zero
RF[9'b000000010]<=32'b001000_00101_00000_0000000000000110; //add $a1 $zero 6 *this is the number of numbers to be sorted
RF[9'b000000011]<=32'b001000_11001_00000_0000000000000000;//addi $25 $zero 0 *address the numbers in data memory
RF[9'b000000100]<=32'b001000_01000_00000_0000000000000000;  // addi $t0, $zero, 0
RF[9'b000000101]<=32'b001000_10111_00000_0000000000000001; // addi $s7, $zero, 1
RF[9'b000000110]<=32'b000000_00101_00101_10111_00000_100010; //sub $a1, $a1, $s7
//loop1
RF[9'b000000111]<=32'b000100_01000_00101_0000000000011011; // beq $t0, $a1, exit1 
RF[9'b000001000]<=32'b001000_01001_00000_0000000000000000; // addi $t1, $zero, 0 
RF[9'b000001001]<=32'b000000_01010_00101_01000_00000_100010; // sub $t2, $a1, $t0
//loop2
RF[9'b000001010]<=32'b000100_01001_01010_0000000000011001; // beq $t1, $t2, exit2
RF[9'b000001011]<=32'b000000_10010_01001_00000_00000_100000; // add $s2, $t1, $zero
RF[9'b000001100]<=32'b000000_01011_11001_00000_00000_100000; // add $t3, $25, $zero
//loopforsp
RF[9'b000001101]<=32'b000100_10010_00000_0000000000010001; // beq $s2, $zero next1
RF[9'b000001110]<=32'b001000_01011_01011_0000000000000001; // addi $t3, $t3, 4 * here it will be 1
RF[9'b000001111]<=32'b000000_10010_10010_10111_00000_100010; // sub $s2, $s2, $s7
RF[9'b000010000]<=32'b000010_00000000000000000000001101; // j loopforsp
//next1
RF[9'b000010001]<=32'b001000_01100_01011_0000000000000001; // addi $t4, $t3, 4 * here it will be 1
RF[9'b000010010]<=32'b100011_10010_01011_0000000000000000; //lw $s2, 0($t3)
RF[9'b000010011]<=32'b100011_10011_01100_0000000000000000; // lw $s3, 0($t4)
RF[9'b000010100]<=32'b100001_10010_10011_0000000000010111; //ble $s2, $s3, increment
RF[9'b000010101]<=32'b101011_10011_01011_0000000000000000; // sw $s3, 0($t3)
RF[9'b000010110]<=32'b101011_10010_01100_0000000000000000; // sw $s2, 0($t4)
//increment
RF[9'b000010111]<=32'b001000_01001_01001_0000000000000001; // addi $t1, $t1, 1
RF[9'b000011000]<=32'b000010_00000000000000000000001010; // j loop2
//exit2
RF[9'b000011001]<=32'b001000_01000_01000_0000000000000001; // addi $t0, $t0, 1
RF[9'b000011010]<=32'b000010_00000000000000000000000111; // j loop1
RF[9'b000011011]<=32'b000000_00000000000000000000000000; // jr $ra *this noes not have any effect as our work is complete
end
else begin
    if (Writeen) begin
	 if(mode == 1) begin
	dataout= RF[addressb];
	end
	else begin 
        
        RF[addressa]<= Datain;
        if (addressa == addressb)
         dataout=Datain;
        else 
        dataout=RF[addressb];
        
    end
    end
    else begin 
       dataout= RF[addressb];

    end

end
end 
endmodule 