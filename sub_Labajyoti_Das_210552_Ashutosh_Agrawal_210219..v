module sub(a,b,out);
input [31:0]a,b;
output reg [31:0] out;
always @*
out=a-b;
endmodule
