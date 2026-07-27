#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────
# lang/python.sh — Python extras Mason can't handle
#
# Python tools are installed via Mason by install.sh:
#   basedpyright, ruff, flake8, debugpy
#
# This script covers what Mason can't:
#   pynvim     — Neovim Python provider
#   pytest     — test runner (global, via `uv tool`)
#   uv         — fast package manager (bootstraps itself)
#   ipython    — enhanced Python REPL
#   ptpython   — modern REPL
#   ptipython  — ptpython + IPython (via `uv tool` inject-equivalent)
#
# No sudo required. No pipx — uv covers the same job
# and you already use uv as your primary manager.
# ──────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() {
    command -v "$1" >/dev/null 2>&1
}

detect_distro() {
    if has_cmd pacman; then
        echo arch
    elif has_cmd apt; then
        echo debian
    elif has_cmd dnf; then
        echo fedora
    elif has_cmd xbps-install; then
        echo void
    elif has_cmd brew; then
        echo macos
    else
        echo unknown
    fi
}

check_prereqs() {
    # We only need a system python3 to exist so `uv venv` has a base
    # interpreter to link against. No pip required anywhere — uv
    # manages its own packages and venvs independently of pip.
    if has_cmd python3; then
        PYTHON=python3
    elif has_cmd python; then
        PYTHON=python
    else
        err "Python is required."
        case "$(detect_distro)" in
            arch)   err "  sudo pacman -S python" ;;
            debian) err "  sudo apt install python3" ;;
            fedora) err "  sudo dnf install python3" ;;
            void)   err "  sudo xbps-install python3" ;;
            macos)  err "  brew install python" ;;
            *)      err "  https://www.python.org/downloads/" ;;
        esac
        exit 1
    fi
}

install_uv() {
    if has_cmd uv; then
        return
    fi

    log "installing uv..."
    if has_cmd curl; then
        if ! curl -LsSf https://astral.sh/uv/install.sh | sh; then
            err "uv install script failed."
            exit 1
        fi
    else
        "$PYTHON" -m pip install --user -U uv || {
            err "uv installation failed (pip fallback)."
            exit 1
        }
    fi

    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

    if ! has_cmd uv; then
        err "uv installed but not found on PATH. Restart shell or add ~/.local/bin to PATH."
        exit 1
    fi
}

install_pynvim() {
    if "$PYTHON" -c 'import pynvim' >/dev/null 2>&1; then
        return
    fi
    log "installing pynvim..."
    "$PYTHON" -m pip install --user -U pynvim || {
        err "pynvim installation failed."
        exit 1
    }
}

# Installs a global CLI tool via `uv tool install`, idempotent.
install_uv_tool() {
    local tool="$1"
    shift || true
    local extra_args=("$@")

    if has_cmd "$tool"; then
        return
    fi

    log "installing ${tool}..."
    if ! uv tool install "${extra_args[@]:-$tool}" >/dev/null 2>&1; then
        err "failed to install ${tool} via uv tool install"
        exit 1
    fi
}

install_ptipython() {
    # ptipython = ptpython built with the ipython extra.
    # uv tool install supports extras via package[extra] syntax.
    if has_cmd ptipython; then
        return
    fi
    log "installing ptipython (ptpython[ipython])..."
    if ! uv tool install "ptpython[ipython]" --force >/dev/null 2>&1; then
        err "failed to install ptipython"
        exit 1
    fi
}

verify() {
    log "verifying Python extras..."

    local tools=(
        pytest
        uv
        ipython
        ptpython
        ptipython
    )

    local missing=()

    for cmd in "${tools[@]}"; do
        if has_cmd "$cmd"; then
            printf "  ${GREEN}✓${NC} %s\n" "$cmd"
        else
            printf "  ${RED}✗${NC} %s\n" "$cmd"
            missing+=("$cmd")
        fi
    done

    if "$PYTHON" -c 'import pynvim' >/dev/null 2>&1; then
        printf "  ${GREEN}✓${NC} pynvim (importable)\n"
    else
        printf "  ${RED}✗${NC} pynvim (not importable)\n"
        missing+=("pynvim")
    fi

    if ((${#missing[@]})); then
        warn "Missing: ${missing[*]}"
        return 1
    else
        log "Python extras ready!"
    fi
}

main() {
    check_prereqs
    install_uv

    log "setting up Python extras..."

    install_pynvim
    install_uv_tool pytest
    install_uv_tool ipython
    # uv keys tool envs by package name — installing ptpython[ipython]
    # IS the ptpython install (with the ipython extra baked in), so a
    # separate bare `ptpython` install would just get overwritten. Skip it.
    install_ptipython

    verify
}

main "$@"
