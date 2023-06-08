package Testbench;

import Mem :: *;
import C_import_decls :: *;

(* synthesize *)
module mkTestbench (Empty);
  Mem_IFC memory <- mkMem;  // instantiate your module

  Reg #(Bool) is_mem_init <- mkReg(False);
  Reg #(Address) answer <- mkReg(0);

  rule rl_init_mem (is_mem_init == False);
    memory.init(10);
    is_mem_init <= True;
  endrule

  rule rl_execute_test (is_mem_init == True);
    let val <- memory.read(answer - 1, BYTE);  // should be able to handle out of bounds conditions

    if (answer == 0)
      memory.write(0, WORD, 'h04030201); // populate memory

    answer <= answer + 1;
    $display ("val read 0x%0h", val);
    if (val != extend(pack(answer))) begin
      $display ("Expected read val 0x%0h, instead read 0x%0h, exiting ...",val, answer);
      $finish;
    end

    if (answer == 4)
      $finish;
  endrule
endmodule

endpackage
