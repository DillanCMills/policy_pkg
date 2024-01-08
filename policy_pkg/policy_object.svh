class policy_object #(type BASE=uvm_object) extends BASE implements policy_container;

    protected policy_queue m_policies;
  
    // Queries
    virtual function bit has_policies();
        return( this.m_policies.size() > 0 );
    endfunction: has_policies

    // Assignments
    virtual function void set_policies(policy_queue policies);
        if( this.has_policies()) begin
            `uvm_warning( "policy", "set_policies() replacing existing policies" )
        end
        this.m_policies = {};
        foreach( policies(i) ) try_add_policy( policies[i] );
    endfunction: set_policies

    virtual function void add_policies(policy_queue policies);
        foreach( policies(i) ) try_add_policy( policies[i] );
    endfunction: add_policies

    virtual function void clear_policies();
        if ( this.has_policies() ) begin
            `uvm_info( "policy", $sformatf("clearing [%0d] policies from %s", this.m_policies.size(), this.get_name()), UVM_FULL)
        end
        this.m_policies = {};
    endfunction: clear_policies

    // Access
    virtual function policy_queue get_policies();
        return( this.m_policies );
    endfunction: get_policies

    // Copy
    virtual function policy_queue copy_policies();
        copy_policies = {};
        foreach( this.m_policies[i] ) begin
            copy_policies.push_back( this.m_policies[i].copy() );
        end
    endfunction: copy_policies

    protected function void try_add_policy( policy new_policy );
        if (new_policy.item_is_compatible(this)) begin
            `uvm_info( "policy", $sformatf("adding policy %s to %s", new_policy.name, this.get_name()), UVM_FULL)
            new_policy.set_item( this );
            this.m_policies.push_back( new_policy );
        end else begin
            `uvm_warning( "policy", $sformatf("policy %s not compatible with target %s", new_policy.name, this.get_name()))
        end
    endfunction: try_add_policy
endclass: policy_object