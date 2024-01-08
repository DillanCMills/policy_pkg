// Full policy definition
`define member_policy(POLICY, FIELD, TYPE, RADIX="%0p")                       \
`m_member_policy_class(POLICY, FIELD, TYPE, RADIX)                            \
`m_member_policy_constructor(POLICY, TYPE, RADIX)

// Policy class definition
`define m_member_policy_class(POLICY, FIELD, TYPE, RADIX="%0p")               \
    class POLICY``_policy extends base_policy                                 \
        typedef TYPE            l_field_array_t[];                            \
                                                                              \
        local l_field_array_t   m_values;                                     \
        local bit               l_exclude;                                    \
        local string            m_radix=RADIX;                                \
                                                                              \
        constrant c_policy_constraint {                                       \
            (m_item != null) ->                                               \
                ((l_exclude) ^ (m_item.FIELD inside {m_values}));             \
        }                                                                     \
                                                                              \
        function new(                                                         \
            l_field_array_t values,                                           \
            bit             exclude=1'b0,                                     \
            string          radix=RADIX                                       \
        );                                                                    \
            this.set_values(values);                                          \
            this.set_exclude(exclude);                                        \
            this.set_radix(radix);                                            \
        endfunction: new                                                      \
                                                                              \
        virtual function string name();                                       \
            return (`"POLICY`");                                              \
        endfunction: name                                                     \
                                                                              \
        virtual function string description();                                \
            string values_str = "";                                           \
                                                                              \
            foreach(m_values[i])                                              \
                values_str = {                                                \
                    values_str,                                               \
                    $sformatf(m_radix, m_values[i]),                          \
                    i == m_values.size()-1 ? "" : ", "};                      \
                                                                              \
            return ({                                                         \
                `"POLICY(FIELD ",                                             \
                l_exclude ? "outside {" : "inside {",                         \
                values_str,                                                   \
                `"})`"                                                        \
            });                                                               \
        endfunction: description                                              \
                                                                              \
        virtual function policy copy();                                       \
            copy = new(m_values, l_exclude, m_radix);                         \
        endfunction: copy                                                     \
                                                                              \
        virtual function void set_values(l_field_array_t values);             \
            this.m_values = values;                                           \
        endfunction: set_values                                               \
                                                                              \
        virtual function l_field_array_t get_values();                        \
            l_field_array_t l_array;                                          \
            foreach (this.m_values[i])                                        \
                l_array[i] = this.m_values[i];                                \
            return (l_array);                                                 \
        endfunction: get_values                                               \
                                                                              \
        virtual function void set_exclude(bit exclude);                       \
            this.l_exclude = exclude;                                         \
        endfunction: set_exclude                                              \
                                                                              \
        virtual function bit get_exclude();                                   \
            return (this.l_exclude);                                          \
        endfunction: get_exclude                                              \
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
`define m_member_policy_constructor(POLICY, TYPE, RADIX="%0p")                \
    typedef TYPE POLICY``_array_t[];                                          \
    static function POLICY``_policy POLICY(                                   \
        POLICY``_array_t values,                                              \
        bit              exclude=1'b0,                                        \
        string           radix=RADIX                                          \
    );                                                                        \
        POLICY = new(values, exclude, radix);                                 \
    endfunction: POLICY