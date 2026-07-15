#!/usr/bin/env bash
set -euo pipefail

# ── Colors ──────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { printf "${GREEN}==>${NC} %s\n" "$*"; }
warn() { printf "${YELLOW}==>${NC} %s\n" "$*"; }
err()  { printf "${RED}==>${NC} %s\n" "$*" >&2; }

has_cmd() { command -v "$1" &>/dev/null; }

# ── Prerequisite check ────────────────────────────

PREREQS=(nvim git gcc rg fd unzip)

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
  for cmd in clangd lua-language-server basedpyright typescript-language-server stylua shfmt ruff flake8 markdownlint shellcheck debugpy prettier; do
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

# ── Main ──────────────────────────────────────────

usage() {
  cat <<EOF
Usage: bash install.sh [OPTION]

Options:
  --minimal       plugins only, skip Mason + lang scripts
  --lang <name>   run a language setup script (python, node)
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
    install_mason
    setup_path
    run_lang python 2>/dev/null || true
    run_lang node   2>/dev/null || true
    verify_mason
  fi

  log 'done!'
}

main "$@"
