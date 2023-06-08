package Testbench;

import Pipeline ::*;
import Decoder  ::*;
import Mem      ::*;

(* synthesize *)
module mkTestbench (Empty);
  Pipeline_IFC p_1 <- mkPipeline;  // instantiate your module
  Pipeline_IFC p_2 <- mkPipeline;
  Pipeline_IFC p_3 <- mkPipeline;

  Reg#(Int#(32)) rg_test <- mkReg(1);
  Reg#(Bool) rg_fail     <- mkReg(False);

  rule rl_pipe_test (rg_fail == False);
    p_2.set(p_1.get_a(), p_1.get_b(), p_1.get_c());
    p_3.set(p_2.get_a(), p_2.get_b(), p_2.get_c());
    rg_test <= rg_test + 1;

    $display ("Stage 3 is streaming data: addr %0d, insn {op %0d, op_type %0d, rd %0d, rs1 %0d, rs2 %0d, imm %0d, access_size %0d}, values {val1 %0d, val2 %0d, res %0d }", 
               p_3.get_a(), p_3.get_b().op, p_3.get_b().op_type, p_3.get_b().rd, p_3.get_b().rs1, p_3.get_b().rs2, p_3.get_b().imm, p_3.get_b().access_size, p_3.get_c().val1, p_3.get_c().val2, p_3.get_c.res);

    Address a_1     = 1;
    Instruction b_1 = Instruction {op:ADD, op_type: R_TYPE, rd: 1, rs1: 1, rs2: 1, imm: 1, access_size: BYTE};
    Values c_1      = Values {val1:1, val2:1, res:1};
    Address a_2     = 2;
    Instruction b_2 = Instruction {op:LD, op_type: I_TYPE, rd: 2, rs1: 2, rs2: 2, imm: 2, access_size: HALFWORD};
    Values c_2      = Values {val1:2, val2:2, res:2};
    Address a_3     = 3;
    Instruction b_3 = Instruction {op:ST, op_type: S_TYPE, rd: 3, rs1: 3, rs2: 3, imm: 3, access_size: WORD};
    Values c_3      = Values {val1:3, val2:3, res:3};

    case (rg_test)
      1: begin
        p_1.set(a_1, b_1, c_1);
        if ((p_3.get_a() != 0) || !areInsnsEq(p_3.get_b(), emptyInsn()) 
                               || !areValuesEq(p_3.get_c(), emptyValues())) 
          rg_fail <= True;
      end
      2: begin
        p_1.set(a_2, b_2, c_2);
        if ((p_3.get_a() != 0) || !areInsnsEq(p_3.get_b(), emptyInsn())
                               || !areValuesEq(p_3.get_c(), emptyValues())) 
          rg_fail <= True;
      end
      3: begin
        p_1.set(a_3, b_3, c_3);
        if ((p_3.get_a() != 0) || !areInsnsEq(p_3.get_b(), emptyInsn())
                               || !areValuesEq(p_3.get_c(), emptyValues())) 
          rg_fail <= True;
      end
      4: begin
        if ((p_3.get_a() != a_1) || !areInsnsEq(p_3.get_b(), b_1)
                                 || !areValuesEq(p_3.get_c(), c_1))
          rg_fail <= True;
      end
      5: begin
        if ((p_3.get_a() != a_2) || !areInsnsEq(p_3.get_b(), b_2)
                                 || !areValuesEq(p_3.get_c(), c_2))
          rg_fail <= True;
      end
      6: begin
        if ((p_3.get_a() != a_3) || !areInsnsEq(p_3.get_b(), b_3)
                                 || !areValuesEq(p_3.get_c(), c_3))
          rg_fail <= True;
      end
      default: begin
        $display ("Test passed!");
        $finish;
      end
    endcase
  endrule

  rule rl_fail (rg_fail == True);
    $display ("Information was not sent down the pipeline, exiting ...");
    $finish;
  endrule
endmodule

endpackage
