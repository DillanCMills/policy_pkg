`ifndef __CONSTANT_POLICY__
`define __CONSTANT_POLICY__

// Full policy definition
`define constant_policy(POLICY, TYPE, field, constant)                        \
`CONST_POLICY_CLASS(POLICY, TYPE, field, constant)                            \
`CONST_POLICY_CONSTRUCTOR(POLICY)

// Policy class definition
`define CONST_POLICY_CLASS(POLICY, TYPE, field, constant)                     \
    class POLICY``_policy extends base_policy                                 \
        typedef TYPE l_field_t;                                               \
                                                                              \
        virtual function string name();                                       \
            return (`"POLICY`");                                              \
        endfunction: name                                                     \
                                                                              \
        virtual function string description();                                \
            return (`"(field==constant)`");                                   \
        endfunction: description                                              \
                                                                              \
        virtual function policy copy();                                       \
            copy = new();                                                     \
        endfunction: copy                                                     \
                                                                              \
        constraint c_const_value {                                            \
            (item != null) -> (item.field == l_field_t'(constant));           \
        }                                                                     \
                                                                              \
        function new();                                                       \
        endfunction: new                                                      \
    endclass: POLICY``_policy

// Policy constructor definition
`define CONST_POLICY_CONSTRUCTOR(POLICY)                                      \
    static function POLICY``_policy POLICY();                                 \
        POLICY = new();                                                       \
    endfunction: POLICY

`endif 
