package Mem;

import C_import_decls :: *;

typedef UInt #(32) Address;

typedef enum { NO_ACCESS, BYTE, HALFWORD, WORD } MemAccessSize
  deriving (Eq, Bits);

function UInt#(32) mASize_to_bytes (MemAccessSize size);
  case (size)
    BYTE:     return 1;
    HALFWORD: return 2;
    WORD:     return 4;
    default:  return 0;
  endcase
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
  Reg #(Bool)     rg_initialized <- mkReg(False);
  Reg #(Bit #(64)) rg_ptr <- mkRegU; // pointer to C malloc memory

  method Action init (UInt#(32) n_bytes);
    let p <- c_malloc_and_init(extend(pack(n_bytes)), 0);
    rg_ptr <= p;
    rg_size <= n_bytes;
    rg_initialized <= True;
  endmethod

  method Bool is_init();
    return rg_initialized;
  endmethod

  method ActionValue#(Bit#(64)) read (Address addr, MemAccessSize size) if (rg_initialized);    // implement logic for method
    UInt #(32) bound;
    bound = unpack(pack(addr)) + mASize_to_bytes(size);
    if ((bound >= rg_size) || (addr >= rg_size)) begin
      $display("attempted out of bounds read at address 0x%0h",unpack(pack(addr)));
      return 0;
    end else begin
      let p = rg_ptr + extend(pack(addr));
      let d <- c_read (p, extend(pack(mASize_to_bytes(size))));
      return d;
    end
  endmethod

  method Action write (Address addr, MemAccessSize size, Int#(32) d) if (rg_initialized);
    UInt #(32) bound;
    bound = unpack(pack(addr)) + mASize_to_bytes(size);
    if ((bound >= rg_size) || (addr >= rg_size)) begin
      $display("attempted out of bounds write at address 0x%0h",unpack(pack(addr)));
    end else begin
      let p = rg_ptr + extend(pack(addr));
      c_write (p,extend(pack(d)), extend(pack(mASize_to_bytes(size))));
    end
  endmethod
endmodule

endpackage
