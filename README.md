# policy_pkg
SystemVerilog policies package

The `dvcon_2024` directory contains the DVCon paper on this package, while the `policy_pkg` directory contains the actual package that can be used in your project.

To begin using, include the policy macros wherever necessary so they are in the scope of your classes that will make use of them, and import or compile the policy_pkg into your work library:

```sv
`include "policy_macros.svh"

package system_pkg;
  import policy_pkg::*;
  // other system package contents
endpackage
```
