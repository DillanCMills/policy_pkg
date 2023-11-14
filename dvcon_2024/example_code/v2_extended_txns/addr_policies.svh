class addr_policy_base extends policy_base#(addr_txn);
  addr_range ranges[$];

  function void add(addr_t min, addr_t max);
    addr_range rng = new(min, max);
    ranges.push_back(rng);
  endfunction
endclass

class addr_parity_err_policy extends policy_base#(addr_p_txn);
  bit parity_err;
  
  function void set(bit parity_err);
    this.parity_err = parity_err;
  endfunction
  
  constraint c_fixed_value {
    item.parity_err == parity_err;
  }
endclass

class addr_permit_policy extends addr_policy_base;
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

class addr_prohibit_policy extends addr_policy_base;
  constraint c_addr_prohibit {
    foreach(ranges[i]) {
      !(item.addr inside {[ranges[i].min:ranges[i].max - item.size + 1]});
    }
  }
endclass