#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────
# lang/c.sh — C / 42 school extras
#
# C tools installed via Mason by install.sh:
#   clangd (LSP), c_formatter_42 (conform formatter)
#
# This script covers what Mason can't:
#   norminette   — 42 header/style checker
#   c_formatter_42 — 42 formatting rules (pip package)
#
# No sudo required.
# ──────────────────────────────────────────────────

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
NC='\033[0m'
log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() { command -v "$1" &>/dev/null; }

check_prereqs() {
    if ! has_cmd gcc; then
        err 'gcc is required for C development'
        err '  sudo pacman -S gcc  (or equivalent for your distro)'
        exit 1
    fi
    if ! has_cmd python3; then
        err 'python3 is required (needed by norminette and c_formatter_42)'
        exit 1
    fi
}

install_tools() {
    # Bootstrap pipx if not available
    if ! has_cmd pipx && python3 -m pip --version &>/dev/null; then
        python3 -m pip install --user pipx 2>/dev/null || true
        export PATH="$HOME/.local/bin:$PATH"
    fi

    if has_cmd pipx; then
        has_cmd norminette || {
            log 'installing norminette (42 header checker)…'
            pipx install norminette
        }
        has_cmd c_formatter_42 || {
            log 'installing c_formatter_42 (42 code formatter)…'
            pipx install c_formatter_42
        }
    else
        warn 'pipx unavailable — install norminette and c_formatter_42 manually'
        warn '  pip install --user norminette c_formatter_42'
    fi
}

verify() {
    log 'verifying C extras…'
    local tools=(norminette c_formatter_42)
    local missing=()
    for cmd in "${tools[@]}"; do
        if has_cmd "$cmd"; then
            printf "  ${GREEN}✓${NC} %s\n" "$cmd"
        else
            printf "  ${RED}✗${NC} %s\n" "$cmd"
            missing+=("$cmd")
        fi
    done
    if has_cmd clangd; then
        printf "  ${GREEN}✓${NC} clangd (LSP)\n"
    else
        printf "  ${RED}✗${NC} clangd (LSP) — install via Mason\n"
    fi
    if ((${#missing[@]} > 0)); then
        warn "missing: ${missing[*]}"
    else
        log 'C extras ready!'
    fi
}

main() {
    check_prereqs
    log 'setting up C / 42 school extras…'
    install_tools
    verify
}

main "$@"
