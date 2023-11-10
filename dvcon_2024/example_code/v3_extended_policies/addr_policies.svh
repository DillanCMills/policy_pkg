class addr_l1_policy;
    typedef policy_imp#(addr_l1_txn) base_policy;

    class addr_range_policy_base extends base_policy;
        addr_range ranges[$];

        function void add(addr_t min, addr_t max);
            addr_range rng = new(min, max);
            ranges.push_back(rng);
        endfunction
    endclass
endclass


class addr_l2_policy extends addr_l1_policy;
    typedef policy_imp#(addr_l2_txn) base_policy;

    class fixed_f2_policy extends base_policy;
        protected int f2;

        constraint c_fixed_value {m_item.f2 == f2;}

        function new(int value);
            this.f2 = value;
        endfunction
    endclass

    static function policy FIXED_F2(int value);
        fixed_f2_policy p = new(value);
        return p;
    endfunction
endclass


class addr_permit_policy extends addr_l1_policy;
    class addr_range_permit_policy extends addr_range_policy_base;
        rand int selection;

        constraint c_addr_permit {
            selection inside {[0:ranges.size()-1]};

            foreach(ranges[i]) {
                if(selection == i) {
                    m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size]};
                }
            }
        }
    endclass

    static function addr_range_permit_policy PERMIT();
        addr_range_permit_policy p = new();
        return p;
    endfunction
endclass


class addr_prohibit_policy extends addr_l1_policy;
    class addr_range_prohibit_policy extends addr_range_policy_base;
        constraint c_addr_prohibit {
            foreach(ranges[i]) {
                !(m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size + 1]});
            }
        }
    endclass

    static function addr_range_prohibit_policy PROHIBIT();
        addr_range_prohibit_policy p = new();
        return p;
    endfunction
endclass