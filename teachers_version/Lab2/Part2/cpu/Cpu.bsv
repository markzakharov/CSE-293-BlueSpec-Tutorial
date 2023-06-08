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
  
  Instruction dE_insn = dE.get_b();  // forwarding from E back to D
  Values      dE_vals = dE.get_c();

//---------------Fetch stage-------------------------------

  rule fetch_stage (is_init);
    Immediate pc_offset;
    Instruction x = decode.decode(pack(fD.get_c().val1)); // c.val1 is rawinsn
    
    if (x.op == JAL)
      pc_offset = x.imm;
    else
      pc_offset = 4;

    fetch.inc_pc(pc_offset); // Jump insns may modify next pc

    Values y = Values { val1:unpack(pack(fetch.get_insn())), val2:0, res:0 };
    fD.set(fetch.get_pc(), emptyInsn(), y);
  endrule

//----------------Decode stage-----------------------------

  rule decode_stage (is_init);
    Instruction insn = decode.decode(pack(fD.get_c().val1));
    let vals         = rf.read(insn.rs1, insn.rs2);

    Int#(32) val1;
    if (insn.rs1 == dE_insn.rd)  //forwarding
      val1 = dE_vals.res;
    else
      val1 = vals.val1;

    Int#(32) val2;
    if (insn.op_type == I_TYPE)  //forwarding
      val2 = insn.imm;
    else if ((insn.op_type == R_TYPE) && (insn.rs2 == dE_insn.rd))
      val2 = dE_vals.res;
    else
      val2 = vals.val2;

    // Read Regfile early so we can forward in EX stage
    Values x = Values {val1:val1, val2:val2, res:0 };

    dE.set(fD.get_a(), insn, x);
  endrule

//----------------Execute stage----------------------------

  rule execute_stage (is_init);
    Instruction insn = dE_insn;
    Values      vals = dE_vals;
    Int#(32) val1 = vals.val1;
    Int#(32) val2 = vals.val2;

    Int#(32) result = execution.executeOp(insn.op, val1, val2);
    Values x        = Values {val1:val1, val2:val2, res:result};

    eM.set(dE.get_a(), insn, x);   // now the result is propagated
  endrule

//----------------Memory stage----------------------------

  rule memory_stage (is_init);
    Bit#(64) result = 0;
    let vals        = eM.get_c();

    Instruction insn = eM.get_b();
    let access_sz    = insn.access_size;
    if (access_sz != NO_ACCESS) begin
      Address addr = unpack(pack(insn.imm)) + unpack(pack(vals.val1));

      if ((insn.op == LD) || (insn.op == LDU)) begin
        let x <- memory.read(addr, access_sz);
        result = x;
        vals.res = unpack(result[31:0]);
      end else if (insn.op == ST) begin
        memory.write(addr, access_sz, vals.val2);
        insn.rd = 0;                   // stores have no writeback
      end
    end

    mW.set(eM.get_a(), insn, vals);
  endrule

//----------------Writeback stage--------------------------

  rule writeback_stage (is_init);
    Register rd = mW.get_b().rd;
    Int#(32) x  = mW.get_c().res;

    rf.write(rd, x);
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
