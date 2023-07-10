module jr(r0,pc,out);
input [31:0] r0,pc;
output reg [31:0] out;

always @* begin
out=r0;
end

endmodule 