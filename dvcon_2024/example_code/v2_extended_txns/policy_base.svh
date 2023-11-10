class policy_base#(type ITEM=uvm_object);
    ITEM item;

    virtual function void set_item(ITEM item);
        this.item = item;
    endfunction
endclass


class policy_list#(type ITEM=uvm_object) extends policy_base#(ITEM);
    rand policy_base#(ITEM) policy[$];

    function void add(policy_base#(ITEM) pcy);
        policy.push_back(pcy);
    endfunction

    function void set_item(ITEM item);
        foreach(policy[i]) policy[i].set_item(item);
    endfunction
endclass