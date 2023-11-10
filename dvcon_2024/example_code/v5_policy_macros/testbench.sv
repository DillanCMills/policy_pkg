`include "addr_types.svh"
`include "policy_base.svh"
`include "policy_macros.svh"
`include "addr_txn.svh"
      
module tb;
  initial begin
    addr_constrained_txn txn = new();
    txn.randomize();
    $display("addr=%0h", txn.addr);
    $display("parity=%0h", txn.parity);
  end
endmodule
