interface class policy;

    pure virtual function string name();
    pure virtual function string type_name();
    pure virtual function string description();
    pure virtual function bit item_is_compatible(uvm_object item);
    pure virtual function void set_item(uvm_object item);
    pure virtual function policy copy();

endclass: policy