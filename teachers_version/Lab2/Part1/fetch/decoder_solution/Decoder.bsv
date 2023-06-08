package Decoder;

import Mem ::*;

typedef Bit #(32) RawInstruction;
typedef Bit #(5)  Register;
typedef Int #(32) Immediate;

typedef enum { OP_TYPE_ERR, R_TYPE, I_TYPE, S_TYPE, J_TYPE } OP_TYPE
  deriving (Eq, Bits);

typedef enum { OP_ERR, ADD, SLL, SLT, SLTU, XOR, SRL, OR, AND, ST, LD, LDU, JAL } OP 
  deriving (Eq, Bits);

typedef struct { OP            op;
                 OP_TYPE       op_type;
                 Register      rs1;
                 Register      rs2;
                 Register      rd;
                 Immediate     imm;
                 MemAccessSize access_size;
} Instruction
  deriving (Eq, Bits);

// Below we declare the interface (and methods) for this module
// Gets passed into module definition to be "applied" as its I/O
// Good practice to end interface name with '_IFC'

interface Decoder_IFC;
  method Instruction decode (RawInstruction insn);
endinterface

// Below we define the module
// Implementation logic goes here

(* synthesize *)
module mkDecoder (Decoder_IFC);
  method Instruction decode (RawInstruction insn);    // implement logic for method
    OP op;
    OP_TYPE op_type;
    Immediate imm; 
    MemAccessSize access_size;
    Register rd      = insn[11:7];
    Register rs1     = insn[19:15];
    Register rs2     = insn[24:20];
    
    let opcode = insn[6:0];
    let funct3 = insn[14:12];

    if ((opcode == 'h33 || opcode == 'h13)) begin
    access_size = NO_ACCESS;
      case(funct3)
        0: op = ADD;
        1: op = SLL;
        2: op = SLT;
        3: op = SLTU;
        4: op = XOR;
        5: op = SRL;
        6: op = OR;
        7: op = AND;
        default: op = OP_ERR;
      endcase
      
      if (opcode == 'h13) begin
        op_type = I_TYPE;
        if (funct3 == 1 || funct3 == 5) begin
          imm = zeroExtend(unpack(insn[24:20]));
        end else if (funct3 == 3) begin
          imm = zeroExtend(unpack(insn[31:20]));
        end else begin
          imm = signExtend(unpack(insn[31:20]));
        end
      end else begin
        op_type = R_TYPE;
        imm = 0;
      end
    end else if (opcode == 'h3) begin
      op_type = I_TYPE;
      case(funct3)
        0: begin
          op          = LD;
          access_size = BYTE; end
        1: begin
          op          = LD;
          access_size = HALFWORD; end
        2: begin
          op          = LD;
          access_size = WORD; end
        4: begin
          op          = LDU;
          access_size = BYTE; end
        5: begin
          op          = LDU;
          access_size = HALFWORD; end
        default: begin
          op          = OP_ERR;
          access_size = NO_ACCESS; end
      endcase
      imm = signExtend(unpack(insn[31:20]));
    end else if (opcode == 'h23) begin 
      op_type = S_TYPE;
      op      = ST;
      Bit#(12) i_imm;
      i_imm[11:5] = insn[31:25];
      i_imm[4:0]  = insn[11:7];
      imm     = signExtend(unpack(i_imm));
      case(funct3)
        0: access_size = BYTE;
        1: access_size = HALFWORD;
        2: access_size = WORD;
        default: access_size = NO_ACCESS;
      endcase
    end else if (opcode == 'h6F) begin
      op          = JAL;
      op_type     = J_TYPE;
      access_size = NO_ACCESS;
      Bit#(21) j_imm;
      j_imm[20:20] = insn[31:31];
      j_imm[19:12] = insn[19:12];
      j_imm[11:11] = insn[20:20];
      j_imm[10:1]  = insn[30:21];
      j_imm[0:0]   = 1'b0;
      imm          = signExtend(unpack(j_imm));
    end else begin
      op          = OP_ERR;
      op_type     = OP_TYPE_ERR;
      imm         = 0;
      access_size = NO_ACCESS;
    end

    return Instruction {op:op, op_type:op_type, rd:rd, rs1:rs1, rs2:rs2, imm:imm, access_size:access_size};
  endmethod
endmodule

endpackage
