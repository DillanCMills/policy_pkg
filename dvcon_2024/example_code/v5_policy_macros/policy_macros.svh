// Create a base embedded POLICIES class
`define start_policies(cls)                                                   \
class POLICIES;                                                               \
`m_base_policy(cls)

// Create a child embedded POLICIES class
`define start_extended_policies(cls, parent)                                  \
class POLICIES extends parent::POLICIES;                                      \
`m_base_policy(cls)

// End the embedded POLICIES class
`define end_policies                                                          \
endclass: POLICIES

// Create the base policy type
`define m_base_policy(cls)                                                    \
    typedef policy_imp#(cls) base_policy;


// Fixed-value policy class and constructor macro
`define fixed_policy(POLICY, TYPE, field)                                     \
`m_fixed_policy_class(POLICY, TYPE, field)                                    \
`m_fixed_policy_constructor(POLICY, TYPE, field)

`define m_fixed_policy_class(POLICY, TYPE, field)                             \
    class POLICY``_policy extends base_policy;                                \
        protected TYPE m_fixed_value;                                         \
                                                                              \
        constraint c_fixed_value {                                            \
            m_item != null -> m_item.field == m_fixed_value;                  \
        }                                                                     \
                                                                              \
        function new(TYPE value);                                             \
            this.m_fixed_value = value;                                       \
        endfunction                                                           \
    endclass: POLICY``_policy

`define m_fixed_policy_constructor(POLICY, TYPE, field)                       \
    static function POLICY``_policy POLICY(TYPE value);                       \
        POLICY = new(value);                                                  \
    endfunction: POLICY                                                       \
