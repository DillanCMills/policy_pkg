class addr_txn;
    rand bit [31:0] addr;
    rand int        size;
    rand policy_base#(addr_txn) policy[$];

    constraint c_size {size inside {1, 2, 4};}

    function void pre_randomize;
        foreach(policy[i]) policy[i].set_item(this);
    endfunction
endclass
