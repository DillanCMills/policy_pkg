interface class policy;
    pure virtual function void set_item(uvm_object item);
endclass


virtual class policy_imp#(type ITEM=uvm_object) implements policy;

    protected rand ITEM m_item;

    virtual function void set_item(uvm_object item);
        if (!$cast(m_item, item)) begin
            `uvm_warning("policy::set_item()", "Item is not compatible with policy type")
            this.m_item = null;
            this.m_item.rand_mode(0);
        end
    endfunction: set_item
endclass: policy_imp


typedef policy policy_queue[$];