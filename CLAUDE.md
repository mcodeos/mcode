# mcode rules

## No third-party names (mandatory)

Never mention any third-party company name, product name, or part/model
number anywhere in this repo — not in `.mc` identifiers, comments, doc
strings, parameter names, or READMEs. Abstract shapes are named by function,
and datasheet provenance belongs in mcpub packs, not here.

## No chip documents (mandatory)

This repo must not contain any chip-specific datasheets, schematics, or
other manufacturer documents (PDFs, vendor .txt dumps, source EDA files).
Abstract shapes carry pinout/behavior comments only; the underlying
documents live in the corresponding mcpub packs. For the same reason,
comments must not cite document locations (page numbers, tables, figures,
sections) — no `p.3`, `Table 5-1`, `Figure 8` style references; that
evidence trail lives in the mcpub packs, not here.

## No cross-repo or internal-design references (mandatory)

This repo is a standalone public library: it must not reference, mention,
or depend on any other repo — no `mcpub` pointers, no `mclibs`/`mcd`
mentions, no paths into sibling projects. It must also not cite internal
design material: no design documents, no design clauses or rulings
("ruling 12" style), no issue/decision numbers (`b4532` style), no
`U###` witness IDs. Comments state the law itself, never where the law
came from.

## Comments are structural only (mandatory)

`.mc` comments carry structure, not explanation: the definition header
(below) plus short structural labels (`// UH <-> INHA`). No explanatory
paragraphs, no design rationale, no provenance — the shapes stand on
their own. **Exception:** trailing `Usage Examples` blocks are allowed
(usage is part of a public shape's face). They still obey every other
rule — no third-party names, no document citations, no internal design
or issue references.

Comment markers follow the same split as the header law: `//` for all
body comments (definition headers, structural labels, inline), `#` only
inside the 2-line file-header template. `//` and `#` are lexically
equivalent, but tooling strips leading-`#` lines as non-content, so `#`
must not carry body comments.

## Definition header style (mandatory)

Every `interface`/`component` definition is preceded by a Standard
Definition header. Spacing is uniform: exactly one blank line between
the previous block and the header, and exactly one blank line between
the header and the definition:

```text
// <NAME> - <Full Name> (<variant>) Standard Definition
// Core Rule: <the defining electrical/protocol law, 1-3 lines>
// Device Definition: TRANSMITTER = <source>,
//                    RECEIVER = <sink>
```

- Role-less interfaces drop the Device Definition line.
- Components use `// <NAME> - <what it models> Component Definition`
  plus an optional Core Rule line.
- An optional `// Note:` line is allowed for structural constraints
  (enum grouping, canonical pin order) only.
- Continuation lines align under the tagged line.

## Writing conventions

Long string literals (descriptions, pin help) wrap across source lines
instead of producing very long one-line strings — the grammar accepts
multi-line strings. Continuation lines start at column 0: indentation
would become part of the string value.

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
fails the commit if any tracked `.mc` deviates from the template, and if
any staged file carries a document page reference (`p.27`, `pp.1/25`).
