class addr_txn extends uvm_object;
    rand policy_queue policy;
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
        // only a single policy queue is necessary now
        policy_queue pcy;

        addr_permit_policy     permit_p   = new();
        addr_prohibit_policy   prohibit_p = new();
        addr_parity_err_policy parity_err_p;

        permit_p.add('h00000000, 'h0000FFFF);
        permit_p.add('h10000000, 'h1FFFFFFF);
        pcy.push_back(permit_p);

        prohibit_p.add('h13000000, 'h130FFFFF);
        pcy.push_back(prohibit_p);
        
        parity_err_p = new(1'b1);
        pcy.push_back(parity_err_p);

        this.policy = {pcy};
    endfunction
endclass