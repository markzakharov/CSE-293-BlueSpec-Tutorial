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
  // code here
  endmethod
endmodule

endpackage
