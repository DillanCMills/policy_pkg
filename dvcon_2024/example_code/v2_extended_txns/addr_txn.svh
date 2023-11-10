class addr_l1_txn;
  rand bit [31:0] addr;
  rand int        size;
  rand policy_base#(addr_l1_txn) policy_l1[$];

  constraint c_size {size inside {1, 2, 4};}

  function void pre_randomize;
    foreach(policy_l1[i]) policy_l1[i].set_item(this);
  endfunction
endclass


class addr_l2_txn extends addr_l1_txn;
  rand int f2;
  rand policy_base#(addr_l2_txn) policy_l2[$];

  function void pre_randomize;
    super.pre_randomize();
    foreach(policy_l2[i]) policy_l2[i].set_item(this);
  endfunction
endclass


class addr_constrained_txn extends addr_l4_txn;
  function new;
    addr_permit_policy        permit = new;
    addr_prohibit_policy      prohibit = new;
    addr_l2_policy            l2 = new;
    policy_list#(addr_l1_txn) pcy_l1 = new;
    policy_list#(addr_l2_txn) pcy_l2 = new;

    permit.add('h00000000, 'h0000FFFF);
    permit.add('h10000000, 'h1FFFFFFF);
    pcy_l1.add(permit);

    prohibit.add('h13000000, 'h130FFFFF);
    pcy_l1.add(prohibit);
    
    l2.set('h12345678);
    pcy_l2.add(l2);

    this.policy_l1 = {pcy_l1};
    this.policy_l2 = {pcy_l2};
  endfunction
endclass