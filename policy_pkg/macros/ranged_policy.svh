`ifndef __RANGED_POLICY__
`define __RANGED_POLICY__

// Full policy definition
`define ranged_policy(POLICY, TYPE, field, RADIX="%0p")                       \
`RANGED_POLICY_CLASS(POLICY, TYPE, field, RADIX)                              \
`RANGED_POLICY_CONSTRUCTOR(POLICY, TYPE, RADIX)

// Policy class definition
`define RANGED_POLICY_CLASS(POLICY, TYPE, field, RADIX="%0p")                 \
    class POLICY``_policy extends LOCAL_POLICY_T                              \
        typedef TYPE        l_field_t;                                        \
                                                                              \
        protected TYPE      m_low;                                            \
        protected TYPE      m_high;                                           \
        protected bit       m_inside;                                         \
        protected string    m_radix=RADIX;                                    \
                                                                              \
        constrant c_ranged_value {                                            \
            (item != null) ->                                                 \
                ((!m_inside) ^ (item >= m_low && item <= m_high));            \
        }                                                                     \
                                                                              \
        function new(                                                         \
            TYPE   low,                                                       \
            TYPE   high=low,                                                  \
            bit    inside=1'b1,                                               \
            string radix=RADIX                                                \
        );                                                                    \
            this.set_range(low, high);                                        \
            this.set_inside(inside);                                          \
            this.set_radix(radix);                                            \
        endfunction: new                                                      \
                                                                              \
        virtual function string name();                                       \
            return ({                                                         \
                `"POLICY(field ",                                             \
                m_inside ? "inside [" : "outside [",                          \
                $sformatf(m_radix, m_low),                                    \
                ", ",                                                         \
                $sformatf(m_radix, m_high),                                   \
                `"])`"                                                        \
            });                                                               \
        endfunction: name                                                     \
                                                                              \
        virtual function void set_range(TYPE low, TYPE high);                 \
            if (low <= high) begin                                            \
                this.m_low = low;                                             \
                this.m_high = high;                                           \
            end else begin                                                    \
                this.m_low = high;                                            \
                this.m_high = low;                                            \
            end                                                               \
        endfunction: set_range                                                \
                                                                              \
        virtual function TYPE get_low();                                      \
            return (this.m_low);                                              \
        endfunction: get_low                                                  \
                                                                              \
        virtual function TYPE get_high();                                     \
            return (this.m_high);                                             \
        endfunction: get_high                                                 \
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
`define RANGED_POLICY_CONSTRUCTOR(POLICY, TYPE, RADIX="%0p")                  \
    static function policy POLICY(                                            \
        TYPE   low,                                                           \
        TYPE   high=low,                                                      \
        bit    inside=1'b1,                                                   \
        string radix=RADIX                                                    \
    );                                                                        \
        POLICY``_policy new_pcy = new(low, high, inside, radix);              \
        return (new_pcy);                                                     \
    endfunction: POLICY

`endif
