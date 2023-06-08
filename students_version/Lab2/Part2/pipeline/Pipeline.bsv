package Pipeline;

import Decoder ::*;
import Mem     ::*;

typedef struct { Int#(32) val1;
                 Int#(32) val2;
                 Int#(32) res;
} Values
  deriving (Eq, Bits);

function Values emptyValues();
  // code here
endfunction

function Bool areValuesEq(Values a, Values b);
  // code here
endfunction

function Instruction emptyInsn();
  // code here
endfunction

function Bool areInsnsEq(Instruction a, Instruction b);
  // code here
endfunction

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Pipeline_IFC;
  method Address     get_a();
  method Instruction get_b();
  method Values      get_c();
  method Action      set(Address a_d, Instruction b_d, Values c_d);
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkPipeline (Pipeline_IFC);
  Reg#(Address)     rg_a <- mkReg(0);
  Reg#(Instruction) rg_b <- mkReg(emptyInsn());
  Reg#(Values)      rg_c <- mkReg(emptyValues());

  method Address get_a();
    // code here
  endmethod

  method Instruction get_b();
    // code here
  endmethod

  method Values get_c();
    // code here
  endmethod

  method Action set (Address a_d, Instruction b_d, Values c_d);
    // code here
  endmethod
endmodule

endpackage
