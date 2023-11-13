`ifndef __SET_POLICY__
`define __SET_POLICY__

// Full policy definition
`define set_policy(POLICY, TYPE, field, RADIX="%0p")                          \
`SET_POLICY_CLASS(POLICY, TYPE, field, RADIX)                                 \
`SET_POLICY_CONSTRUCTOR(POLICY, TYPE, RADIX)

// Policy class definition
`define SET_POLICY_CLASS(POLICY, TYPE, field, RADIX="%0p")                    \
    class POLICY``_policy extends base_policy                                 \
        typedef TYPE        l_field_array_t[];                                \
                                                                              \
        protected l_field_array_t   m_values;                                 \
        protected bit               m_inside;                                 \
        protected string            m_radix=RADIX;                            \
                                                                              \
        constrant c_set_value {                                               \
            (item != null) ->                                                 \
                ((m_inside) ^ (item.field inside {m_values}));                \
        }                                                                     \
                                                                              \
        function new(                                                         \
            l_field_array_t values,                                           \
            bit             inside=1'b1,                                      \
            string          radix=RADIX                                       \
        );                                                                    \
            this.set_values(values);                                          \
            this.set_inside(inside);                                          \
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
                `"POLICY(field ",                                             \
                m_inside ? "inside {" : "outside {",                          \
                values_str,                                                   \
                `"})`"                                                        \
            });                                                               \
        endfunction: description                                              \
                                                                              \
        virtual function policy copy();                                       \
            copy = new(m_values, m_inside, m_radix);                          \
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
        virtual function void set_inside(bit inside);                         \
            this.m_inside = inside;                                           \
        endfunction: set_inside                                               \
                                                                              \
        virtual function bit get_inside();                                    \
            return (this.m_inside);                                           \
        endfunction: get_inside                                               \
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
`define SET_POLICY_CONSTRUCTOR(POLICY, TYPE, RADIX="%0p")                     \
    typedef TYPE POLICY``_array_t[];                                          \
    static function POLICY``_policy POLICY(                                   \
        POLICY``_array_t values,                                              \
        bit              inside=1'b1,                                         \
        string           radix=RADIX                                          \
    );                                                                        \
        POLICY = new(values, inside, radix);                                  \
    endfunction: POLICY

`endif
