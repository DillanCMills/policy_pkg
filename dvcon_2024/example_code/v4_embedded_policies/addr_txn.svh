class addr_txn extends uvm_object;
    // class members, constraints, and pre_randomize unchanged from previous example

    class POLICIES;
        class addr_policy extends policy_imp#(addr_txn);
            // ... unchanged from previous standalone class example
        endclass

        class addr_permit_policy extends addr_policy;
            // ... unchanged from previous standalone class example
        endclass

        class addr_prohibit_p_policy extends addr_policy;
            // ... unchanged from previous standalone class example
        endclass
    endclass: POLICIES
endclass

class addr_p_txn extends addr_txn;
    // class members and constraints unchanged from previous example

    class POLICIES extends addr_txn::POLICIES;
        class addr_parity_err_policy extends policy_imp#(addr_p_txn);
            // ... unchanged from previous example
        endclass

        static function addr_parity_err_policy PARITY_ERR(bit value);
            PARITY_ERR = new(value);
        endfunction 
    endclass: POLICIES
endclass

class addr_constrained_txn extends addr_p_txn;
    function new;
        policy_queue pcy;

        addr_constrained_txn::POLICIES::addr_permit_policy   permit_p   = new();
        addr_constrained_txn::POLICIES::addr_prohibit_policy prohibit_p = new();

        // policy constraint value setup unchanged from previous example
        
        pcy.push_back(addr_constrained_txn::POLICIES::PARITY_ERR(1'b1));

        this.policy = {pcy};
    endfunction
endclass