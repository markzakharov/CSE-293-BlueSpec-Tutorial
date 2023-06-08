package Testbench;

import Execution :: *;
import Decoder   :: *;

(* synthesize *)
module mkTestbench (Empty);
  Execution_IFC execution <- mkExecution;  // instantiate your module

  Reg #(OP) op <- mkReg(ADD);
  Reg #(Int#(32)) src1 <- mkReg(1);
  Reg #(Int#(32)) src2 <- mkReg(2);

  rule rl_execute_test;
  let answer = execution.executeOp(op, src1, src2);

    case (op)
      ADD: begin
        $display ("\n1 ADD 2 = 3, got %0d", answer);
        if (answer != 3) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        op <= SLL; end
      SLL: begin
        $display ("\n1 SLL 2 = 4, got %0d", answer);
        if (answer != 4) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        src1 <= 1; src2 <= -1;
        op <= SLT; end
      SLT: begin
        $display ("\n1 SLT -1 = 0, got %0d", answer);
        if (answer != 0) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        src1 <= 1; src2 <= -1;
        op <= SLTU; end
      SLTU: begin
        $display ("\n1 SLTU -1 = 1, got %0d", answer);
        if (answer != 1) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        src1 <= 'h1111; src2 <= 'hEEEE;
        op <= XOR; end
      XOR: begin
        $display ("\n0x1111 XOR 0xEEEE = 0x0000FFFF, got 0x%0H", answer);
        if (answer != 'hFFFF) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        src1 <= 8; src2 <= 2;
        op <= SRL; end
      SRL: begin
        $display ("\n8 SRL 2 = 2, got %0d", answer);
        if (answer != 2) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        src1 <= 32'hF0F0F0F0; src2 <= 32'h0F0F0F0F;
        op <= OR; end
      OR: begin
        $display ("\n0xF0F0F0F0 OR 0x0F0F0F0F = 0xFFFFFFFF, got 0x%0H", answer);
        if (answer != -1) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        src1 <= 8; src2 <= 8;
        op <= AND; end
      AND: begin
        $display ("\n8 AND 8 = 8, got %0d", answer);
        if (answer != 8) begin
          $display ("Result incorrect, exiting ...");
          $finish;
        end
        op <= OP_ERR; end
      default: begin $display ("Test passed!"); $finish; end
    endcase

  endrule
endmodule

endpackage
