`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:21:52 04/05/2023 
// Design Name: 
// Module Name:    test 
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
module test;
reg [8:0] pci;
reg clk, reset;
wire [31:0]outp;
wire [8:0] pc;
wire [4:0] instruct, togo;
cpu c1(reset, clk, pci, outp, pc, instruct, togo);
initial begin
clk <=0;
pci <= 9'b0000000000;
reset <=1;
forever #100 clk <=~clk ;
end
initial begin
#200
reset <=0;
pci <= 9'b000000000;

end


endmodule
