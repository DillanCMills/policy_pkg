class addr_policy extends policy_imp#(addr_txn);
   // ... unchanged from previous example, with updated class extension
endclass

class addr_parity_err_policy extends policy_imp#(addr_p_txn);
   protected bit parity_err;

   constraint c_fixed_value {m_item != null -> m_item.parity_err == parity_err;}

   function new(bit parity_err);
      this.parity_err = parity_err;
   endfunction
endclass

class addr_permit_policy extends addr_policy;
   // same as before
endclass

class addr_prohibit_policy extends addr_policy;
   // same as before
endclass
