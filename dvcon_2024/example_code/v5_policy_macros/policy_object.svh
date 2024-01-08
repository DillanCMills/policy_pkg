class policy_object #(type BASE=uvm_object) extends BASE implements policy_container;

    protected policy_queue m_policies;
  
    // Queries
    virtual function bit has_policies();
        // returns true/false based on size of m_policies
    endfunction: has_policies

    // Assignments
    virtual function void set_policies(policy_queue policies);
        // sets m_policies to a new queue of policies
    endfunction: set_policies

    virtual function void add_policies(policy_queue policies);
        // adds new policies to m_policies
    endfunction: add_policies

    virtual function void clear_policies();
        // clears m_policies
    endfunction: clear_policies

    // Access
    virtual function policy_queue get_policies();
        // return a handle to m_policies
    endfunction: get_policies

    // Copy
    virtual function policy_queue copy_policies();
        // a copy of m_policies
    endfunction: copy_policies
endclass: policy_object