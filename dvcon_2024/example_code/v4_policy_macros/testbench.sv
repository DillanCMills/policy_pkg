`include "addr_types.svh"
`include "policy_base.svh"
`include "addr_policies.svh"
`include "addr_txn.svh"

      
module tb;
  initial begin
    addr_constrained_txn txn = new();
    txn.randomize();
    $display("addr=%0h", txn.addr);
    $display("f2=%0h", txn.f2);
    $display("f3=%0h", txn.f3);
    $display("f4=%0h", txn.f4);
  end
endmodule