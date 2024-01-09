class addr_txn;
    rand bit [31:0] addr;
    rand int        size;
    rand policy_base#(addr_txn) policy[$];

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction
endclass

class addr_policy_base extends policy_base#(addr_txn);
    addr_range ranges[$];

    function void add(addr_t min, addr_t max);
        addr_range rng = new(min, max);
        ranges.push_back(rng);
    endfunction
endclass

class addr_permit_policy extends addr_policy_base;
    rand int selection;

    constraint c_addr_permit {
        selection inside {[0:ranges.size()-1]};

        foreach(ranges[i]) {
            if(selection == i) {
                item.addr inside {[ranges[i].min:ranges[i].max - item.size]};
            }
        }
    }
endclass

class addr_prohibit_policy extends addr_policy_base;
    constraint c_addr_prohibit {
        foreach(ranges[i]) {
            !(item.addr inside {[ranges[i].min:ranges[i].max - item.size + 1]});
        }
    }
endclass