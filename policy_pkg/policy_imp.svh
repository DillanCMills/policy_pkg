`ifndef __POLICY_IMP__
`define __POLICY_IMP__

class policy_imp #(type ITEM=uvm_object) implements policy;

    ITEM item;

    virtual function string name();
        return ($typename(this));
    endfunction: name

    virtual function string type_name();
    endfunction: type_name

    virtual function string description();
    endfunction: description

    virtual function bit item_is_compatible(uvm_object item);
    endfunction: item_is_compatible

    virtual function void set_item(uvm_object item);

        if (item == null)
            `uvm_fatal("policy::set_item()", "NULL item passed")

        else if (!$cast(this.item, item))
            `uvm_warning("policy::set_item()", $sformatf("Item type <%s> is not compatible with policy type <%s>", item.get_type_name(), $typename(this.item)))

    endfunction: set_item

    virtual function policy copy();
    endfunction: copy

endclass: policy_imp

`endif
