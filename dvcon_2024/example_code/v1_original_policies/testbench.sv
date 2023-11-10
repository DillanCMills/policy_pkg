`include "addr_types.svh"
`include "policy_base.svh"
`include "addr_policies.svh"
`include "addr_txn.svh"

      
module tb;
  initial begin
    addr_constrained_txn txn = new();
    txn.randomize();
    $display("addr=%0h", txn.addr);
  end
endmodule