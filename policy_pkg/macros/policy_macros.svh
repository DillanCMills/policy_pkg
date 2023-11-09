`ifndef __POLICY_MACROS__
`define __POLICY_MACROS__

//================================================
// Embedded POLICIES class macros
//================================================

`define start_policies(cls)                     \
class POLICIES;                                 \
`LOCAL_POLICY_IMP(cls)

`define start_extended_policies(cls, parent)    \
class POLICIES extends parent::POLICIES;        \
`LOCAL_POLICY_IMP(cls)

`define end_policies                            \
endclass: POLICIES

`define LOCAL_POLICY_IMP(cls)                   \
    typedef policy_imp#(cls) LOCAL_POLICY_T;


//================================================
// Policy template macros
//================================================

`include "constant_policy.svh"
`include "fixed_policy.svh"
`include "ranged_policy.svh"
`include "set_policy.svh"

`endif