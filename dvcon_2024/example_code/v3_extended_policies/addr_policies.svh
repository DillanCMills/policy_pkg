class addr_policy extends policy_imp#(addr_txn);
   addr_range ranges[$];

   function void add(addr_t min, addr_t max);
      addr_range rng = new(min, max);
      ranges.push_back(rng);
   endfunction
endclass

class addr_parity_policy extends policy_imp#(addr_p_txn);
   protected bit parity;

   constraint c_fixed_value {m_item != null -> m_item.parity == parity;}

   function new(int parity);
      this.parity = parity;
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
