class addr_policy extends policy_imp#(addr_txn);
   addr_range ranges[$];

   function void add(addr_t min, addr_t max);
      addr_range rng = new(min, max);
      ranges.push_back(rng);
   endfunction
endclass

class addr_parity_err_policy extends policy_imp#(addr_p_txn);
   protected bit parity_err;

   constraint c_fixed_value {m_item != null -> m_item.parity_err == parity_err;}

   function new(int parity_err);
      this.parity_err = parity_err;
   endfunction
endclass

class addr_permit_policy extends addr_policy;
   rand int selection;

   constraint c_addr_permit {
      m_item != null -> (
         selection inside {[0:ranges.size()-1]};

         foreach(ranges[i]) {
            if(selection == i) {
               m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size]};
            }
         }
      )
   }
endclass

class addr_prohibit_policy extends addr_policy;
   constraint c_addr_prohibit {
      m_item != null -> (
         foreach(ranges[i]) {
            !(m_item.addr inside {[ranges[i].min:ranges[i].max - m_item.size + 1]});
         }
      )
   }
endclass
