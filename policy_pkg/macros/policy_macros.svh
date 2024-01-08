`ifndef __POLICY_MACROS__
`define __POLICY_MACROS__

//================================================
// Embedded POLICIES class macros
//================================================

`define start_policies(cls)                                                   \
class POLICIES;                                                               \
`m_base_policy(cls)

`define start_extended_policies(cls, parent)                                  \
class POLICIES extends parent::POLICIES;                                      \
`m_base_policy(cls)

`define end_policies                                                          \
endclass: POLICIES

`define m_base_policy(cls)                                                    \
    typedef policy_imp#(cls) base_policy;


//================================================
// Policy template macros
//================================================

`include "constant_policy.svh"
`include "fixed_policy.svh"
`include "member_policy.svh"
`include "range_policy.svh"

`endif
