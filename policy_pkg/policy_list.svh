`ifndef __POLICE_LIST__
`define __POLICE_LIST__

class policy_list implements policy;

    rand POLICY_QUEUE list;

    function new(POLICY_QUEUE policy_queue={});
        list = policy_queue;
    endfunction: new

    virtual function string name();
        int unsigned list_size;
        int unsigned last_idx;
        string       s;

        list_size = list.size();
        last_idx  = ((list_size) ? (list_size - 1) : 0);

        foreach(list[idx]) s = {s, list[idx].name(), ((idx == last_idx) ? "" : ", ")};

        return ({"{", s, "}"});
    endfunction: name

    virtual function void set_item(uvm_object item);
        foreach(list[idx]) list[idx].set_item(item);
    endfunction: set_item

    virtual function void add(policy pcy);
        list.push_back(pcy);
    endfunction: add

    virtual function void clear();
        list.delete();
    endfunction: clear

    virtual function int unsigned size();
        return (list.size());
    endfunction: size

endclass: policy_list

`endif
