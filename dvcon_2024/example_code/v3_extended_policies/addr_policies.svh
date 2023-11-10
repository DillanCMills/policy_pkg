class addr_l1_policy extends policy_imp#(addr_l1_txn);
    addr_range ranges[$];

    function void add(addr_t min, addr_t max);
        addr_range rng = new(min, max);
        ranges.push_back(rng);
    endfunction
endclass


class addr_l2_policy extends policy_imp#(addr_l2_txn);
    protected int f2;

    constraint c_fixed_value {m_item.f2 == f2;}

    function new(int value);
        this.f2 = value;
    endfunction
endclass


class addr_permit_policy extends addr_l1_policy;
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


class addr_prohibit_policy extends addr_l1_policy;
    constraint c_addr_prohibit {
        foreach(ranges[i]) {
            !(m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size + 1]});
        }
    }
endclass
