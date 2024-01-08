class addr_txn extends uvm_object;
    // class members, constraints, and pre_randomize unchanged from previous example

    `start_policies(addr_txn)
        `include "addr_policies.svh"
    `end_policies
endclass

class addr_p_txn extends addr_txn;
    // class members and constraints unchanged from previous example

    `start_extended_policies(addr_p_txn, addr_txn)
        `fixed_policy(PARITY_ERR, bit, parity_err)
    `end_policies
endclass

class addr_constrained_txn extends addr_p_txn;
    // ... unchanged from previous example
endclass