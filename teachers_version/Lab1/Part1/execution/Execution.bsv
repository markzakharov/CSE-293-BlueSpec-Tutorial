package Execution;

import Decoder :: *;

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Execution_IFC;
  method Int#(32) executeOp (OP op, Int#(32) src1, Int#(32) src2);
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkExecution (Execution_IFC);
  method Int#(32) executeOp (OP op, Int#(32) src1, Int#(32) src2);    // implement logic for method
    case (op)
      ADD:     return src1 + src2;
      SLL:     return src1 << src2;
      SLT:     return src1 < src2 ? 1 : 0;
      SLTU: begin
               UInt#(32) src1_u;
               UInt#(32) src2_u;
               src1_u = unpack(pack(src1));
               src2_u = unpack(pack(src2));
               return src1_u < src2_u ? 1 : 0;
            end
      XOR:     return src1 ^ src2;
      SRL:     return src1 >> src2;
      OR:      return src1 | src2;
      AND:     return src1 & src2;
      default: return 0;
    endcase
  endmethod
endmodule

endpackage
