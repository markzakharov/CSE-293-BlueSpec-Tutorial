package Regfile;

import Vector :: *;
import Decoder :: *;

typedef struct { Int#(32) val1;
                 Int#(32) val2;
} Rs_vals
  deriving (Eq, Bits);

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Regfile_IFC;
  method Rs_vals read (Register idx1, Register idx2);
  method Int#(32) probe (Register idx);
  method Action write (Register idx, Int#(32) d);
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkRegfile (Regfile_IFC);
  Vector #(32, Reg #(Int #(32))) registers <- replicateM (mkReg(0));

  method Rs_vals read (Register idx1, Register idx2);
    return Rs_vals {val1:registers[idx1], val2:registers[idx2]};
  endmethod

  method Int#(32) probe (Register idx);
    return registers[idx];
  endmethod

  method Action write (Register idx, Int#(32) d);
    if (idx != 0) begin
      registers[idx] <= d;
    end
  endmethod
endmodule

endpackage
