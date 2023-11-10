class addr_l1_txn extends uvm_object;
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
        policy_queue pcy;

        addr_permit_policy   permit   = new();
        addr_prohibit_policy prohibit = new();
        addr_l2_policy       fixed_f2;

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.push_back(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.push_back(prohibit);
        
        fixed_f2 = new('h12345678);
        pcy.push_back(fixed_f2);

        this.policy = {pcy};
    endfunction
endclass