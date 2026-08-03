#!/usr/bin/env bash
set -euo pipefail

# ── Colors ──────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() { command -v "$1" &>/dev/null; }

# ── Prerequisite check ────────────────────────────

PREREQS=(nvim git gcc unzip python3 node curl)

check_prereqs() {
  local missing=()
  for cmd in "${PREREQS[@]}"; do
    has_cmd "$cmd" || missing+=("$cmd")
  done

  if ((${#missing[@]} > 0)); then
    err "missing core tools: ${missing[*]}"
    if has_cmd apt; then        err "  sudo apt install ${missing[*]}"
    elif has_cmd pacman; then   err "  sudo pacman -S --needed ${missing[*]}"
    elif has_cmd dnf; then      err "  sudo dnf install ${missing[*]}"
    elif has_cmd xbps-install; then err "  sudo xbps-install ${missing[*]}"
    elif has_cmd brew; then     err "  brew install ${missing[*]}"
    fi
    exit 1
  fi

  # gdb is needed for dap debugging but can't be installed without sudo
  if ! has_cmd gdb; then
    warn "gdb not found — needed for debugging (dap). Install with:"
    if has_cmd pacman; then   warn "  sudo pacman -S gdb"
    elif has_cmd apt; then    warn "  sudo apt install gdb"
    elif has_cmd dnf; then    warn "  sudo dnf install gdb"
    elif has_cmd brew; then   warn "  brew install gdb"
    fi
  fi
}

# ── Mason: LSPs, formatters, linters ──────────────

MASON_PACKAGES=(
  basedpyright clangd lua-language-server typescript-language-server beancount-language-server
  stylua ruff shfmt prettier
  flake8 markdownlint shellcheck
  debugpy
)

install_mason() {
  log 'installing plugins (lazy.nvim)…'
  nvim --headless '+Lazy! sync' +qa 2>/dev/null || true

  log 'installing Mason packages…'
  nvim --headless "+MasonInstall ${MASON_PACKAGES[*]}" +qa 2>/dev/null || true
}

verify_mason() {
  local mason_bin="$HOME/.local/share/nvim/mason/bin"
  local missing=()
  for cmd in basedpyright clangd lua-language-server typescript-language-server beancount-language-server \
             stylua ruff shfmt prettier flake8 markdownlint shellcheck debugpy; do
    if [ -x "$mason_bin/$cmd" ]; then
      printf "  ${GREEN}✓${NC} %s\n" "$cmd"
    else
      printf "  ${RED}✗${NC} %s\n" "$cmd"
      missing+=("$cmd")
    fi
  done
  ((${#missing[@]} > 0)) && warn "missing: ${missing[*]}" || log 'all Mason tools present!'
}

# ── Lang scripts ──────────────────────────────────

run_lang() {
  local lang="$1"
  local script
  script="$(cd "$(dirname "$0")" && pwd)/lang/${lang}.sh"
  [ -f "$script" ] && bash "$script" || warn "no script for: $lang"
}

# ── User paths (for pipx, cargo, etc.) ───────────

setup_path() {
  mkdir -p "$HOME/.local/bin"
  export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
}

install_core_tools() {
  log "installing core tools (ripgrep, fd) without sudo..."

  local bin_dir="$HOME/.local/bin"
  mkdir -p "$bin_dir"

  local arch
  arch="$(uname -m)"

  local rg_arch fd_arch
  case "$arch" in
    x86_64)  rg_arch="x86_64"; fd_arch="x86_64" ;;
    aarch64|arm64) rg_arch="aarch64"; fd_arch="aarch64" ;;
    armv7l)  rg_arch="armv7"; fd_arch="armv7" ;;
    *)       err "unsupported architecture: $arch"; return 1 ;;
  esac

  local os
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  [[ "$os" == "linux" ]] || { err "unsupported OS: $os"; return 1; }

  install_from_github() {
    local repo="$1" version="$2" name="$3" arch="$4"
    local url="https://github.com/${repo}/releases/download/${version}/${name}-${version}-${arch}-unknown-linux-musl.tar.gz"
    local tmp
    tmp="$(mktemp -d)"

    if ! curl -fsSL "$url" -o "$tmp/pkg.tar.gz" 2>/dev/null; then
      warn "failed to download $name from $url"
      rm -rf "$tmp"
      return 1
    fi

    tar -xzf "$tmp/pkg.tar.gz" -C "$tmp" 2>/dev/null || {
      warn "failed to extract $name"
      rm -rf "$tmp"
      return 1
    }

    local binary
    binary="$(find "$tmp" -type f -name "$name" ! -name "*.tar.gz" | head -n1)"
    if [ -z "$binary" ]; then
      warn "$name binary not found in archive"
      rm -rf "$tmp"
      return 1
    fi

    cp "$binary" "$bin_dir/$name"
    chmod +x "$bin_dir/$name"
    rm -rf "$tmp"
  }

  install_from_github "BurntSushi/ripgrep" "14.1.1" "rg" "$rg_arch" || true
  install_from_github "sharkdp/fd" "10.2.0" "fd" "$fd_arch" || true

  export PATH="$bin_dir:$PATH"
}

# ── Main ──────────────────────────────────────────

usage() {
  cat <<EOF
Usage: bash install.sh [OPTION]

Options:
  --minimal       plugins only, skip Mason + lang scripts
  --lang <name>   run a language setup script (python, c, node)
  --help          show this help
EOF
}

main() {
  local minimal=false lang_only=''

  while (($# > 0)); do
    case "$1" in
      --minimal) minimal=true; shift ;;
      --lang)    lang_only="$2"; shift 2 ;;
      --help)    usage; exit 0 ;;
      *)         err "unknown: $1"; usage; exit 1 ;;
    esac
  done

  check_prereqs

  if [ -n "$lang_only" ]; then
    run_lang "$lang_only"; exit $?
  fi

  if $minimal; then
    log 'minimal — plugins only…'
    nvim --headless '+Lazy! sync' +qa 2>/dev/null || true
  else
    install_core_tools
    install_mason
    setup_path
    run_lang python 2>/dev/null || true
    run_lang c      2>/dev/null || true
    run_lang node   2>/dev/null || true
    verify_mason
  fi

  log 'done!'
}

main "$@"
