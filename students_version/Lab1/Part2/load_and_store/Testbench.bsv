package Testbench;

import Decoder :: *;
import Mem ::*;

(* synthesize *)
module mkTestbench (Empty);
  Decoder_IFC decoder <- mkDecoder;  // instantiate your module

  Reg #(Int#(32))      rg_testing_phase <- mkReg(1);
  Reg #(RawInstruction) rg_insn <- mkReg ('h23);
  Reg #(Int#(32))    de_insn <- mkReg (9);
  Reg #(Int#(32))    de_rd   <- mkReg (0);
  Reg #(Int#(32))    de_rs1  <- mkReg (0);
  Reg #(Int#(32))    de_rs2  <- mkReg (0);
  Reg #(Int#(32))    de_imm  <- mkReg (0);
  Reg #(UInt#(32))   de_access  <- mkReg (1);

  rule rl_opcode_test;
    let x = decoder.decode(rg_insn);
    $display ("\nDecoding instruction 0x%0h", rg_insn);
    $display ("Decoded Op No. %0d, %0d was expected", x.op, de_insn);
    if (zeroExtend(unpack(pack(x.op))) != de_insn) begin
      $display ("Opcode mismatch, exiting ... ");
      $finish;
    end

    // TEST S TYPE INSNS
    if (rg_testing_phase == 1) begin
      $display ("Decoded imm, Rs1, Rs2, size: %0d %0d %0d %0d, %0d %0d %0d %0d was expected", 
                         x.imm, x.rs1, x.rs2, mASize_to_bytes(x.access_size), de_imm, de_rs1, de_rs2, de_access);

      if ((zeroExtend(unpack(pack(x.imm))) != de_imm) || (zeroExtend(unpack(pack(x.rs1))) != de_rs1)
        || (zeroExtend(unpack(pack(x.rs2))) != de_rs2) || (mASize_to_bytes(x.access_size) != de_access)) begin
        $display ("Decode mismatch, exiting ... ");
        $finish;
      end
      
      if (rg_insn == 'h612223) begin // transition to next phase
        rg_testing_phase <= 2;
        rg_insn <= 'h3;
        de_insn <= 10;
        de_rd   <= 0;
        de_rs1  <= 0;
        de_imm <= 0;
        de_access <= 1;
      end else begin   // typical test progression
        rg_insn <= rg_insn + 'h00309100;
        de_imm   <= de_imm  + 2;
        de_rs1  <= de_rs1  + 1;
        de_rs2  <= de_rs2  + 3;
        de_access <= de_access * 2;
      end
    // TEST I TYPE INSNS
    end else if (rg_testing_phase == 2) begin
      $display ("Decoded imm, Rs1, Rd, size: %0d %0d %0d %0d, %0d %0d %0d %0d was expected", 
                         x.imm, x.rs1, x.rd, mASize_to_bytes(x.access_size), de_imm, de_rs1, de_rd, de_access);

      if ((zeroExtend(unpack(pack(x.imm))) != de_imm) || (zeroExtend(unpack(pack(x.rs1))) != de_rs1)
        || (zeroExtend(unpack(pack(x.rd))) != de_rd) || (mASize_to_bytes(x.access_size) != de_access)) begin
        $display ("Decode mismatch, exiting ... ");
        $finish;
      end

      if (rg_insn == 'h612203) begin
        rg_insn <= rg_insn + 'h0030a100;
        de_rd   <= de_rd   + 2;
        de_rs1  <= de_rs1  + 1;
        de_imm <= de_imm + 3;
        de_access <= 1;
        de_insn <= 11;
      end else if (rg_insn == 'h91c303) begin
        $display ("Test passed!");
        $finish;
      end else begin
        rg_insn <= rg_insn + 'h00309100;
        de_rd   <= de_rd   + 2;
        de_rs1  <= de_rs1  + 1;
        de_imm <= de_imm + 3;
        de_access <= de_access * 2;
      end
    end

  endrule
endmodule

endpackage
