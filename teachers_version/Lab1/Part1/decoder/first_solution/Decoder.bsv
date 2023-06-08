package Decoder;

typedef Bit #(32) RawInstruction;
typedef Bit #(5)  Register;
typedef Int #(32) Immediate;

typedef enum { OP_TYPE_ERR, R_TYPE, I_TYPE } OP_TYPE
  deriving (Eq, Bits);

typedef enum { OP_ERR, ADD, SLL, SLT, SLTU, XOR, SRL, OR, AND } OP 
  deriving (Eq, Bits);

typedef struct { OP        op;
                 OP_TYPE   op_type;
                 Register  rs1;
                 Register  rs2;
                 Register  rd;
                 Immediate imm;
} Instruction
  deriving (Bits);

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
    Register rd      = insn[11:7];
    Register rs1     = insn[19:15];
    Register rs2     = insn[24:20];
    
    let opcode = insn[6:0];
    let funct3 = insn[14:12];

    if ((opcode == 'h33 || opcode == 'h13)) begin
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
    end else begin
      op      = OP_ERR;
      op_type = OP_TYPE_ERR;
      imm     = 0;
    end

    return Instruction {op:op, op_type:op_type, rd:rd, rs1:rs1, rs2:rs2, imm:imm};
  endmethod
endmodule

endpackage
