package Testbench;

import Fetch   ::*;
import Decoder ::*;
import Mem     ::*;

(* synthesize *)
module mkTestbench (Empty);
  Decoder_IFC decoder <- mkDecoder;  // instantiate your module
  Decoder_IFC decoder_2 <- mkDecoder;
  Decoder_IFC decoder_3 <- mkDecoder;
  Fetch_IFC fetch     <- mkFetch;

  Reg #(Int#(32))      rg_testing_phase <- mkReg(1);

  rule rl_init (fetch.is_init() == False);
    fetch.init(32);
  endrule

  rule rl_opcode_test (fetch.is_init() == True);
    RawInstruction insn;
    Instruction x;

    // TEST J TYPE INSN
    if (rg_testing_phase == 1) begin
      fetch.st_insn(4,  32'h00c0006f);
      fetch.inc_pc(4);
      insn = 'hAAAAAAEF;
      x = decoder.decode(insn);

      $display("Decoded imm, rd, opcode - expected: 0xfffaa2aa, 21, 12 - result: 0x%0h, %0d, %0d", x.imm, x.rd, x.op);

      if ((x.imm != 32'hfffaa2aa) || (x.rd != 21) || (x.op != JAL)) begin
        $display ("Decode mismatch, exiting ...");
        $finish;
      end else $display ("Decode test passed!");

      rg_testing_phase <= 2;
    end else if (rg_testing_phase == 2) begin
      fetch.st_insn(16, 32'h00000003);

      insn = fetch.get_insn();
      x = decoder_2.decode(insn);

      fetch.inc_pc(x.imm);
      $display("jumping to PC 0x%0h, expected 0x10", fetch.get_pc() + unpack(pack(x.imm)));
      if ((fetch.get_pc() + unpack(pack(x.imm))) != 'h10) begin
        $display ("Jump address mismatch, exiting ...");
        $finish;
      end else begin
        rg_testing_phase <= 3;
      end
    end else begin
      insn = fetch.get_insn();
      x = decoder_3.decode(insn);

      $display("Fetched insn after jump 0x%0h, expected 0x3", insn);
      if (insn != 3) begin
        $display ("Insn mismatch, exiting ...");
        $finish;
      end else begin
        $display ("Test passed!");
        $finish;
      end
    end

  endrule
endmodule

endpackage
