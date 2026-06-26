#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────
# lang/python.sh — Python extras Mason can't handle
#
# Python tools are installed via Mason by install.sh:
#   pyright, ruff, flake8, debugpy
#
# This script covers what Mason can't:
#   pynvim   — needs pip install --user (importable)
#   pytest   — test runner
#   uv       — fast Python package manager
#
# No sudo required.
# ──────────────────────────────────────────────────

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
NC='\033[0m'
log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() { command -v "$1" &>/dev/null; }

detect_distro() {
    if has_cmd pacman; then echo 'arch'
    elif has_cmd apt; then echo 'debian'
    elif has_cmd dnf; then echo 'fedora'
    elif has_cmd xbps-install; then echo 'void'
    elif has_cmd brew; then echo 'macos'
    else echo 'unknown'
    fi
}

check_prereqs() {
    if ! has_cmd python3; then
        err 'python3 is required'
        case "$(detect_distro)" in
            arch)   err '  sudo pacman -S python' ;;
            debian) err '  sudo apt install python3' ;;
            fedora) err '  sudo dnf install python3' ;;
            void)   err '  sudo xbps-install python3' ;;
            macos)  err '  brew install python' ;;
            *)      err '  https://www.python.org/downloads/' ;;
        esac
        exit 1
    fi
}

install_tools() {
    # pynvim — must be in user site-packages, NOT pipx
    if ! python3 -c 'import pynvim' 2>/dev/null; then
        log 'installing pynvim (Neovim Python provider)…'
        if python3 -m pip --version &>/dev/null; then
            python3 -m pip install --user pynvim
        else
            python3 -m ensurepip --user 2>/dev/null || true
            python3 -m pip install --user pynvim 2>/dev/null || warn 'pip unavailable — install pynvim manually'
        fi
    fi

    # Bootstrap pipx for optional tools
    if ! has_cmd pipx && python3 -m pip --version &>/dev/null; then
        python3 -m pip install --user pipx 2>/dev/null || true
        export PATH="$HOME/.local/bin:$PATH"
    fi

    if has_cmd pipx; then
        has_cmd pytest || { log 'installing pytest…'; pipx install pytest; }
        has_cmd uv     || { log 'installing uv…';     pipx install uv; }
    fi
}

verify() {
    log 'verifying Python extras…'
    local tools=(pytest uv)
    local missing=()
    for cmd in "${tools[@]}"; do
        if has_cmd "$cmd"; then
            printf "  ${GREEN}✓${NC} %s\n" "$cmd"
        else
            printf "  ${RED}✗${NC} %s\n" "$cmd"
            missing+=("$cmd")
        fi
    done
    if python3 -c 'import pynvim' 2>/dev/null; then
        printf "  ${GREEN}✓${NC} pynvim (importable)\n"
    else
        printf "  ${RED}✗${NC} pynvim (not importable)\n"
        missing+=('pynvim')
    fi
    if ((${#missing[@]} > 0)); then
        warn "missing: ${missing[*]}"
    else
        log 'Python extras ready!'
    fi
}

main() {
    check_prereqs
    log 'setting up Python extras…'
    install_tools
    verify
}

main "$@"
