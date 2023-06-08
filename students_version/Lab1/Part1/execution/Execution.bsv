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
   // code here
  endmethod
endmodule

endpackage
