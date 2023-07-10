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
module memo2(dataout, Writeen, addressa, addressb, mode, Datain, reset);

input [31:0] Datain;
input [8:0]addressa,addressb;
input Writeen, reset, mode;
output reg [31:0] dataout;
reg [31:0] RF [511:0]; 

always@(addressa or addressb or reset)
begin
if(reset) begin 
RF[9'b000000000]<=45;
RF[9'b000000001]<=62;
RF[9'b000000010]<=6;
RF[9'b000000011]<=20;
RF[9'b000000100]<=4;
RF[9'b000000101]<=7;
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
$display("reg0 %d reg1 %d reg2 %d reg3 %d reg4 %d", RF[0], RF[1], RF[2], RF[3], RF[4]);
// The display above shows the value stored in the data registers.
// At the last, sorted numbers are displayed in the console is ISim simulator.
end 
endmodule 