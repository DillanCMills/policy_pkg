class addr_txn extends uvm_object;
    rand policy_queue policies;
    // policy is replaced with the above. All other members, constraints, 
    // and pre_randomize are unchanged from the previous example
endclass

class addr_p_txn extends addr_txn;
    rand bit parity;
    rand bit parity_err;
    constraint c_parity_err {/*...*/}
    // The local addr_p_policy and pre_randomize are removed. Everything
    // else is unchanged from the previous example
endclass

class addr_constrained_txn extends addr_p_txn;
    function new;
        addr_permit_policy     permit_p   = new();
        addr_prohibit_policy   prohibit_p = new();
        addr_parity_err_policy parity_err_p;

        // only a single policy queue is necessary now
        permit_p.add('h00000000, 'h0000FFFF);
        permit_p.add('h10000000, 'h1FFFFFFF);
        this.policies.push_back(permit_p);

        prohibit_p.add('h13000000, 'h130FFFFF);
        this.policies.push_back(prohibit_p);
        
        parity_err_p = new(1'b1);
        this.policies.push_back(parity_err_p);
    endfunction
endclass