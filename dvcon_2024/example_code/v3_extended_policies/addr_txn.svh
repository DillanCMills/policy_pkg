class addr_l1_txn;
    rand bit [31:0]   addr;
    rand int          size;
    rand policy_queue policy;

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction
endclass


class addr_l2_txn extends addr_l1_txn;
    rand int f2;
endclass


class addr_constrained_txn extends addr_l2_txn;
    function new;
        policy_queue pcy = new;

        addr_permit_policy::base_policy   permit   = addr_permit_policy::PERMIT_POLICY();
        addr_prohibit_policy::base_policy prohibit = addr_prohibit_policy::PROHIBIT_POLICY();

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.add(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.add(prohibit);
        
        pcy.add(addr_l2_policy::FIXED_F2('h12345678));

        this.policy = {pcy};
    endfunction
endclass