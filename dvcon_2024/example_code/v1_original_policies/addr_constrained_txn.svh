class addr_constrained_txn extends addr_txn;
    function new;
        addr_permit_policy     permit = new;
        addr_prohibit_policy   prohibit = new;
        policy_list#(addr_txn) pcy = new;

        permit.add('h00000000, 'h0000FFFF);
        permit.add('h10000000, 'h1FFFFFFF);
        pcy.add(permit);

        prohibit.add('h13000000, 'h130FFFFF);
        pcy.add(prohibit);

        this.policy = {pcy};
    endfunction
endclass
