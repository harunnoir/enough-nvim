#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────
# install.sh — user-level bootstrap for this config
# Installs Mason packages (LSPs, formatters, linters)
# and runs language-specific setup scripts.
#
# Pre-requisites (expected on system):
#   neovim, git, gcc, ripgrep, fd
#
# No sudo needed (except for prereqs above).
#
# Usage:
#   bash install.sh           — full install
#   bash install.sh --minimal — just plugins, skip extras
#   bash install.sh --lang python  — run lang script
# ──────────────────────────────────────────────────

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
NC='\033[0m'
log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() { command -v "$1" &>/dev/null; }

# ── Distro detection (for help messages) ──────────

detect_distro() {
    if has_cmd pacman; then echo 'arch'
    elif has_cmd apt; then echo 'debian'
    elif has_cmd dnf; then echo 'fedora'
    elif has_cmd xbps-install; then echo 'void'
    elif has_cmd brew; then echo 'macos'
    else echo 'unknown'
    fi
}

# ── Prerequisite check ────────────────────────────

PREREQS=(nvim git gcc rg fd)

check_prereqs() {
    local missing=()
    for cmd in "${PREREQS[@]}"; do
        if ! has_cmd "$cmd"; then
            missing+=("$cmd")
        fi
    done

    if ((${#missing[@]} > 0)); then
        err 'missing core tools needed for this config:'
        for cmd in "${missing[@]}"; do
            printf "  ${RED}✗${NC} %s\n" "$cmd"
        done
        echo ''
        err 'install them with:'
        case "$(detect_distro)" in
            arch)   err "  sudo pacman -S --needed ${missing[*]}" ;;
            debian) err "  sudo apt install ${missing[*]}" ;;
            fedora) err "  sudo dnf install ${missing[*]}" ;;
            void)   err "  sudo xbps-install ${missing[*]}" ;;
            macos)  err "  brew install ${missing[*]}" ;;
            *)
                for cmd in "${missing[@]}"; do
                    case "$cmd" in
                        nvim) err '  https://github.com/neovim/neovim/wiki/Installing-Neovim' ;;
                        git)  err '  https://git-scm.com/downloads' ;;
                        gcc)  err '  https://gcc.gnu.org/install/' ;;
                        rg)   err '  https://github.com/BurntSushi/ripgrep#installation' ;;
                        fd)   err '  https://github.com/sharkdp/fd#installation' ;;
                    esac
                done ;;
        esac
        exit 1
    fi
}

# ── User-level setup ──────────────────────────────

setup_path() {
    mkdir -p "$HOME/.local/bin" "$HOME/.npm-global/bin"
    if has_cmd npm && [ "$(npm config get prefix)" != "$HOME/.npm-global" ]; then
        npm config set prefix "$HOME/.npm-global"
    fi
    MASON_BIN="$HOME/.local/share/nvim/mason/bin"
    export PATH="$MASON_BIN:$HOME/.local/bin:$HOME/.npm-global/bin:$HOME/.cargo/bin:$PATH"
}

# ── Mason: install LSPs, formatters, linters ──────

MASON_PACKAGES=(
    # LSP servers
    pyright
    clangd
    lua-language-server
    typescript-language-server
    beancount-language-server
    # Formatters
    stylua
    ruff
    shfmt
    prettier
    # Linters
    flake8
    markdownlint
    shellcheck
    # DAP
    debugpy
)

install_mason_packages() {
    log 'installing plugins (lazy.nvim)…'
    nvim --headless '+Lazy! sync' +qa 2>/dev/null || true

    log 'installing Mason packages…'
    nvim --headless "+MasonInstall ${MASON_PACKAGES[*]}" +qa 2>/dev/null || true
}

verify_core() {
    local cmds=(
        nvim git gcc unzip rg fd
        clangd lua-language-server pyright
        typescript-language-server
        stylua shfmt prettier
        ruff flake8 markdownlint shellcheck debugpy
    )
    log 'verifying core installations…'
    local missing=()
    for cmd in "${cmds[@]}"; do
        if has_cmd "$cmd"; then
            printf "  ${GREEN}✓${NC} %s\n" "$cmd"
        else
            printf "  ${RED}✗${NC} %s\n" "$cmd"
            missing+=("$cmd")
        fi
    done
    if ((${#missing[@]} > 0)); then
        warn "some tools missing: ${missing[*]}"
    else
        log 'all tools present!'
    fi
}

run_lang_script() {
    local lang="$1"
    local script
    script="$(cd "$(dirname "$0")" && pwd)/lang/${lang}.sh"
    [ -f "$script" ] && bash "$script"
}

# ── Main ──────────────────────────────────────────

usage() {
    cat <<EOF
Usage: bash install.sh [OPTION]

Options:
  --minimal       just install plugins, skip Mason + lang scripts
  --lang <name>   run a specific language setup script and exit
  --help          show this help

Without options, installs plugins + Mason packages + Python/Node tools.
EOF
}

main() {
    local minimal_mode=false
    local lang_only=''

    while (($# > 0)); do
        case "$1" in
            --minimal) minimal_mode=true; shift ;;
            --lang) lang_only="$2"; shift 2 ;;
            --help) usage; exit 0 ;;
            *) err "unknown option: $1"; usage; exit 1 ;;
        esac
    done

    check_prereqs
    setup_path

    if [ -n "$lang_only" ]; then
        run_lang_script "$lang_only"
        exit $?
    fi

    if ! $minimal_mode; then
        install_mason_packages
        setup_path
        for lang in python node; do
            run_lang_script "$lang" 2>/dev/null || true
        done
        verify_core
    else
        log 'minimal — installing plugins only…'
        nvim --headless '+Lazy! sync' +qa 2>/dev/null || true
    fi

    log ''
    log 'done!'
}

main "$@"
