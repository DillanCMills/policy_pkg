class addr_l1_txn extends uvm_object;
    rand bit [31:0]   addr;
    rand int          size;
    rand policy_queue policy;

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction

    `start_policies(addr_l1_txn)
        `include "addr_policies.svh"
    `end_policies
endclass


class addr_l2_txn extends addr_l1_txn;
    rand int f2;

    `start_extended_policies(addr_l2_txn, addr_l1_txn)
        `fixed_policy(FIXED_F2, int, f2)
    `end_policies
endclass


class addr_constrained_txn extends addr_l2_txn;
    function new;
        policy_queue pcy;

        addr_constrained_txn::POLICIES::addr_permit_policy   permit   = new();
        addr_constrained_txn::POLICIES::addr_prohibit_policy prohibit = new();

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.push_back(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.push_back(prohibit);
        
        pcy.push_back(addr_constrained_txn::POLICIES::FIXED_F2('h12345678));

        this.policy = {pcy};
    endfunction
endclass