package Testbench;

import Decoder :: *;
import Regfile :: *;
import Vector :: *;

(* synthesize *)
module mkTestbench (Empty);
  Regfile_IFC rf <- mkRegfile;  // instantiate your module
  Reg #(Register) rg_write <- mkReg(0);
  Reg #(Register) rg_rs_1 <- mkReg(1);
  Reg #(Register) rg_rs_2 <- mkReg(0);

  rule zero_test (rg_write < 2);
    rf.write(rg_write, zeroExtend(unpack(rg_write)));
    rg_write <= rg_write + 1;
  endrule

  rule write_test (rg_write >= 2);
      rf.write(rg_write, zeroExtend(unpack(rg_write)));
      let x = rf.read(rg_rs_1, rg_rs_2);
      let y = rf.read(rg_rs_1, rg_rs_2);

      rg_write <= rg_write + 1;
      rg_rs_1  <= rg_rs_1 + 1;
      rg_rs_2  <= rg_rs_2 + 1;

      $display("reg %0d and %0d read for val %0d and %0d, expected %0d and %0d", 
        unpack(rg_rs_1), unpack(rg_rs_2), unpack(rg_rs_1), unpack(rg_rs_2), x.val1, x.val2);
      if ((x.val1 != zeroExtend(unpack(rg_rs_1))) || 
         (x.val2 != zeroExtend(unpack(rg_rs_2)))) begin
        $display("Regfile read mismatch, exiting ...");
        $finish;
      end

      if (pack(rg_write) == 31) begin
        $display ("Test passed!");
        $finish;
     end
  endrule
endmodule

endpackage
