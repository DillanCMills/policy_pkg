`ifndef __POLICY_CONTAINER__
`define __POLICY_CONTAINER__

interface class policy_container;

    // Queries
    pure virtual function bit has_policies();

    // Assignments
    pure virtual function void set_policies(policy_queue policies);

    pure virtual function void add_policies(policy_queue policies);

    pure virtual function void clear_policies();

    // Access
    pure virtual function policy_queue get_policies();

    // Copy
    pure virtual function policy_queue copy_policies();

endclass: policy_container

`endif
