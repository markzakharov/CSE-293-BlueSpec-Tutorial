package Mem;

import C_import_decls :: *;

typedef UInt #(32) Address;

typedef enum { NO_ACCESS, BYTE, HALFWORD, WORD } MemAccessSize
  deriving (Eq, Bits);

function UInt#(32) mASize_to_bytes (MemAccessSize size);
  // code here
endfunction

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Mem_IFC;
  method Action   init  (UInt#(32) n_bytes);
  method Bool is_init();
  method ActionValue#(Bit#(64)) read  (Address addr, MemAccessSize size);
  method Action   write (Address addr, MemAccessSize size, Int#(32) d);
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkMem (Mem_IFC);
  Reg #(UInt#(32)) rg_size <- mkRegU;
  Reg #(Bool)      rg_initialized <- mkReg(False);
  Reg #(Bit #(64)) rg_ptr <- mkRegU; // pointer to C malloc memory

  method Action init (UInt#(32) n_bytes);
  // code here
  endmethod

  method Bool is_init();
  // code here
  endmethod

  method ActionValue#(Bit#(64)) read (Address addr, MemAccessSize size) if (rg_initialized);    // implement logic for method
  // code here
  endmethod

  method Action write (Address addr, MemAccessSize size, Int#(32) d) if (rg_initialized);
  // code here
  endmethod
endmodule

endpackage
