module jal(r0,pc,pco,return_address);
input [31:0] r0,pc;
output reg [31:0]return_address;
output reg [31:0] pco;

always @* begin
return_address=pc+1;
pco= r0;
end

endmodule