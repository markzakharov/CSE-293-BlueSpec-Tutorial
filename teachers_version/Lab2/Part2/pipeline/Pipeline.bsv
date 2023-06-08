package Pipeline;

import Decoder ::*;
import Mem     ::*;

typedef struct { Int#(32) val1;
                 Int#(32) val2;
                 Int#(32) res;
} Values
  deriving (Eq, Bits);

function Values emptyValues();
  return Values { val1:0, val2:0, res:0 };
endfunction

function Bool areValuesEq(Values a, Values b);
  return ((a.val1 == b.val1) && (a.val2 == b.val2) && (a.res == b.res));
endfunction

function Instruction emptyInsn();
  return Instruction {op:OP_ERR, op_type:OP_TYPE_ERR, rd:0, rs1:0, rs2:0, imm:0, access_size:NO_ACCESS};
endfunction

function Bool areInsnsEq(Instruction a, Instruction b);
  return ((a.op == b.op) && (a.op_type == b.op_type) && (a.rs1 == b.rs1) && (a.rs2 == b.rs2) &&
         (a.rd == b.rd) && (a.imm == b.imm) && (a.access_size == b.access_size));
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
    return rg_a;
  endmethod

  method Instruction get_b();
    return rg_b;
  endmethod

  method Values get_c();
    return rg_c;
  endmethod

  method Action set (Address a_d, Instruction b_d, Values c_d);
    rg_a <= a_d;
    rg_b <= b_d;
    rg_c <= c_d;
  endmethod
endmodule

endpackage
