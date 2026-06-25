#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────
# bootstrap.sh — install everything for this config
# ──────────────────────────────────────────────────
# Detects: arch, debian, fedora, void
# Installs: neovim, LSPs, formatters, deps
# ──────────────────────────────────────────────────

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; NC='\033[0m'
log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() { command -v "$1" &>/dev/null; }

detect_distro() {
    if has_cmd pacman; then
        echo 'arch'
    elif has_cmd apt; then
        echo 'debian'
    elif has_cmd dnf; then
        echo 'fedora'
    elif has_cmd xbps-install; then
        echo 'void'
    else
        err 'unsupported distro — only Arch/Debian/Fedora/Void supported'
        exit 1
    fi
}

# ── System packages ────────────────────────────────

install_system_arch() {
    sudo pacman -S --needed --noconfirm \
        neovim git gcc unzip ripgrep fd \
        clang lua-language-server \
        stylua shfmt \
        python python-pip python-pipx \
        nodejs npm \
        wl-clipboard xclip
}

install_system_debian() {
    sudo apt update
    sudo apt install -y \
        neovim git gcc unzip ripgrep fd-find \
        clangd lua-language-server \
        python3 python3-pip python3-venv \
        nodejs npm \
        wl-clipboard xclip
    # shfmt not in all repos, install via snap/go
    if ! has_cmd shfmt; then
        if has_cmd snap; then
            sudo snap install shfmt
        else
            warn 'shfmt not available via apt — skipping (install manually)'
        fi
    fi
    # stylua not in Debian repos, get binary
    if ! has_cmd stylua; then
        log 'installing stylua via cargo...'
        if ! has_cmd cargo; then
            sudo apt install -y cargo
        fi
        cargo install stylua
    fi
}

install_system_fedora() {
    sudo dnf install -y \
        neovim git gcc unzip ripgrep fd-find \
        clang-tools-extra lua-language-server \
        python3 python3-pip python3-pipx \
        nodejs npm \
        wl-clipboard xclip
    # stylua / shfmt
    if ! has_cmd stylua; then
        if ! has_cmd cargo; then
            sudo dnf install -y cargo
        fi
        cargo install stylua
    fi
    if ! has_cmd shfmt; then
        sudo dnf install -y shfmt 2>/dev/null || warn 'shfmt not in dnf repos — skipping'
    fi
}

install_system_void() {
    sudo xbps-install -Syu
    sudo xbps-install -y \
        neovim git gcc unzip ripgrep fd \
        clang lua-language-server \
        python3 python3-pip \
        nodejs npm \
        wl-clipboard xclip
    if ! has_cmd stylua; then
        if ! has_cmd cargo; then
            sudo xbps-install -y cargo
        fi
        cargo install stylua
    fi
    if ! has_cmd shfmt; then
        sudo xbps-install -y shfmt 2>/dev/null || warn 'shfmt not in void repos — skipping'
    fi
}

# ── NPM packages (LSPs + formatters) ────────────────

install_npm_packages() {
    local packages=()
    has_cmd pyright            || packages+=(pyright)
    has_cmd typescript-language-server || packages+=(typescript-language-server)
    has_cmd prettier           || packages+=(prettier)

    if ((${#packages[@]} > 0)); then
        log "installing npm packages: ${packages[*]}..."
        npm install -g "${packages[@]}"
    fi
}

# ── PIP packages (Neovim Python provider + tools) ──

install_pip_packages() {
    local pip="pip3"
    if has_cmd pipx; then
        pip="pipx"
    fi

    # pynvim — required by Neovim's Python provider for :python3
    if ! python3 -c 'import pynvim' 2>/dev/null; then
        log 'installing pynvim (Neovim Python provider)...'
        if has_cmd pipx; then
            pipx install pynvim
        else
            $pip install --user pynvim
        fi
    fi

    if ! has_cmd ruff; then
        log 'installing ruff...'
        if has_cmd pipx; then
            pipx install ruff
        else
            $pip install --user ruff
        fi
    fi

    if ! has_cmd flake8; then
        log 'installing flake8...'
        if has_cmd pipx; then
            pipx install flake8
        else
            $pip install --user flake8
        fi
    fi
}

# ── Main ──────────────────────────────────────────

main() {
    local distro
    distro=$(detect_distro)
    log "detected: ${distro}"

    case "$distro" in
        arch)   install_system_arch   ;;
        debian) install_system_debian ;;
        fedora) install_system_fedora ;;
        void)   install_system_void   ;;
    esac

    install_npm_packages
    install_pip_packages

    # Ensure PATH includes ~/.local/bin and ~/.cargo/bin
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

    # Final verification
    local cmds=(
        nvim git gcc unzip rg fd
        clangd lua-language-server
        pyright typescript-language-server
        stylua ruff shfmt prettier flake8
    )
    local python_mods=(pynvim)
    log 'verifying installations...'
    local missing=()
    for cmd in "${cmds[@]}"; do
        if has_cmd "$cmd"; then
            printf "  ${GREEN}✓${NC} %s\n" "$cmd"
        else
            printf "  ${RED}✗${NC} %s\n" "$cmd"
            missing+=("$cmd")
        fi
    done
    for mod in "${python_mods[@]}"; do
        if python3 -c "import $mod" 2>/dev/null; then
            printf "  ${GREEN}✓${NC} python3 -c 'import %s'\n" "$mod"
        else
            printf "  ${RED}✗${NC} python3 -c 'import %s'\n" "$mod"
            missing+=("python:$mod")
        fi
    done

    if ((${#missing[@]} > 0)); then
        warn "some tools are missing: ${missing[*]}"
        warn 'you may need to install them manually or adjust PATH'
    else
        log 'all tools installed!'
    fi

    # Install/update lazy.nvim plugins
    log 'running nvim headless to install plugins...'
    nvim --headless '+Lazy! sync' +qa 2>/dev/null || true

    log 'done!'
}

main "$@"
