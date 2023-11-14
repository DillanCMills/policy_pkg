`ifndef __FIXED_POLICY__
`define __FIXED_POLICY__

// Full policy definition
`define fixed_policy(POLICY, TYPE, field, RADIX="%0p")                        \
`m_fixed_policy_class(POLICY, TYPE, field, RADIX)                             \
`m_fixed_policy_constructor(POLICY, TYPE, RADIX)

// Policy class definition
`define m_fixed_policy_class(POLICY, TYPE, field, RADIX="%0p")                \
    class POLICY``_policy extends base_policy                                 \
        typedef TYPE        l_field_t;                                        \
                                                                              \
        protected TYPE      m_fixed_value;                                    \
        protected string    m_radix=RADIX;                                    \
                                                                              \
        constraint c_fixed_value {                                            \
            (item != null) -> (item.field == l_field_t'(m_fixed_value));      \
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
                `"(field==",                                                  \
                $sformatf(m_radix, m_fixed_value),                            \
                `")`"                                                         \
            });                                                               \
        endfunction: description                                              \
                                                                              \
        virtual function policy copy();                                       \
            copy = new(m_fixed_value, m_radix);                               \
        endfunction: copy                                                     \
                                                                              \
        virtual function void set_value(TYPE value);                          \
            this.m_fixed_value = value;                                       \
        endfunction: set_value                                                \
                                                                              \
        virtual function TYPE get_value();                                    \
            return (this.m_fixed_value);                                      \
        endfunction: get_value                                                \
                                                                              \
        virtual function void set_radix(string radix);                        \
            this.m_radix = radix;                                             \
        endfunction: set_radix                                                \
                                                                              \
        virtual function string get_radix();                                  \
            return (this.m_radix);                                            \
        endfunction: get_radix                                                \
    endclass: POLICY``_policy

// Policy constructor definition
`define m_fixed_policy_constructor(POLICY, TYPE, RADIX="%0p")                 \
    static function POLICY``_policy POLICY(TYPE value, string radix=RADIX);   \
        POLICY = new(value, radix);                                           \
    endfunction: POLICY

`endif 
