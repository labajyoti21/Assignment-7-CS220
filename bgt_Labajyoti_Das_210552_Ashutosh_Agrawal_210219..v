module bgt(
    input [31:0] r0,
    input [31:0] r1,
    input [31:0] offset,
    input [31:0] pc,
    output reg [31:0] out
);

always @* begin
    if(r0 > r1) begin
        out = pc + 1 + offset;
    end else begin
        out = pc + 1;
    end
end
endmodule 