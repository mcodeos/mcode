# mcode rules

## File header law (mandatory)

Every `.mc` file **opens with** this exact 2-line template — and nothing else
before it:

```text
# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.
```

- mcode is all-MCode: no third-party clause (that line exists only in mcs).
- After the template: one blank line, then the file's own content.

## Enforcement

`.githooks/pre-commit` (activate: `git config core.hooksPath .githooks`)
fails the commit if any tracked `.mc` deviates from the template.
