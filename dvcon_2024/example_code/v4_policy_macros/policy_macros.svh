`define start_policies(cls)                     \
class POLICIES;                                 \
`LOCAL_POLICY_IMP(cls)

`define start_extended_policies(cls, parent)    \
class POLICIES extends parent::POLICIES;        \
`LOCAL_POLICY_IMP(cls)

`define end_policies                            \
endclass: POLICIES

`define LOCAL_POLICY_IMP(cls)                   \
    typedef policy_base#(cls) LOCAL_POLICY_T;
