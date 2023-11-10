class addr_l1_policy extends policy_base#(addr_l1_txn);
  addr_range ranges[$];

  function void add(addr_t min, addr_t max);
    addr_range rng = new(min, max);
    ranges.push_back(rng);
  endfunction
endclass


class addr_l2_policy extends addr_l1_policy;
  int f2;
  
  function void set(int f2);
    this.f2 = f2;
  endfunction
  
  constraint c_f2 {
    item.f2 == f2;
  }
endclass


class addr_l3_policy extends addr_l2_policy;
  int f3;
  
  function void set(int f3);
    this.f3 = f3;
  endfunction
  
  constraint c_f3 {
    item.f3 == f3;
  }
endclass


class addr_l4_policy extends addr_l3_policy;
  int f4;
  
  function void set(int f4);
    this.f4 = f4;
  endfunction
  
  constraint c_f4 {
    item.f4 == f4;
  }
endclass


class addr_permit_policy extends addr_l1_policy;
  rand int selection;

  constraint c_addr_permit {
    selection inside {[0:ranges.size()-1]};

    foreach(ranges[i]) {
      if(selection == i) {
        item.addr inside {[ranges[i].min:ranges[i].max - item.size]};
      }
    }
    }
endclass


class addr_prohibit_policy extends addr_l1_policy;
  constraint c_addr_prohibit {
    foreach(ranges[i]) {
      !(item.addr inside {[ranges[i].min:ranges[i].max - item.size + 1]});
    }
  }
endclass