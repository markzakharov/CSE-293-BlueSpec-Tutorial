package Cpu;

import C_import_decls ::*;
import Decoder   ::*;
import Mem       ::*;
import Execution ::*;
import Fetch     ::*;
import Regfile   ::*;
import Pipeline  ::*;

typedef struct { Address     pc;
                 Instruction insn;
                 Values      vals;
} Pipeline_data
  deriving (Eq, Bits);

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Cpu_IFC;
  method Action init(UInt#(32) n_bytes);
  method Action write_insn(Address addr, RawInstruction insn);
  method ActionValue#(Bit#(64)) read_mem(Address addr, MemAccessSize sz);
  method Int#(32) read_rf(Register idx);
  method Pipeline_data read_FD();
  method Pipeline_data read_DE();
  method Pipeline_data read_EM();
  method Pipeline_data read_MW();
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkCpu (Cpu_IFC);
  Reg #(Bool) is_init      <- mkReg(False);

  Fetch_IFC     fetch      <- mkFetch;
  Pipeline_IFC  fD         <- mkPipeline; // c will be rawinstruction
  Decoder_IFC   decode     <- mkDecoder;
  Pipeline_IFC  dE         <- mkPipeline;
  Execution_IFC execution  <- mkExecution;
  Pipeline_IFC  eM         <- mkPipeline;
  Mem_IFC       memory     <- mkMem;
  Pipeline_IFC  mW         <- mkPipeline;
  Regfile_IFC   rf         <- mkRegfile;
  

//---------------Fetch stage-------------------------------

  rule fetch_stage (is_init);
   // code here
  endrule

//----------------Decode stage-----------------------------

  rule decode_stage (is_init);
   // code here
  endrule

//----------------Execute stage----------------------------

  rule execute_stage (is_init);
   // code here
  endrule

//----------------Memory stage----------------------------

  rule memory_stage (is_init);
    // code here
  endrule

//----------------Writeback stage--------------------------

  rule writeback_stage (is_init);
   // code here
  endrule

//---------------------------------------------------------
  method Action init(UInt#(32) n_bytes) if (!is_init);
    fetch.init(n_bytes);
    memory.init(n_bytes);
    is_init <= True;
  endmethod

  method Action write_insn(Address addr, RawInstruction insn) if (is_init);
    fetch.st_insn(addr, insn);
  endmethod

  method ActionValue#(Bit#(64)) read_mem(Address addr, MemAccessSize sz) if (is_init);
    let x <- memory.read(addr, sz);
    return x;
  endmethod
  
  method Int#(32) read_rf(Register idx) if (is_init);
    return rf.probe(idx);
  endmethod

  method Pipeline_data read_FD();
    return Pipeline_data { pc:fD.get_a(), insn:fD.get_b(), vals:fD.get_c() };
  endmethod

  method Pipeline_data read_DE();
    return Pipeline_data { pc:dE.get_a(), insn:dE.get_b(), vals:dE.get_c() };
  endmethod

  method Pipeline_data read_EM();
    return Pipeline_data { pc:eM.get_a(), insn:eM.get_b(), vals:eM.get_c() };
  endmethod

  method Pipeline_data read_MW();
    return Pipeline_data { pc:mW.get_a(), insn:mW.get_b(), vals:mW.get_c() };
  endmethod

endmodule
endpackage
