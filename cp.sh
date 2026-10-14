#!/bin/bash
# Install mcode through the mcc content-addressed store (the copy face is
# retired; the store walk applies the working-tree exclusions itself).
# mcode installs into the global data root, so this runs from anywhere.
exec mcc lib install mcode --from "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
