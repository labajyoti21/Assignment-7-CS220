`include "veda.v"

module instruction_fetch(reset,instruction, pc);
    input reset;
    inout [4:0] pc;
    output reg [31:0] instruction;
    wire [31:0]dataout;

  veda memory(.dataout(dataout),.Writeen(1'b0),.addressa(pc),.addressb(5'b0),.mode(mode),.Datain(0),.reset(rst));

always @ (posedge clk) begin

// We have fetched the instruction from the veda meory and stored it in the instruction regsiter
    instruction <= dataout;

end

endmodule