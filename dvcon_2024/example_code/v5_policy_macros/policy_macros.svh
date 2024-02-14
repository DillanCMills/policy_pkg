// Fixed-value policy class and constructor macro
`define fixed_policy(POLICY, FIELD, TYPE)                                     \
`m_fixed_policy_class(POLICY, FIELD, TYPE)                                    \
`m_fixed_policy_constructor(POLICY, TYPE)

`define m_fixed_policy_class(POLICY, FIELD, TYPE)                             \
    class POLICY``_policy extends base_policy;                                \
        constraint c_fixed_value {                                            \
            (m_item != null) -> (m_item.FIELD == l_val);                      \
        }                                                                     \
                                                                              \
        function new(TYPE value);                                             \
            this.l_val = value;                                               \
        endfunction                                                           \
    endclass: POLICY``_policy

`define m_fixed_policy_constructor(POLICY, TYPE)                              \
    static function POLICY``_policy POLICY(TYPE value);                       \
        POLICY = new(value);                                                  \
    endfunction: POLICY
