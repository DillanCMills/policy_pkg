// Full policy definition
`define constant_policy(POLICY, FIELD, TYPE, CONST)                           \
`m_const_policy_class(POLICY, FIELD, TYPE, CONST)                             \
`m_const_policy_constructor(POLICY)

// Policy class definition
// Note - type casting within the constraint expression requires TYPE to be a 
// single keyword (e.g. int, addr_t), not a vector expression (e.g. bit [31:0])
`define m_const_policy_class(POLICY, FIELD, TYPE, CONST)                      \
    class POLICY``_policy extends base_policy;                                \
        constraint c_policy_constraint {                                      \
            (m_item != null) -> (m_item.FIELD == TYPE'(CONST));               \
        }                                                                     \
                                                                              \
        function new();                                                       \
        endfunction: new                                                      \
                                                                              \
        virtual function string name();                                       \
            return (`"POLICY`");                                              \
        endfunction: name                                                     \
                                                                              \
        virtual function string description();                                \
            return (`"(FIELD==CONST)`");                                      \
        endfunction: description                                              \
                                                                              \
        virtual function POLICY``_policy copy();                              \
            copy = new();                                                     \
        endfunction: copy                                                     \
    endclass: POLICY``_policy

// Policy constructor definition
`define m_const_policy_constructor(POLICY)                                    \
    static function POLICY``_policy POLICY();                                 \
        POLICY = new();                                                       \
    endfunction: POLICY