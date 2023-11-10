class addr_l1_txn extends uvm_object;
    rand bit [31:0]   addr;
    rand int          size;
    rand policy_queue policy;

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction

    class POLICIES;
        typedef policy_imp#(addr_l1_txn) base_policy;

        class addr_range_policy_base extends base_policy;
            addr_range ranges[$];

            function void add(addr_t min, addr_t max);
                addr_range rng = new(min, max);
                ranges.push_back(rng);
            endfunction
        endclass

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

        static function policy PERMIT();
            addr_range_permit_policy p = new();
            return p;
        endfunction

        class addr_range_prohibit_policy extends addr_range_policy_base;
            constraint c_addr_prohibit {
                foreach(ranges[i]) {
                    !(m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size + 1]});
                }
            }
        endclass

        static function policy PROHIBIT();
            addr_range_prohibit_policy p = new();
            return p;
        endfunction
    endclass: POLICIES
endclass


class addr_l2_txn extends addr_l1_txn;
    rand int f2;

    class POLICIES extends addr_l1_txn::POLICIES;
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
    endclass: POLICIES
endclass


class addr_constrained_txn extends addr_l2_txn;
    function new;
        policy_queue pcy;

        addr_constrained_txn::POLICIES::addr_range_permit_policy   permit   = addr_constrained_txn::POLICIES::PERMIT();
        addr_constrained_txn::POLICIES::addr_range_prohibit_policy prohibit = addr_constrained_txn::POLICIES::PROHIBIT();

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.push_back(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.push_back(prohibit);
        
        pcy.push_back(addr_constrained_txn::POLICIES::FIXED_F2('h12345678));

        this.policy = {pcy};
    endfunction
endclass