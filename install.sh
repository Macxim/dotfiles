#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  install.sh — one-shot bootstrap for a fresh Mac (Apple Silicon).
#
#  Usage (after cloning the repo):
#      cd ~/.dotfiles && ./install.sh
#
#  Safe to re-run: every step is idempotent.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREW_PREFIX="/opt/homebrew"   # Apple Silicon

info()  { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
ok()    { printf "\033[1;32m ✓ \033[0m%s\n" "$1"; }

# ── 1. Xcode Command Line Tools ──────────────────────────────────────────────
if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools…"
  xcode-select --install
  echo "Finish the CLT installer, then re-run ./install.sh"
  exit 0
fi
ok "Xcode Command Line Tools present"

# ── 2. Homebrew ──────────────────────────────────────────────────────────────
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$("$BREW_PREFIX/bin/brew" shellenv)"
ok "Homebrew ready ($(brew --version | head -1))"

# ── 3. Install everything from the Brewfile ──────────────────────────────────
info "Installing packages from Brewfile (this is the long part)…"
brew bundle --file="$DOTFILES_DIR/Brewfile"
ok "Brewfile applied"

# ── 4. Apply dotfiles with chezmoi ───────────────────────────────────────────
# chezmoi reads .chezmoiroot -> home/ as its source. The .chezmoi.toml.tmpl
# prompts once for name + personal/work email, then renders .gitconfig etc.
info "Applying dotfiles with chezmoi…"
chezmoi init --source "$DOTFILES_DIR" --apply
ok "Dotfiles applied"

# ── 5. macOS system defaults ─────────────────────────────────────────────────
info "Writing macOS defaults (you'll be asked for your password)…"
"$DOTFILES_DIR/macos.sh"
ok "macOS defaults written"

# ── 6. GitHub auth (manual, interactive) ─────────────────────────────────────
if ! gh auth status >/dev/null 2>&1; then
  info "Authenticate GitHub now (HTTPS + browser, then it sets up git):"
  echo "    gh auth login && gh auth setup-git"
  echo "    (For the YouAble org, authorize SAML SSO in the browser prompt.)"
fi

echo
ok "Done. Open a new terminal tab so the shell config loads."
echo "   Node: run  fnm install --lts  to get your first Node version."
