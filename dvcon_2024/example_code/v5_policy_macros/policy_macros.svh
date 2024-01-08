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
    endfunction: POLICY
