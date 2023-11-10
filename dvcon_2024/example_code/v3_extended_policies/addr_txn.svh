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
endclass


class addr_l3_txn extends addr_l2_txn;
  rand int f3;
endclass


class addr_l4_txn extends addr_l3_txn;
  rand int f4;
endclass


class addr_constrained_txn extends addr_l4_txn;
  function new;
    addr_permit_policy        permit = new;
    addr_prohibit_policy      prohibit = new;
    addr_l2_policy            l2 = new;
    addr_l3_policy            l3 = new;
    addr_l4_policy            l4 = new;
    policy_list#(addr_l1_txn) pcy_l1 = new;

    permit.add('h00000000, 'h0000FFFF);
    permit.add('h10000000, 'h1FFFFFFF);
    pcy_l1.add(permit);

    prohibit.add('h13000000, 'h130FFFFF);
    pcy_l1.add(prohibit);
    
    l2.set('h12345678);
    pcy_l1.add(l2);
    
    l3.set('h55555555);
    pcy_l1.add(l3);
    
    l4.set('h87654321);
    pcy_l1.add(l4);

    this.policy_l1 = {pcy_l1};
  endfunction
endclass