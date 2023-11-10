class addr_txn extends uvm_object;
    rand bit [31:0]   addr;
    rand int          size;
    rand policy_queue policy;

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction

    class POLICIES;
        class addr_policy extends policy_imp#(addr_txn);
            addr_range ranges[$];

            function void add(addr_t min, addr_t max);
                addr_range rng = new(min, max);
                ranges.push_back(rng);
            endfunction
        endclass


        class addr_permit_policy extends addr_policy;
            rand int selection;

            constraint c_addr_permit {
                m_item != null -> (
                    selection inside {[0:ranges.size()-1]};

                    foreach(ranges[i]) {
                        if(selection == i) {
                            m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size]};
                        }
                    }
                )
            }
        endclass


        class addr_prohibit_policy extends addr_policy;
            constraint c_addr_prohibit {
                m_item != null -> (
                    foreach(ranges[i]) {
                        !(m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size + 1]});
                    }
                )
            }
        endclass
    endclass: POLICIES
endclass


class addr_p_txn extends addr_txn;
    rand bit parity;

    constraint c_parity {parity == $countones(addr) % 2;}

    class POLICIES extends addr_txn::POLICIES;
        class addr_parity_policy extends policy_imp#(addr_p_txn);
            protected bit parity;

            constraint c_fixed_value {m_item != null -> m_item.parity == parity;}

            function new(int parity);
                this.parity = parity;
            endfunction
        endclass

        static function addr_parity_policy FIXED_PARITY(bit value);
            FIXED_PARITY = new(value);
        endfunction 
    endclass: POLICIES
endclass


class addr_constrained_txn extends addr_p_txn;
    function new;
        policy_queue pcy;

        addr_constrained_txn::POLICIES::addr_permit_policy   permit   = new();
        addr_constrained_txn::POLICIES::addr_prohibit_policy prohibit = new();

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.push_back(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.push_back(prohibit);
        
        pcy.push_back(addr_constrained_txn::POLICIES::FIXED_PARITY(1'b1));

        this.policy = {pcy};
    endfunction
endclass