module j(jump_address,out);
input [31:0] jump_address;
output reg [31:0] out;

always @* begin
out=jump_address;
end

endmodule 