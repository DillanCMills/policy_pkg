class addr_txn;
  // ... unchanged from previous example
endclass

class addr_p_txn extends addr_txn;
  rand bit parity;
  rand bit parity_err;
  rand policy_base#(addr_p_txn) addr_p_policy[$];

  constraint c_parity_err {
    soft (parity_err == 0);
    (parity_err) ^ ($countones({addr, parity}) == 1);
  }

  function void pre_randomize;
    super.pre_randomize();
    foreach(addr_p_policy[i]) addr_p_policy[i].set_item(this);
  endfunction
endclass

class addr_constrained_txn extends addr_p_txn;
  function new;
    addr_permit_policy        permit_p = new;
    addr_prohibit_policy      prohibit_p = new;
    
    // definition to follow in a later example - constrains parity_err bit
    addr_parity_err_policy    parity_err_p = new;

    policy_list#(addr_txn)    addr_pcy_lst = new;
    policy_list#(addr_p_txn)  addr_p_pcy_lst = new;

    permit_p.add('h00000000, 'h0000FFFF);
    permit_p.add('h10000000, 'h1FFFFFFF);
    addr_pcy_lst.add(permit_p);

    prohibit_p.add('h13000000, 'h130FFFFF);
    addr_pcy_lst.add(prohibit_p);
    
    parity_err_p.set(1'b1);
    addr_p_pcy_lst.add(parity_err_p);

    this.addr_policy   = {addr_pcy_lst};
    this.addr_p_policy = {addr_p_pcy_lst};
  endfunction
endclass