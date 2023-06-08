package Testbench;

import Decoder :: *;

(* synthesize *)
module mkTestbench (Empty);
  Decoder_IFC decoder <- mkDecoder;  // instantiate your module

  Reg #(Int#(32))      rg_testing_phase <- mkReg(1);
  Reg #(RawInstruction) rg_insn <- mkReg ('h33);
  Reg #(Int#(32))    de_insn <- mkReg (1);
  Reg #(Int#(32))    de_rd   <- mkReg (0);
  Reg #(Int#(32))    de_rs1  <- mkReg (0);
  Reg #(Int#(32))    de_rs2  <- mkReg (0);

  rule rl_opcode_test;
    let x = decoder.decode(rg_insn);
    $display ("\nDecoding instruction 0x%0h", rg_insn);
    $display ("Decoded Op No. %0d, %0d was expected", x.op, de_insn);
    if (zeroExtend(unpack(pack(x.op))) != de_insn) begin
      $display ("Opcode mismatch, exiting ... ");
      $finish;
    end

    // TEST R TYPE INSNS
    if (rg_testing_phase == 1) begin
      $display ("Decoded Rd, Rs1, Rs2: %0d %0d %0d, %0d %0d %0d was expected", x.rd, x.rs1, x.rs2, de_rd, de_rs1, de_rs2);

      if ((zeroExtend(unpack(pack(x.rd))) != de_rd) || (zeroExtend(unpack(pack(x.rs1))) != de_rs1)) begin
        $display ("Decode mismatch, exiting ... ");
        $finish;
      end
      
      if (rg_insn == 'h153f733) begin // transition to next phase
        rg_testing_phase <= 2;
        rg_insn <= 'h87600013;
        de_insn <= 1;
        de_rd   <= 0;
        de_rs1  <= 0;
        de_rs2  <= 0;
      end else begin   // typical test progression
        rg_insn <= rg_insn + 'h00309100;
        de_insn <= de_insn + 1;
        de_rd   <= de_rd   + 2;
        de_rs1  <= de_rs1  + 1;
        de_rs2  <= de_rs2  + 3;
      end
    // TEST I TYPE INSNS
    end else if (rg_testing_phase == 2) begin
      if (rg_insn[14:12] == 1 || rg_insn[14:12] == 5) begin // shift test case, has smaller imm field than others
        $display ("Decoded Rd, Rs1, Imm: %0d %0d %0d, %0d %0d %0d was expected", x.rd, x.rs1, x.imm, de_rd, de_rs1, 'h16);
      end else if (rg_insn[14:12] == 3) begin // unsigned imm test case
        $display ("Decoded Rd, Rs1, Imm: %0d %0d %0d, %0d %0d %0d was expected", x.rd, x.rs1, x.imm, de_rd, de_rs1, 'h00000876);
      end else begin
        $display ("Decoded Rd, Rs1, Imm: %0d %0d %0d, %0d %0d %0d was expected", x.rd, x.rs1, x.imm, de_rd, de_rs1, 'hFFFFF876);
      end

      if (rg_insn > 'h87636313) begin
        $finish;
      end else begin
        rg_insn <= rg_insn + 'h00009100;
        de_insn <= de_insn + 1;
        de_rd   <= de_rd   + 2;
        de_rs1  <= de_rs1  + 1;
      end
    end

  endrule
endmodule

endpackage
