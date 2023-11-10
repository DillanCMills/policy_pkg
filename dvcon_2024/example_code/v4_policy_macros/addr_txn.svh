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

        constraint c_range_addr {
            if (m_inside) {
                selection inside {[0:ranges.size()-1]};

                foreach(ranges[i]) {
                    if (i == selection) {
                        item.addr inside {[ranges[i].min:ranges[i].max - item.size]};
                    }
                }
            } else {
                foreach(ranges[i]) {
                    !(item.addr inside {[ranges[i].min:ranges[i].max - item.size + 1]});
                }
            }
        }

        function new(bit inside = 1);
            this.m_inside = inside;
        endfunction

        function void add(addr_t min, addr_t max);
            addr_range rng = new(min, max);
            ranges.push_back(rng);
        endfunction
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
    class fixed_f2_policy extends LOCAL_POLICY_T;
        protected int m_fixed_value;

        constraint c_fixed_value {item.f2 == m_fixed_value;}

        function new(int value);
            this.m_fixed_value = value;
        endfunction
    endclass

    static function policy_base FIXED_F2(int value);
        fixed_f2_policy p = new(value);
        return p;
    endfunction
    `end_extended_policies
endclass


class addr_l3_txn extends addr_l2_txn;
    rand int f3;

    `start_extended_policies(addr_l3_txn, addr_l2_txn)
    class fixed_f3_policy extends LOCAL_POLICY_T;
        protected int m_fixed_value;

        constraint c_fixed_value {item.f3 == m_fixed_value;}

        function new(int value);
            this.m_fixed_value = value;
        endfunction
    endclass

    static function policy_base FIXED_F3(int value);
        fixed_f3_policy p = new(value);
        return p;
    endfunction
    `end_extended_policies
endclass


class addr_l4_txn extends addr_l3_txn;
    rand int f4;

    `start_extended_policies(addr_l4_txn, addr_l3_txn)
    class fixed_f4_policy extends LOCAL_POLICY_T;
        protected int m_fixed_value;

        constraint c_fixed_value {item.f4 == m_fixed_value;}

        function new(int value);
            this.m_fixed_value = value;
        endfunction
    endclass

    static function policy_base FIXED_F4(int value);
        fixed_f4_policy p = new(value);
        return p;
    endfunction
    `end_extended_policies
endclass


class addr_constrained_txn extends addr_l4_txn;
    function new;
        addr_permit_policy        permit = new;
        addr_prohibit_policy      prohibit = new;
        policy_list#(addr_constrained_txn) pcy = new;

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.add(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.add(prohibit);

        pcy.add(addr_constrained_txn::POLICIES::FIXED_F2('h12345678));
        pcy.add(addr_constrained_txn::POLICIES::FIXED_F3('h55555555));
        pcy.add(addr_constrained_txn::POLICIES::FIXED_F4('h87654321));

        this.policy_l1 = {pcy_l1};
    endfunction
endclass