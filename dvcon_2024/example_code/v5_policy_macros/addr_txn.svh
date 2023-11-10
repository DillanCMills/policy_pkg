class addr_txn extends uvm_object;
    rand bit [31:0]   addr;
    rand int          size;
    rand policy_queue policy;

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction

    `start_policies(addr_txn)
        `include "addr_policies.svh"
    `end_policies
endclass

class addr_p_txn extends addr_txn;
    rand bit parity;

    constraint c_parity {parity == $countones(addr) % 2;}

    `start_extended_policies(addr_p_txn, addr_txn)
        `fixed_policy(FIXED_PARITY, bit, parity)
    `end_policies
endclass

class addr_constrained_txn extends addr_p_txn;
    // ... unchanged from previous example
endclass