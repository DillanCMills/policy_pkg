class addr_l1_policy;
  // typedef policy_base#(addr_l1_txn) LOCAL_POLICY_T;
  addr_range ranges[$];

  function void add(addr_t min, addr_t max);
    addr_range rng = new(min, max);
    ranges.push_back(rng);
  endfunction
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