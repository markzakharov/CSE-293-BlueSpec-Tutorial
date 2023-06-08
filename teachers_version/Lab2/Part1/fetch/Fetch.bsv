package Fetch;

import Decoder ::*;
import Mem     ::*;

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Fetch_IFC;
  method Action         init(UInt#(32) n_bytes);
  method Bool           is_init();
  method Address        get_pc();
  method RawInstruction get_insn();
  method Action         inc_pc(Immediate offset);
  method Action         st_insn(Address addr, RawInstruction insn);
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkFetch (Fetch_IFC);
  // Instruction Memory
  Mem_IFC insn_mem <- mkMem;

  // Control signal(s)
  Reg#(Address)        rg_pc <- mkReg(0);
  Reg#(RawInstruction) rg_insn <- mkReg(0);

  method Action init (UInt#(32) n_bytes);
    insn_mem.init(n_bytes);
  endmethod

  method Bool is_init();
    return insn_mem.is_init();
  endmethod

  method Address get_pc() if (insn_mem.is_init());
    return rg_pc;
  endmethod

  method RawInstruction get_insn() if (insn_mem.is_init());
    return rg_insn;
  endmethod

  method Action inc_pc(Immediate offset) if (insn_mem.is_init());
    let next_pc = rg_pc + unpack(pack(offset));
    rg_pc      <= next_pc;
    let val    <- insn_mem.read(next_pc, WORD);
    rg_insn    <= unpack(val[31:0]);
  endmethod

  method Action st_insn(Address addr, RawInstruction insn) if (insn_mem.is_init());
    Int#(32) d = unpack(pack(insn));
    insn_mem.write(addr, WORD, d);
  endmethod
endmodule

endpackage
