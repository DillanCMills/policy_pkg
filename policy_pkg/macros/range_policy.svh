`ifndef __RANGE_POLICY__
`define __RANGE_POLICY__

// Full policy definition
`define range_policy(POLICY, FIELD, TYPE, RADIX="%0p")                        \
`m_range_policy_class(POLICY, FIELD, TYPE, RADIX)                             \
`m_range_policy_constructor(POLICY, TYPE, RADIX)

// Policy class definition
`define m_range_policy_class(POLICY, FIELD, TYPE, RADIX="%0p")                \
    class POLICY``_policy extends base_policy                                 \
        local TYPE          l_low;                                            \
        local TYPE          l_high;                                           \
        local bit           l_exclude;                                        \
        local string        l_radix=RADIX;                                    \
                                                                              \
        constrant c_policy_constraint {                                       \
            (m_item != null) -> (                                             \
                (l_exclude) ^                                                 \
                ((m_item.FIELD >= l_low && m_item.FIELD <= l_high))           \
            );                                                                \
        }                                                                     \
                                                                              \
        function new(                                                         \
            TYPE   low,                                                       \
            TYPE   high=low,                                                  \
            bit    exclude=1'b0,                                              \
            string radix=RADIX                                                \
        );                                                                    \
            this.set_range(low, high);                                        \
            this.set_exclude(exclude);                                        \
            this.set_radix(radix);                                            \
        endfunction: new                                                      \
                                                                              \
        virtual function string name();                                       \
            return (`"POLICY`");                                              \
        endfunction: name                                                     \
                                                                              \
        virtual function string description();                                \
            return ({                                                         \
                `"(FIELD ",                                                   \
                l_exclude ? "outside [" : "inside [",                         \
                $sformatf(l_radix, l_low),                                    \
                ", ",                                                         \
                $sformatf(l_radix, l_high),                                   \
                `"])`"                                                        \
            });                                                               \
        endfunction: description                                              \
                                                                              \
        virtual function policy copy();                                       \
            copy = new(l_low, l_high, l_exclude, l_radix);                    \
        endfunction: copy                                                     \
                                                                              \
        virtual function void set_range(TYPE low, TYPE high);                 \
            if (low <= high) begin                                            \
                this.l_low = low;                                             \
                this.l_high = high;                                           \
            end else begin                                                    \
                this.l_low = high;                                            \
                this.l_high = low;                                            \
            end                                                               \
        endfunction: set_range                                                \
                                                                              \
        virtual function TYPE get_low();                                      \
            return (this.l_low);                                              \
        endfunction: get_low                                                  \
                                                                              \
        virtual function TYPE get_high();                                     \
            return (this.l_high);                                             \
        endfunction: get_high                                                 \
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
            this.l_radix = radix;                                             \
        endfunction: set_radix                                                \
                                                                              \
        virtual function string get_radix();                                  \
            return (this.l_radix);                                            \
        endfunction: get_radix                                                \
    endclass: POLICY``_policy

// Policy constructor definition
`define m_range_policy_constructor(POLICY, TYPE, RADIX="%0p")                 \
    static function POLICY``_policy POLICY(                                   \
        TYPE   low,                                                           \
        TYPE   high=low,                                                      \
        bit    exclude=1'b0,                                                  \
        string radix=RADIX                                                    \
    );                                                                        \
        POLICY = new(low, high, exclude, radix);                              \
    endfunction: POLICY

`endif
