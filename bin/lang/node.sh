#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────
# lang/node.sh — Node.js/TypeScript extras
#
# Tools are installed via Mason by install.sh:
#   typescript-language-server, prettier
#
# Nothing extra needed here — kept as a placeholder
# for future Node-specific tooling.
# ──────────────────────────────────────────────────

log()  { printf "==> %s\n" "$*"; }

main() {
    log 'Node.js tools are managed by Mason — nothing extra to install.'
}

main "$@"
