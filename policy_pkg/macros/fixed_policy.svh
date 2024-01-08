`ifndef __FIXED_POLICY__
`define __FIXED_POLICY__

// Full policy definition
`define fixed_policy(POLICY, FIELD, TYPE, RADIX="%0p")                        \
`m_fixed_policy_class(POLICY, FIELD, TYPE, RADIX)                             \
`m_fixed_policy_constructor(POLICY, TYPE, RADIX)

// Policy class definition
`define m_fixed_policy_class(POLICY, FIELD, TYPE, RADIX="%0p")                \
    class POLICY``_policy extends base_policy                                 \
        local TYPE          l_val;                                            \
        local string        l_radix=RADIX;                                    \
                                                                              \
        constraint c_policy_constraint {                                      \
            (m_item != null) -> (m_item.FIELD == TYPE'(l_val));               \
        }                                                                     \
                                                                              \
        function new(TYPE value, string radix=RADIX);                         \
            this.set_value(value);                                            \
            this.set_radix(radix);                                            \
        endfunction: new                                                      \
                                                                              \
        virtual function string name();                                       \
            return (`"POLICY`");                                              \
        endfunction: name                                                     \
                                                                              \
        virtual function string description();                                \
            return ({                                                         \
                `"(FIELD==",                                                  \
                $sformatf(l_radix, l_val),                                    \
                `")`"                                                         \
            });                                                               \
        endfunction: description                                              \
                                                                              \
        virtual function policy copy();                                       \
            copy = new(l_val, l_radix);                                       \
        endfunction: copy                                                     \
                                                                              \
        virtual function void set_value(TYPE value);                          \
            this.l_val = value;                                               \
        endfunction: set_value                                                \
                                                                              \
        virtual function TYPE get_value();                                    \
            return (this.l_val);                                              \
        endfunction: get_value                                                \
                                                                              \
        virtual function void set_radix(string radix);                        \
            this.l_radix = radix;                                             \
        endfunction: set_radix                                                \
                                                                              \
        virtual function string get_radix();                                  \
            return (this.l_radix);                                            \
        endfunction: get_radix                                                \
    endclass: POLICY``_policy

// Policy constructor definition
`define m_fixed_policy_constructor(POLICY, TYPE, RADIX="%0p")                 \
    static function POLICY``_policy POLICY(TYPE value, string radix=RADIX);   \
        POLICY = new(value, radix);                                           \
    endfunction: POLICY

`endif 
