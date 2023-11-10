class addr_txn;
  rand bit [31:0] addr;
  rand int        size;
  rand policy_base#(addr_txn) addr_policy[$];

  constraint c_size {size inside {1, 2, 4};}

  function void pre_randomize;
    foreach(addr_policy[i]) addr_policy[i].set_item(this);
  endfunction
endclass


class addr_p_txn extends addr_txn;
  rand bit parity;
  rand policy_base#(addr_p_txn) addr_p_policy[$];

  constraint c_parity {parity == $countones(addr) % 2;}

  function void pre_randomize;
    super.pre_randomize();
    foreach(addr_p_policy[i]) addr_p_policy[i].set_item(this);
  endfunction
endclass


class addr_constrained_txn extends addr_p_txn;
  function new;
    addr_permit_policy        permit = new;
    addr_prohibit_policy      prohibit = new;
    addr_parity_policy        parity = new;
    policy_list#(addr_txn)    addr_pcy = new;
    policy_list#(addr_p_txn)  addr_p_pcy = new;

    permit.add('h00000000, 'h0000FFFF);
    permit.add('h10000000, 'h1FFFFFFF);
    addr_pcy.add(permit);

    prohibit.add('h13000000, 'h130FFFFF);
    addr_pcy.add(prohibit);
    
    parity.set(1'b1);
    addr_p_pcy.add(parity);

    this.addr_policy   = {addr_pcy};
    this.addr_p_policy = {addr_p_pcy};
  endfunction
endclass