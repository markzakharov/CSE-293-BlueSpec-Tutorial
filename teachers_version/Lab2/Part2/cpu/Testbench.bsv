package Testbench;

import Cpu      ::*;
import C_import_decls ::*;
import Pipeline ::*;
import Regfile  ::*;
import Fetch    ::*;
import Execution ::*;
import Decoder  ::*;
import Mem      ::*;

(* synthesize *)
module mkTestbench (Empty);
  Cpu_IFC cpu          <- mkCpu;
  Reg#(Bool) is_init   <- mkReg(False);
  Reg#(Bool) fail      <- mkReg(False);
  Reg#(Int#(32)) phase <- mkReg(0);

  rule init (!is_init);
    cpu.init(32);
    is_init <= True;
  endrule

  rule test (is_init && !fail);
    phase <= phase + 1;
    $display ("clk cycle %0d",phase);

    case (phase)
      0: begin
           $display ("single cycle startup");
           cpu.write_insn(4, 32'h00108093); // addi x1, x1, 1
         end
      1: begin
           $display("Fetch stage working...");
           cpu.write_insn(4, 32'h00108093); // addi x1, x1, 1
         end
      2: begin
           let x = cpu.read_FD();
           $display("F: addi x1, x1, 1 - insn: 0x%0h - pc: 0x%0h",x.vals.val1,x.pc);
           if ((x.vals.val1 != 32'h00108093) || (x.pc) != 4)
             fail <= True;
         end
      3: begin
           let x = cpu.read_DE();
           let insn = emptyInsn();
           insn.op = ADD;
           insn.op_type = I_TYPE;
           insn.rd = 1;
           insn.rs1 = 1;
           insn.rs2  = 1;
           insn.imm = 1;
           insn.access_size = NO_ACCESS;
           $display("D: addi x1, x1, 1");
           $display("F: addi x1, x1, 1");
           if ((x.pc != 4) || !areInsnsEq(x.insn,insn))
             fail <= True;
         end
      4: begin
           $display("E: addi x1, x1, 1");
           $display("D: addi x1, x1, 1");
           let x = cpu.read_EM();
           if (x.vals.res != 1)
             fail <= True;
         end
      5: begin
           $display("M: addi x1, x1, 1");
           $display("E: addi x1, x1, 1");
           let x = cpu.read_MW();
           if (x.insn.access_size != NO_ACCESS)
             fail <= True;
         end
      default: begin
          $display("Test passed!");
          $finish;
        end
    endcase
  endrule

  rule failure (fail);
    $display("DUT diverged from expected results");
    $finish;
  endrule
endmodule

endpackage
