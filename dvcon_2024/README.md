The paper is written in LaTeX and uses the minted package and a custom pygments plugin for syntax coloring.

Make sure the submodule is in place:

```
git submodule init
git submodule update
```

Then install the plugins locally:

```
cd pygments-plugin-systemverilog
python -m venv venv
venv/bin/pip install .
```

When running `latexmk`, make sure to add the `-shell-escape` flag.