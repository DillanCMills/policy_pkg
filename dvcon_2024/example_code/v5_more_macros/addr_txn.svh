class addr_l1_txn;
    rand bit [31:0] addr;
    rand int        size;
    rand policy_base#(addr_l1_txn) policy_l1[$];

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy_l1[i]) policy_l1[i].set_item(this);
    endfunction

    `start_policies(addr_l1_txn)
    class range_addr_policy extends LOCAL_POLICY_T;
        protected addr_range ranges[$];
        protected bit m_inside;
        rand int selection;

        constraint c_range_addr {!m_inside ^ (item.addr inside {[m_min:m_max]});}
    endclass

    static function policy_base RANGE_ADDR();
        range_addr_policy p = new;
        return p;
    endfunction
    `end_policies
endclass


class addr_l2_txn extends addr_l1_txn;
    rand int f2;

    `start_extended_policies(addr_l2_txn, addr_l1_txn)
        `fixed_policy(FIXED_F2, int, F2)
    `end_extended_policies
endclass


class addr_l3_txn extends addr_l2_txn;
    rand int f3;

    `start_extended_policies(addr_l3_txn, addr_l2_txn)
        `fixed_policy(FIXED_F3, int, F3)
    `end_extended_policies
endclass


class addr_l4_txn extends addr_l3_txn;
    rand int f4;

    `start_extended_policies(addr_l4_txn, addr_l3_txn)
        `fixed_policy(FIXED_F4, int, F4)
    `end_extended_policies
endclass


class addr_constrained_txn extends addr_l4_txn;
    function new;
        policy_list#(addr_constrained_txn) pcy = new;

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.add(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.add(prohibit);

        pcy.add(addr_constrained_txn::POLICIES::FIXED_F2('h12345678));
        pcy.add(addr_constrained_txn::POLICIES::FIXED_F3('h55555555));
        pcy.add(addr_constrained_txn::POLICIES::FIXED_F4('h87654321));

        this.policy = {pcy};
    endfunction
endclass