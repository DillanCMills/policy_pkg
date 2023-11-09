`ifndef __POLICY_PKG__
`define __POLICY_PKG__

`include "uvm_macros.svh"

package policy_pkg;

    import uvm_pkg::*;

    `include "policy.svh"
    
    typedef policy POLICY_QUEUE[$];
    
    `include "policy_container.svh"
    
    `include "policy_imp.svh"
    `include "policy_list.svh"

endpackage: policy_pkg

`endif
