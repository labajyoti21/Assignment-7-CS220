module slti(a,immediate_value,out);
input [31:0]a,immediate_value;
output reg [31:0] out;
always @*
out= a<immediate_value ? 1:0 ;
endmodule
