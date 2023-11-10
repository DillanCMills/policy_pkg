typedef bit [31:0] addr_t;

class addr_range extends uvm_object;
  addr_t min;
  addr_t max;
  
  function new(addr_t min, addr_t max);
    this.min = min;
    this.max = max;
  endfunction
endclass

typedef class addr_txn;