virtual class policy_imp #(type ITEM=uvm_object) implements policy;

    protected rand ITEM m_item;

    pure virtual function string name();
    pure virtual function string description();
    pure virtual function policy copy();

    virtual function string type_name();
        return (ITEM::type_name);
    endfunction: type_name

    virtual function bit item_is_compatible(uvm_object item);
        ITEM local_item;

        return ((item != null) && ($cast(local_item, item)));
    endfunction: item_is_compatible

    virtual function void set_item(uvm_object item);
        if (item == null)
            `uvm_error("policy::set_item()", "NULL item passed")

        else if ((this.item_is_compatible(item)) && $cast(this.m_item, item)) begin
            `uvm_info(
                "policy::set_item()",
                $sformatf(
                    "policy <%s> applied to item <%s>: %s",
                    this.name(), item.get_name(), this.description()
                ),
                UVM_FULL
            )
            this.m_item.rand_mode( 1 );

        end else begin
            `uvm_warning(
                "policy::set_item()",
                $sformatf(
                    "Cannot apply policy '%0s' of type '%0s' to target object '%0s' of incompatible type '%0s'",
                    this.name(), this.type_name(), item.get_name(), item.get_type_name()
                )
            )
            this.m_item = null;
            this.m_item.rand_mode( 0 );
        end
    endfunction: set_item

endclass: policy_imp