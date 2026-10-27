#!/bin/sh
# The repository-level release command.
#
# One command per repository: read the release contract, make the
# artifact, attach the manifest, pass the batch gate, carry it to the
# channel.  The scripts in this repository are the parts of that command,
# not the command itself.
#
# The workspace root is an environment fact, never a path written here:
#
#     MCC_WORKSPACE_ROOT=/path/to/workspace scripts/release.sh
#
set -eu

: "${MCC_WORKSPACE_ROOT:?the workspace root must be given: MCC_WORKSPACE_ROOT}"

exec mcgen-release package --package mcode --workspace "$MCC_WORKSPACE_ROOT"
