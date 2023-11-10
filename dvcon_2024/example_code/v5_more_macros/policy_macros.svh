`define start_policies(cls)                           \
class POLICIES;                                       \
`LOCAL_POLICY_IMP(cls)

`define start_extended_policies(cls, parent)          \
class POLICIES extends parent::POLICIES;              \
`LOCAL_POLICY_IMP(cls)

`define end_policies                                  \
endclass: POLICIES

`define LOCAL_POLICY_IMP(cls)                         \
    typedef policy_base#(cls) LOCAL_POLICY_T;


// Fixed-value policy class and constructor macro
`define fixed_policy(POLICY, TYPE, field)             \
`FIXED_POLICY_CLASS(POLICY, TYPE, field)              \
`FIXED_POLICY_CONSTRUCTOR(POLICY, TYPE, field)

`define FIXED_POLICY_CLASS(POLICY, TYPE, field)       \
    class POLICY``_policy extends LOCAL_POLICY_T;     \
        protected TYPE m_fixed_value;                 \
                                                      \
        constraint c_fixed_value {                    \
            item.field == m_fixed_value;              \
        }                                             \
                                                      \
        function new(TYPE value);                     \
            this.m_fixed_value = value;               \
        endfunction                                   \
    endclass: POLICY``_policy

`define FIXED_POLICY_CONSTRUCTOR(POLICY, TYPE, field) \
    static function policy_base POLICY(TYPE value);   \
        POLICY``_policy policy = new(value);          \
        return policy;                                \
    endfunction: POLICY                               \
    POLICY``_policy m_policy;

